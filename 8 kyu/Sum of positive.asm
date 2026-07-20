# -----------------------------------------------------------
# Task
# You get an array of numbers, return the sum of all of the positives ones.
# 
# Example
# [1, -4, 7, 12] => 1 + 7 + 12 = 20
# 
# Note
# If there is nothing to sum, the sum is default to 0.
# -----------------------------------------------------------

.globl positive_sum

# int positive_sum(const int *arr, size_t count)
# a0 = pointer to array
# a1 = number of elements
#
# returns:
# a0 = sum of positive numbers

positive_sum:
    li t0, 0          # t0 = sum

loop:
    beqz a1, done     # if count == 0 -> end
    
    lw t1, 0(a0)      # t1 = current element
    
    blez t1, skip_add # if value <= 0 -> skip
    
    add t0, t0, t1    # sum += value
    
skip_add:
    addi a0, a0, 4    # move to bext int
    addi a1, a1, -1   # count--
    
    j loop
    
done:
    mv a0, t0         # return sum
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