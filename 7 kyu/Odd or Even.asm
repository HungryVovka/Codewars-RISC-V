# -----------------------------------------------------------
# Task:
# Given a list of integers, determine whether the sum of its elements is odd or even.
# 
# Give your answer as a string matching "odd" or "even".
# 
# If the input array is empty consider it as: [0] (array with a zero).
# 
# Examples:
# Input: [0]
# Output: "even"
# 
# Input: [0, 1, 4]
# Output: "odd"
# 
# Input: [0, -1, -5]
# Output: "even"
# 
# Have fun!
# -----------------------------------------------------------

.section .text
.global odd_or_even

# const char *odd_or_even(const int *v, size_t n)
# a0 = v  (pointer to array of integers)
# a1 = n  (number of elements)
# return = a0 (pointer to sring "odd" or "even")
odd_or_even:
    li t0, 0      # t0 = running sum (start from 0)
    li t1, 0      # t1 = i = 0 (loop counter)
    
loop:
    bge t1, a1, check_parity      # if i >= n, exit loop and check parity
    
    slli t2, t1, 2                # t2 = i * 4 (byte offset)
    add t2, a0, t2                # t2 = &v[i]
    lw t3, 0(t2)                  # t3 = v[i]
    
    add t0, t0, t3                # sum += v[i]
    
    addi t1, t1, 1                # i++
    j loop
    
check_parity:
    andi t0, t0, 1                # t0 = sum & 1 (0 -> even, 1 -> odd)
    beqz t0, return_even          # if t0 == 0 -> return "even"
    
    la a0, .Lodd                  # a0 = address of "odd"
    ret
    
return_even:
    la a0, .Leven    # a0 = address of "even"
    ret
    
.section .rodata
.Lodd: .asciz "odd"
.Leven: .asciz "even"


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
# This file is part of the HungryVovka/Codewars-C
# (https://github.com/HungryVovka/Codewars-C)
# 
# License is GNU General Public License v3.0
# (https://github.com/HungryVovka/Codewars-C/blob/main/LICENSE)
# 
# You should have received a copy of the GNU General Public License v3.0
# along with this code. If not, see http://www.gnu.org/licenses/
# -----------------------------------------------------------