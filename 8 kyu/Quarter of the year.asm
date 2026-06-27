# -----------------------------------------------------------
# Given a month as an integer from 1 to 12, return to which quarter 
# of the year it belongs as an integer number.
# 
# For example: month 2 (February), is part of the first quarter; 
# month 6 (June), is part of the second quarter; 
# and month 11 (November), is part of the fourth quarter.
# 
# Constraint:
# 
# 1 <= month <= 12
# -----------------------------------------------------------

.global quarter_of

# int quarter_of(int month)
# a0 - month (1..12)
# return value in a0

quarter_of:
    addi t0, a0, 2    # t0 = month + 2 (to shift so that 1..3 -> 3..5, 4..6 -> 6..8, etc.)
    li t1, 3          # t1 = 3 (divisor to get quarter)
    div t0, t0, t1    # t0 = (month + 2) / 3 -> this gives the quarter directly
    mv a0, t0         # return quarter in a0
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