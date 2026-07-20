# -----------------------------------------------------------
# You're at the zoo... all the meerkats look weird. Something has gone 
# terribly wrong - someone has gone and switched their heads and tails around!
# 
# Save the animals by switching them back. You will be given an array which 
# will have three values (tail, body, head). It is your job to re-arrange 
# the array so that the animal is the right way round (head, body, tail).
# 
# Same goes for all the other arrays/lists that you will get in the tests: 
# you have to change the element positions with the same exact logics
# 
# Simples!
# 
# RISC-V: The function signature is
# 
# void fix_the_meerkat(void *meerkat, size_t size);
# meerkat is an array of unknown type, but it always has exactly 3 elements 
# (tail, body, head). size is the size (in bytes) of each element in the array. 
# Swap the tail and head of meerkat in place. You do not need to return anything.
# -----------------------------------------------------------

.section .text
.globl fix_the_meerkat

# void fix_the_meerkat(void *meerkat, size_t size)
# a0 = meerkat (pointer to array of 3 elements: [tail, body, head])
# a1 = size (byte size of each element)
# no return value; modify in place

fix_the_meerkat:
    # Compute address of tail (index 0)
    mv t0, a0       # t0 = &meerkat[0] (tail)
    
    # Compute adress of head (index 2): base + 2 * size;
    li t1, 2          # t1 = 2
    mul t1, t1, a1    # t1 = 2 * size (byte offset to head)
    add t2, a0, t1    # t2 = &meerkat[2] (head)
    
    # I need to swap the whole elements (size bytes)
    # Since size can be arbitrary, I must do a byte-by-byte swap loop
    # I use t3 as loop counter (0 .. size_1)
    li t3, 0          # t3 = i = 0
    
swap_loop:
    bge t3, a1, done    # if i >= size, I swap all bytes
    
    # Load byte from head position
    add t4, t0, t3      # t4 = &tail[i]
    lb t5, 0(t4)        # t5 = tail_byte
    
    # Compute address of i-th byte in head: &head + i
    add t4, t2, t3      # reuse t4 for &head[i]
    lb t1, 0(t4)        # reuse t1 for head_byte
       
    add t4, t0, t3      # t4 = &tail[i] again
    sb t1, 0(t4)        # tail[i] = head_byte (from t1)
    
    add t4, t2, t3      # t4 = &head[i] again
    sb t5, 0(t4)        # head[i] = tail_byte (from t5)
    
    addi t3, t3, 1      # i++
    j swap_loop
    
done:
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