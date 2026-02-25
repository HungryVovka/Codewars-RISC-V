# -----------------------------------------------------------
# Create a function that takes an integer as an argument and returns 
# "Even" for even numbers or "Odd" for odd numbers.
# -----------------------------------------------------------

.global even_or_odd

# const char *even_or_odd(int n)
# a0 = imput number
# returns a0 = pointer to "Even" or "Odd"

.equ  EVEN_STR, even_string
.equ ODD_STR, odd_string

even_or_odd:
    andi t0, a0, 1       # t0 = a0 & 1 (last bit check)
    bnez t0, odd_case    # if 0 -> even

even_case:
    la a0, EVEN_STR      # a0 = adress of "Even"
    ret                  # return
    
odd_case:
    la a0, ODD_STR      # a0 = adress of "Even"
    ret                  # return
    
# Strings in read-only data
.section .rodata
even_string:
    .string "Even"
odd_string:
    .string "Odd"

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