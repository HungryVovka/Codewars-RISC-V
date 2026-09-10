# -----------------------------------------------------------
# This kata is the same as Variable Number of Arguments in C, without "va", but in assembly.
# 
# Specifically, write a function n_sum such that it can be called in C with the signature:
# 
# int n_sum(int n, ...)
# 
# The caller passes a total of n + 1 arguments, the first one being the count n, and 
# the next n being the numbers to sum together. Return the sum of the n numbers.
# 
# Example:
# 
# n_sum(4, 1, 2, 3, 4) // Returns 10, which is 1 + 2 + 3 + 4
# 
# Constraints
# 0 <= n < 200, and the sum will not overflow int
# You can use the word va however you like. It won't help.
# 
# References
# You're welcome to look for any more simpler documentation, but 
# the most officials ones I could find are:
# 
# RISC-V: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-cc.adoc
# x86_64 Linux: https://refspecs.linuxfoundation.org/elf/x86_64-abi-0.99.pdf
# -----------------------------------------------------------

.section .text
.global n_sum

# int n_sum(int n, ...)
# a0 = n (count of numbers to sum)
# a1-a7 = first up to 7 numbers
# Stack: remaining numbers at 0(sp), 8(sp), 16(sp), ... (8-byte slots)
# return: a0 = sum of all n numbers

n_sum:
    mv t0, a0         # t0 = n (count)
    li t1, 0          # t1 = sum = 0
    beqz t0, done     # if n == 0, retur 0
    
    li t2, 0          # t2 = i = 0 (current number index)
    
    # Phase 1: process register args a1-a7 (indices 0..6)
    bge t2, t0, done
    addw t1, t1, a1
    addi t2, t2, 1
    
    bge t2, t0, done
    addw t1, t1, a2
    addi t2, t2, 1
    
    bge t2, t0, done
    addw t1, t1, a3
    addi t2, t2, 1
    
    bge t2, t0, done
    addw t1, t1, a4
    addi t2, t2, 1

    bge t2, t0, done
    addw t1, t1, a5
    addi t2, t2, 1

    bge t2, t0, done
    addw t1, t1, a6
    addi t2, t2, 1

    bge t2, t0, done
    addw t1, t1, a7
    addi t2, t2, 1
    
    # Phase 2: process stack args (indices 7..n-1)
    mv t3, sp         # t3 = pointer to current stack argument
    
stack_loop:
    bge t2, t0, done  # all numbers processed
    lw t4, 0(t3)      # load 32-bit int from stack (sign-extended)
    addw t1, t1, t4   # add to sum
    addi t3, t3, 8    # advance to next 8-byte slot
    addi t2, t2, 1    # increment index
    j stack_loop
    
done:
    mv a0, t1         # return sum in a0
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