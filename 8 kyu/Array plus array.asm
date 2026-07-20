# -----------------------------------------------------------
# I'm new to coding and now I want to get the sum of two arrays... Actually 
# the sum of all their elements. I'll appreciate for your help.
# 
# P.S. Each array includes only integer numbers. Output is a number too.
# -----------------------------------------------------------

.section .text
.global arr_plus_arr

# long arr_plus_arr(const int *a, const int*b, size_t na, size_t nb)
# a0 = a  (pointer to first array)
# a1 = b  (pointer to second array)
# a2 = na (length of first array)
# a3 = nb (length of second array)
# return a0 (sum of all elements in both arrays, as long)

arr_plus_arr:
    li t0, 0      # t0 = running sum (assume result fits in 32 bit)
    
    # Sum elemnts of first array (a)
    li t1, 0      # t1 = i = 0 (loop counter for first array)
    
sum_a_loop:
    bge t1, a2, sum_b_start     # if i >= na, go to sum second array
    
    slli t2, t1, 2              # t2 = i * 4 (byte offset for word)
    add t2, a0, t2              # t2 = &a[i]
    lw t3, 0(t2)                # t3 = a[i]
    
    add t0, t0, t3              # sum += a[i]
    
    addi t1, t1, 1              # i++
    j sum_a_loop
    
sum_b_start:
    # Sum elements of second array (b)
    li t1, 0      # t1 = i = 0 (reset counter or second array)
    
sum_b_loop:
    bge t1, a3, done            # if i >= nb, exit loop
    
    slli t2, t1, 2              # t2 = i * 4 (byte offset)
    add t2, a1, t2              # t2 = &b[i]
    lw t3, 0(t2)                # t3 = b[i]
    
    add t0, t0, t3              # sum += b[i]
    
    addi t1, t1, 1              # i++
    j sum_b_loop
    
done:
    mv a0, t0                   # move final sum into return register a0
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