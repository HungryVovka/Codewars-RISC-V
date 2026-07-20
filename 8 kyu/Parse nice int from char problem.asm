# -----------------------------------------------------------
# You ask a small girl "How old are you?" She always says "x years old", 
# where x is a random number between 0 and 9.
# 
# Write a program that returns the girl's age (0-9) as an integer.
# 
# Assume the test input string is always a valid string. For example, 
# the test input may be "1 year old" or "5 years old". 
# The first character in the string is always a number.
# -----------------------------------------------------------

.global getage

# <-- A0 int getage((A0) const char *inp) -->
# int getage(const char *inp)
# a0 = pointer to input string (e.g. "3 years old")
# return value in a0

getage:
    lb t0, 0(a0)    # t0 = first character (the digit as ASCII)
    li t1, '0'      # t1 = ASCII cose for '0'
    sub a0, t0, t1  # convert ASCII digit to integer (e.g. '3' - '0' = 3)
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