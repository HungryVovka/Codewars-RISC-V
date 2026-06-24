# -----------------------------------------------------------
# Create a function that checks if a number n is divisible by 
# two numbers x AND y. All inputs are positive, non-zero numbers.
# 
# Examples:
# 1) n =   3, x = 1, y = 3 =>  true because   3 is divisible by 1 and 3
# 2) n =  12, x = 2, y = 6 =>  true because  12 is divisible by 2 and 6
# 3) n = 100, x = 5, y = 3 => false because 100 is not divisible by 3
# 4) n =  12, x = 7, y = 5 => false because  12 is neither divisible by 7 nor 5
# -----------------------------------------------------------

.global isdiv

# bool isdiv(int n, int x, int y)
# a0 = n
# a1 = x
# a2 = y
#
# return:
# a0 = 1 (true) or 0 (false)

isdiv:
    rem t0, a0, a1      # t0 = n % x
    bnez t0, false      # if remainder != 0 -> false
    
    rem t1, a0, a2      # t1 = n % y
    bnez t1, false      # if remainder != 0 -> false
    
    li a0, 1            # true
    ret
    
false:
    mv a0, x0           # false = 0
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