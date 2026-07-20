# -----------------------------------------------------------
# Build a function that returns an array of integers from n to 1 where n>0.
# 
# Example : n=5 --> [5,4,3,2,1]
# 
# RISC-V: The function signature is
# 
# void n_to_1(int n, int *arr);
# Write your result to arr. You may assume it is large enough 
# to hold the result. You do not need to return anything.
# -----------------------------------------------------------

.globl n_to_1

# void n_to_1(int n, int *arr)
# a0 = n (start value, will count down)
# a1 = arr (pointer to output array)

n_to_1:
    beqz a0, done     # if n == 0, nothing to write -> exit
    
loop:
    sw a0, 0(a1)      # write current n into array[i]
    addi a1, a1, 4    # move pointer to next int (4 bytes)
    addi a0, a0, -1   # decrement n
    bgtz a0, loop     # continue while n > 0
    
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