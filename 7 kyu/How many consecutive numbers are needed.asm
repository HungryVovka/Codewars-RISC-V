# -----------------------------------------------------------
# Write a function that takes an array of unique integers and returns 
# the minimum number of integers needed to make the values of the array 
# consecutive from the lowest number to the highest number.
# 
# Example
# [4, 8, 6] --> 2
# Because 5 and 7 need to be added to have [4, 5, 6, 7, 8]
# 
# [-1, -5] --> 3
# Because -2, -3, -4 need to be added to have [-5, -4, -3, -2, -1]
# 
# [1] --> 0
# []  --> 0
# -----------------------------------------------------------

.section .text
.global consecutive

# int consecutive(const int arr[], size_t length);
# Input:  a0 = pointer to array arr
#         a1 = length of the array
# Return: a0 = minimum number of integers needed to make values consecutive
consecutive:
    # Base cases: if length == 0 or length == 1, return 0
    li t0, 1
    ble a1, t0, return_zero   # If length <= 1, return 0
    
    # Initialize min (t0) and max (t1) with the first element of the array
    lw t0, 0(a0)              # t0 = min_val
    mv t1, t0                 # t1 = max_val
    
    # Setup loop parameters
    mv t2, a0                 # t2 = current element pointer
    li t3, 1                  # t3 = loop counter i = 1
    
find_min_max_loop:
    beq t3, a1, calc_result   # If i == length, exit loop
    addi t2, t2, 4            # Move pointer to the next 32-bit integer (4 bytes)
    lw t4, 0(t2)              # Read current element
    
    # Check for new min
    bge t4, t0, check_max     # If current >= min, check max
    mv t0, t4                 # Else update min_val
    
check_max:
    # Check for new max
    ble t4, t1, next_iter     # If current <= max, skip
    mv t1, t4                 # Else update max_val
    
next_iter:
    addi t3, t3, 1            # i++
    j find_min_max_loop
    
calc_result:
    # Formula: (max - min + 1) - length
    sub a0, t1, t0            # a0 = max - min
    addi a0, a0, 1            # a0 = max - min + 1
    sub a0, a0, a1            # a0 = (max - min + 1) - length
    ret
    
return_zero:
    li a0, 0                  # Return 0 for empty or single-element array
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