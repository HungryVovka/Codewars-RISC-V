# -----------------------------------------------------------
# Are the numbers in order?
# In this Kata, your function receives an array of integers as input. Your task 
# is to determine whether the numbers are in ascending order. An array is said 
# to be in ascending order if there are no two adjacent integers where 
# the left integer exceeds the right integer in value.
# 
# For the purposes of this Kata, you may assume that all inputs are valid, 
# i.e. arrays containing only integers.
# 
# Note that an array of 0 or 1 integer(s) is automatically considered 
# to be sorted in ascending order since all (zero) adjacent pairs of 
# integers satisfy the condition that the left integer does not exceed 
# the right integer in value.
# 
# For example:
# 
# in_asc_order({1,2,4,7,19}, 5); // returns true
# in_asc_order({1,2,3,4,5}, 5); // returns true
# in_asc_order({1,6,10,18,2,4,20}, 7); // returns false
# in_asc_order({9,8,7,6,5,4,3,2,1}, 9); // returns false because the numbers 
# are in DESCENDING order
# 
# RISC-V: The function signature is
# 
# bool in_asc_order(const int *arr, size_t n);
# 
# N.B. If your solution passes all fixed tests but fails at the random tests, 
# make sure you aren't mutating the input array.
# -----------------------------------------------------------

.section .text
.globl in_asc_order

# bool in_asc_order(const int *arr, size_t n)
# a0 = arr  (pointer to array)
# a1 = n  (number of elements)
# return = a0   (1 = true if sorted ascending, 0 = false otherwise)
in_asc_order:
    # Arrays of 0 or 1 element are always sorted
    li t0, 2
    blt a1, t0, return_true   # if n < 2 -> return true
    
    li t1, 0                  # t1 = i = 0  (loop counter)
    
loop:
    addi t2, t1, 1          # t2 = i + 1  (index of next element)
    bge t2, a1, all_ok      # if i + 1 >= n -> no more adjacent pairs, array is sorted
    
    slli t3, t1, 2          # t3 = i * 4  (byte offset for current element)
    add t3, a0, t3          # t3 = &arr[i]
    lw t4, 0(t3)            # t4 = arr[i]
    
    slli t5, t2, 2          # t5 = (i + 1) * 4 (byte offset for next element)
    add t5, a0, t5          # t5 = &arr[i + 1]
    lw t6, 0(t5)            # t6 = arr[i + 1]
    
    ble t4, t6, next_iter   # if arr[i] <= arr[i + 1] -> OK, continue to next pair
    
    # If I am here, arr[i] > arr[i + 1] -> not sorted
    li a0, 0                # return false
    ret
    
next_iter:
    addi t1, t1, 1    # i++
    j loop
    
all_ok:
    li a0, 1          # all adjacent pairs satisfy condition -> return true
    ret
    
return_true:
    li a0, 1
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
# This file is part of the HungryVovka/Codewars-C
# (https://github.com/HungryVovka/Codewars-C)
# 
# License is GNU General Public License v3.0
# (https://github.com/HungryVovka/Codewars-C/blob/main/LICENSE)
# 
# You should have received a copy of the GNU General Public License v3.0
# along with this code. If not, see http://www.gnu.org/licenses/
# -----------------------------------------------------------