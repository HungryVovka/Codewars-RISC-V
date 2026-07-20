# -----------------------------------------------------------
# Complete the square sum function so that it squares each number 
# passed into it and then sums the results together.
# 
# For example, for [1, 2, 2] it should return 9 because 
# 1^2 + 2^2 + 2^2 = 9
# -----------------------------------------------------------

.section .text
.global square_sum

# int square_sum(const int *values, size_t count);
# a0 = pointer to array
# a1 = number of elements
# 
# returns:
# a0 = sum of squres

square_sum:
    li t0, 0            # t0 = sum
  
loop:
    beqz a1, done       # if count == 0 -> end
    
    lw t1, 0(a0)        # t1 = current element
    
    mul t1, t1, t1      # t1 = value * value
    
    add t0, t0, t1      # sum += square
    
    addi a0, a0, 4      # move to next int
    addi a1, a1, -1     # count--
    
    j loop
    
done:
    mv a0, t0           # return sum
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