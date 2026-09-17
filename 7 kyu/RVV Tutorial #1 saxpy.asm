# -----------------------------------------------------------
# (This kata is a part of the RVV Tutorial series, where you can learn to
# write assembly code using RISC-V V extension and vectorize your loops.
# Familiarity with C and (scalar) RISC-V assembly is assumed. See more 
# in the RVV Tutorial collection.)
# 
# Goal: You're given two arrays x and y both with length len, and 
# a number a. Calculate c[i] = a * x[i] + y[i] for each element 
# from x and y.
# 
# The elements and a are all single-precision floats. The computation 
# for each element a * x[i] + y[i] must be rounded only once, as would 
# have been calculated with the C function fmaf. Tests will use 
# exact comparisons.
# 
# Signature in C as follows. Write result to array c. There's no need 
# to allocate the output array yourself.
# 
# void saxpy(
#   size_t len,
#   float a, const float *x, const float *y,
#   float * restrict c
# );
# 
# (Note: Hence the function name: Single-precision A*X Plus Y.)
# 
# Introduction to vector processing
# Welcome to RISC-V vectors! Vector processing is a style of data
# processing that deals with (usually pretty long) one-dimensional 
# arrays called vectors.
# 
# The idea is that since many loops perform the same operations 
# to each element in a vector independently, they waste many 
# instructions and time on controlling the loop. For example, in this loop:
# 
# float a, x[], y[], c[];
# 
# for (size_t i = 0; i != len; i ++)
#     c[i] = a * x[i] + y[i];
# 
# Only around half of the instructions in this loop actually deals 
# with the array elements. The rest of the loop is time spent 
# counting the loop and bumping pointers.
# 
# We could add a dedicated piece of control logic that feeds elements 
# from memory to the computation hardware and back to memory 
# as fast as possible. This way, no time is wasted on loop control. 
# In addition, since the operations on each element are independent, 
# the whole process could be pipelined (vector chaining).
# 
# Imagine we could write vector code like this:
# 
# c[0..len] = a * x[0..len] + y[0..len]
# 
# And let the processor (hypothetically) process it like this:
# 
# Cycle 1: load x[0]
# Cycle 2: load y[0]
# Cycle 3: load x[1]    compute (a * x[0] + y[0])
# Cycle 4: load y[1]                                store (a * x[0] + y[0]) to c[0]
# Cycle 5: load x[2]    compute (a * x[1] + y[1])
# Cycle 6: load y[2]                                store (a * x[1] + y[1]) to c[0]
# ...
# 
# Spending only approximately 2 * len cycles for the entire loop, 
# wasting no time on counting. It's even possible to add multiple 
# lanes so that 4 or 8 operations can happen in parallel, speeding 
# it up by multiples beyond what the original (scalar) code can 
# imagine. All without changing the vector code at all.
# 
# Vector registers and stripmining
# Alas there is a problem with the arbitrary vector length len: 
# memory accesses. Most of the time, we do more than a single 
# operation at a time on vectors, and since memory is slow, it 
# is wasteful to have each operation load operands from memory, 
# do the computation, and store it back.
# 
# The solution is to use finitely sized vector registers and 
# use stripmining to process longer data. For example, each 
# vector register might be 128 bits and fit 4 floats. We still 
# need a loop, but now we process up to 4 elements each iteration. 
# A special register vl specifies the number of elements 
# to actually process. To process 10 elements for example, you'd 
# use three iterations:
# 
# vl = 4; vx = x[0..3]; vy = y[0..3]; vc = a * vx + vy; c[0..3] = vc;
# vl = 4; vx = x[4..7]; vy = y[4..7]; vc = a * vx + vy; c[4..7] = vc;
# vl = 2; vx = x[8..9]; vy = y[8..9]; vc = a * vx + vy; c[8..9] = vc;
# 
# Now we've added back loop control, but since we process much 
# more elements per iteration, the overhead is much smaller. 
# The longer the vector registers, the lower the overhead would be.
# 
# (For context, this idea isn't new. The supercomputer Cray-1 from 
# the 1970s had vector registers and stripmining and was able to per
# form much better than competitors because of this.)
# 
# (Note: The actual parallelism in each vector register operation may 
# be different from the number of elements in it. For example, 
# for different procesors implementing the same-sized vector 
# registers, a performant one with more pipelines and vector 
# register renaming might be able to process multiple vector 
# registers in parallel, while a smaller one might only perform 
# one float operation per cycle. Both would likely benefit from 
# the reduced loop-control overhead.)
# 
# Stripmining in RVV
# For the RISC-V V extensions, there's a special instruction for writing 
# stripmining loops, vsetvli:
# 
# vsetvli rd, rs1, e_, m_, t_, m_
# For the basic use case, neither rd nor rs1 is x0/zero. eN means working with 
# N-bit elements, which can be e8, e16, e32, e64. The rest do not matter 
# for now; just specify m1, ta, ma.
# 
# The value in rs1, known as AVL, is the total number of remaining to 
# be processed. This instruction will set up the element size and set 
# vl to a number of elements to process this iteration, and also return it in rd.
# 
# For our loop, float is 32-bits. Suppose len is in register a0, then
# 
# vsetvli t0, a0, e32, m1, ta, ma
# Will set t0 and vl to some value not greater than len. At the end of the 
# loop, we'd subtract len by vl to get new number of elements remaining, 
# and if that's still greater than zero, loop back.
# 
# (Note: vl is usually set to the maximum number of elements not greater than 
# AVL that will fit in vector registers, but implementations may try to equalize 
# vl for the last two iterations to minimize time wasted on processing with 
# a very small vl for the last iteration. Remember, larger vl means lower 
# loop overhead. Just trust the result from vsetvli)
# 
# Our function usually ends up looking like this:
# 
# stripmining_example:
# 
# 1:
#   vsetvli t0, a0, e32, m1, ta, ma
#   ...
#   sub a0, a0, t0
#   bnez a0, 1b
#   
#   ret
# 
# (Note: In general, the edge case AVL = 0 isn't a problem with vsetvli.)
# 
# Vector registers and instructions
# The vector registers are named v0 through v31. (Note: Like f0, but unlike x0, 
# the vector register v0 is not fixed all-zeros).
# 
# The computation instructions operate on the elements of vector registers 
# in parallel and are written like:
# 
# v{operation}.{operand types}
# 
# The element size is not specified in the instruction and is instead configured 
# with vsetvli. As an example, there are two instructions for floating 
# point addition:
# 
# vfadd.vv vd, vs2, vs1   # vd[i] = vs2[i] + vs1[i]
# vfadd.vf vd, vs2, rs1   # vd[i] = vs2[i] + f[rs1]
# 
# (i goes from 0 up to but not including the current vl)
# 
# An example of vfadd.vf could look like this:
# 
# vfadd.vf v8, v16, fa0
# The operand type can be:
# 
# v for vector register
# x for integer register
# f for floating point register
# ...
# Unlike integer and floating point instructions, some vector 
# instructions may both read and write to their destination:
# 
# vfmadd.vv vd, vs1, vs2    # vd[i] = +(vs1[i] * vd[i]) + vs2[i]
# vfmadd.vf vd, rs1, vs2    # vd[i] = +(f[rs1] * vd[i]) + vs2[i]
# 
# The vector load and store instructions do specify the element size 
# and ignore the one specified in vsetvli. The element size, as before, 
# can be one of 8, 16, 32, 64:
# 
# vle32.v vd, (rs1)     # Load vl 32-bit elements to vd from address starting at rs1
# vse32.v vs3, (rs1)    # Store vl 32-bit elements from vs3 to address starting at # rs1
# 
# Let's go back to the first iteration of our example
# 
# vl = 4; vx = x[0..3]; vy = y[0..3]; vc = a * vx + vy; c[0..3] = vc;
# ...
# 
# We can see that the general framework for an iteration of 
# a vectorized loop is:
# 
# Load vl elements from memory, possibly from multiple sources
# Run computations in vector registers
# Store the results back to memory
# Fill it in with actual instructions, and you're done!
# 
# Hints
# Which registers are each of the parameters stored in?
# Which instruction implements fmaf for scalars? For vectors? 
# (The vector one was shown above!)
# Besides the obvious load, compute, store, is there anything 
# else missing in the TODO section?
# 
# A note on calling convention
# The vector registers v0 through v31, and the vector configurations 
# set by vsetvli are not saved across function calls. This means you 
# can use all the vector registers as you please, as long as you don't 
# call any other procedures in the middle of the loop.
# -----------------------------------------------------------

