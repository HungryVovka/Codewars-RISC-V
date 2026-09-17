# -----------------------------------------------------------
# Overview
# Bubblesort is an inefficient sorting algorithm that is simple to understand 
# and therefore often taught in introductory computer science courses as 
# an example how not to sort a list. Nevertheless, it is correct in the sense 
# that it eventually produces a sorted version of the original list when executed 
# to completion.
# 
# At the heart of Bubblesort is what is known as a pass. Let's look at an example 
# at how a pass works.
# 
# Consider the following list:
# 
# 9, 7, 5, 3, 1, 2, 4, 6, 8
# 
# We initiate a pass by comparing the first two elements of the list. Is the 
# first element greater than the second? If so, we swap the two elements. 
# Since 9 is greater than 7 in this case, we swap them to give 7, 9. 
# The list then becomes:
# 
# 7, 9, 5, 3, 1, 2, 4, 6, 8
# 
# We then continue the process for the 2nd and 3rd elements, 
# 3rd and 4th elements ... all the way up to the last two elements. 
# When the pass is complete, our list becomes:
# 
# 7, 5, 3, 1, 2, 4, 6, 8, 9
# 
# Notice that the largest value 9 "bubbled up" to the end of the list. 
# This is precisely how Bubblesort got its name.
# 
# Task
# Implement a function bubblesort_pass() that performs exactly 1 complete pass 
# of Bubblesort on the input array. It should return whether any pair 
# of integers have been swapped.
# 
# The function signature is
# 
# bool bubblesort_pass(int *arr, size_t n);
# 
# where arr is the input array and n is the number of elements in the array.
# -----------------------------------------------------------

.section .text
    .globl bubblesort_pass

# bool bubblesort_pass(int *arr, size_t n)
# a0 = arr (pointer to int array)
# a1 = n (number of elements)
# return: a0 = 1 if any swp occurred, 0 otherwise
# Registers:
# t0 = current element value (arr[i])
# t1 = next element value (arr[i+1])
# t2 = swapped flag (0 = no swap, 1 = at least one swap)
# t3 = loop counter i

bubblesort_pass:
    li t2, 0          # t2 = swapped = false
    li t3, 0          # t3 = i = 0
    
pass_loop:
    # Need at least 2 elements remaining to compare
    addi t4, a1, -1       # t4 = n - 1
    bge t3, t4, done      # if i >= n - 1, pass complete
    
    # Load arr[i] and arr[i+1]
    slli t5, t3, 2        # t5 = i * 4 (byte offset)
    add t5, a0, t5        # if i >= n - 1, pass complete
    
    # Load arr[i] and arr[i+1]
    slli t5, t3, 2        # t5 = i * 4 (byte offset)
    add t5, a0, t5        # t5 = &arr[i]
    lw t0, 0(t5)          # t0 = arr[i]
    lw t1, 4(t5)          # t1 = arr[i+1]
    
    # Compare: if arr[i] <= arr[i+1], no swap needed
    ble t0, t1, no_swap
    
    # Swap: store arr[i+1] ar &arr[i], store arr[i] at &arr[i+1]
    sw t1, 0(t5)
    sw t0, 4(t5)
    li t2, 1              # swapped = true
    
no_swap:
    addi t3, t3, 1        # i++
    j pass_loop
    
done:
    mv a0, t2             # return swapped flag
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