# -----------------------------------------------------------
# This code does not execute properly. Try to figure out why.
# -----------------------------------------------------------

.globl multiply

# multiply two integers
# a0 = first operand
# a1 = second operand
# returns a0 = product
# Complexity: O(1)

multiply:
  mul a0, a0, a1  # a0 <- a0 * a1
  ret             # return

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