.section .text
    .globl saxpy
    
# void saxpy(size_t len, float a, const float *x, const float *y, float * restrict c)
#
# a0 = len (number of elements)
# fa0 = a (scalar float multiplier)
# a1 = x (input array pointer, float)
# a2 = y (input array pointer, float)
# a3 = c (output array pointer, float)
# return: void

# Registers:
# t0 = vl (elements processed per iteration)
# t1 = byte offset (vl * 4) for pointer advancement
# v8 = loaded x chunk, then result after vfmadd
# v9 = loaded y chunk
# fa0 = sca;ar a (preserved across lopp, never modified)

saxpy:
1:
    vsetvli t0, a0, e32, m1, ta, ma         # t0 = vl = min(remaining, VLEN/32)

    vle32.v v8, (a1)                        # v8[0..vl-1] = x[i..i+vl-1]
    vle32.v v9, (a2)                        # v9[0..vl-1] = y[i..i+vl-1]
    
    # Fused multiply-add: v8[i] = a * v8[i] + v9[i]
    # Single rounding as required by fmaf
    vfmadd.vf v8, fa0, v9
    
    vse32.v v8, (a3)                        # store result to c[i..i+vl-1]
    
    # Advance all three pointers by vl elements (vl * 4 bytes)
    slli t1, t0, 2                          # t1 = vl * 4 (byte offset)
    add a1, a1, t1                          # x += vl
    add a2, a2, t1                          # y += vl
    add a3, a3, t1                          # c += vl
  
    sub a0, a0, t0                          # len -= vl
    bnez a0, 1b                             # loop if elements remain
    ret
    
    

# -----------------------------------------------------------
# License
# Tasks are the property of Codewars (https://www.codewars.com/) 
# and users of this resource.
# 
# All solution code in this repository 
# is the personal property of Vladimir Rukavishnikov
# (vladimirrukavishnikovmail@gmail.com).
# 
# Copyright (C) 2026 Vladimir Rukavishnikov
# 
# This file is part of the HungryVovka/Codewars-RISC-V
# (https://github.com/HungryVovka/Codewars-RISC-V)
# 
# License is GNU General Public License v3.0
# (https://github.com/HungryVovka/Codewars-RISC-V/blob/main/LICENSE)
# 
# You should have received a copy of the GNU General Public License v3.0
# along with this code. If not, see http://www.gnu.org/licenses/
# -----------------------------------------------------------