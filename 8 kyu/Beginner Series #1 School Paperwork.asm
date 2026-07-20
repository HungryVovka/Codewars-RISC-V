# -----------------------------------------------------------
# Your classmates asked you to copy some paperwork for them. You know 
# that there are 'n' classmates and the paperwork has 'm' pages.
# 
# Your task is to calculate how many blank pages do you need. If n < 0 or m < 0 # return 0.
# 
# Example:
# n= 5, m=5: 25
# n=-5, m=5:  0
# 
# Waiting for translations and Feedback! Thanks!
# -----------------------------------------------------------

.global paperwork

# <-- A0 <int> paperwork(A0 <int> n, A1 <int> m) -->
# int paperwork(int n, int m)
# a0 = n (number of classmates)
# a1 = m (pages per classmate)

paperwork:
    bltz a0, return_zero    # if n < 0 -> return 0
    bltz a1, return_zero    # if m < 0 -> return 0
    
    mul a0, a0, a1          # a0 = n * m (total pages needed)
    ret
    
return_zero:
    li a0, 0                # a0 = 0 (invalid input case)
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