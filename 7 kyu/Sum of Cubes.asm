# -----------------------------------------------------------
# Write a function that takes a positive integer n, sums all 
# the cubed values from 1 to n (inclusive), and returns that sum.
# 
# Assume that the input n will always be a positive integer.
# 
# Examples: (Input --> output)
# 
# 2 --> 9 (sum of the cubes of 1 and 2 is 1 + 8)
# 3 --> 36 (sum of the cubes of 1, 2, and 3 is 1 + 8 + 27)
# -----------------------------------------------------------

.section .text
.global sumcubes

# int sumcubes(int n)
# Input: a0 = n (positive integer)
# Return: a0 = sum of cubes from 1 to n
sumcubes:
    li t0, 0    # t0 = accumulator for total sum (sum = 0)
    li t1, 1    # t1 = current counter i (i = 1)
    
loop:
    bgt t1, a0, done    # If i > n, exit loop
    # Calculate i^3
    mul t2, t1, t1      # t2 = i * i (i^2)
    mul t2, t2, t1      # t2 = i^2 * i (i^3)
    
    add t0, t0, t2      # Add i^3 to total sum (sum += i^3)
    addi t1, t1, 1      # Increment counter (i++)
    j loop              # Repeat loop
    
done:
    mv a0, t0   # Move final sum to a0 for return value
    ret
    

# or

.section .text
.global sumcubes

# int sumcubes(int n)
# Input: a0 = n (positive integer)
# Return: a0 = sum of cubes from 1 to n
sumcubes:
    mv t0, a0         # t0 = n
    addi t1, a0, 1    # t1 = n + 1
    mul t0, t0, t1    # t0 = n * (n + 1)
    srli t0, t0, 1    # t0 = n (n * (n + 1)) / 2 (logical shift right by 1 divides by 2)
    mul a0, t0, t0    # a0 = t0^2 (square the result to get sum of cubes)
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