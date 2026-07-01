# -----------------------------------------------------------
# Write a function that checks if two non-negative integers 
# make an "interlocking binary pair".
# 
# Interlock ?
# numbers can be interlocked if their binary representations have 
# no 1's in the same place
# comparisons are made by bit position, starting from right 
# to left (see the examples below)
# when representations are of different lengths, the unmatched 
# left-most bits are ignored
# 
# Examples
# 
# a = 9, b = 4
# 
# Stacking representations shows how they can interlock.
# 
#  9    1001
#  4     100
# 
# Here, no 1's share any position, so the function returns true.
# 
# 
# a = 3, b = 6
# 
# These representations do not interlock.
# 
#  3      11
#  6     110
# 
# Finding they both have a 1 in the same position, the function returns false.
# 
# Input
# Two non-negative integers.
# 
# Output
# Boolean true or false whether or not these integers are interlockable.
# -----------------------------------------------------------

.global interlockable

# bool interlockable(unsigned long long a. unsigned long long b)
# a0 = a
# a1 = b
# return: a0 = 1 (true) if interlockable, 0 (false) otherwise

interlockable:
    and t0, a0, a1          # t0 = bits that are 1 in both numbers
    bnez t0, return_false   # if any bit is 1 in both -> not interlockable
    li a0, 1                # no overlapping 1s -> interlockable
    ret
    
return_false:
    li a0, 0
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