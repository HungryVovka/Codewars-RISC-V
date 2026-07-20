# -----------------------------------------------------------
# This method, which is supposed to return the result of dividing 
# its first argument by its second, isn't always returning correct values. 
# Fix it.
# -----------------------------------------------------------

.section .text
.global divnums

# FA0 float divnums(A0 int x, A1 int y)
# float divnums(int x, int y)
# a0 = x (numerator, 32-bit signed integer)
# a1 = y (denominator, 32-bit signed integer)
# return = fa0 (single-precision float result of x / y)
divnums:
    # Convert integer numerator (a0) to single-precision float in fa0
    # fcvt.s.w: convert 32-bit word (a0) to single-precision float (fa0)
    fcvt.s.w fa0, a0      # fa0 = (float)x

    # Convert integer denominator (a1) to single-precision float in fa1
    # fcvt.s.w: convert 32-bit word (a1) to single-precision float (fa1)
    fcvt.s.w fa1, a1      # fa1 = (float)y

    # Perform floating-point division: fa0 = fa0 / fa1
    # fdiv.s: single-precision floating-point divide
    fdiv.s fa0, fa0, fa1  # fa0 = (float)x / (float)y

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