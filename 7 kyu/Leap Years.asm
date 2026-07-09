# -----------------------------------------------------------
# In this kata you should simply determine, whether a given year is a leap year 
# or not. In case you don't know the rules, here they are:
# 
# Years divisible by 4 are leap years,
# but years divisible by 100 are not leap years,
# but years divisible by 400 are leap years.
# 
# Tested years are in range 1600 ≤ year ≤ 4000.
# -----------------------------------------------------------

.section .text
.globl is_leap_year

# int is_leap_year(int year)
# a0 = year
# return = a0 (1 = true if leap, 0 = false otherwise)
is_leap_year:
    mv t0, a0               # t0 = year (keep original for later checks)
    
    # Check divisible by 400 first
    li t1, 400
    rem t2, t0, t1          # t2 = year % 400
    beqz t2, return_true    # if year % 400 == 0 -> leap year
    
    # Check divisible by 100
    li t1, 100
    rem t2, t0, t1          # t2 = year % 100
    beqz t2, return_false   # if year % 100 == 0 (and not % 400)
                            # -> NOT leap year
                            
    # Check divisible by 4
    li t1, 4
    rem t2, t0, t1          # t2 = year % 4
    beqz t2, return_true    # if year % 4 == 0 (and not % 100)
                            # -> leap year
                            
    # Otherwise: not a leap year
    j return_false

return_true:
    li a0, 1    # result = true
    ret
    
return_false:
    li a0, 0    # result = false
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