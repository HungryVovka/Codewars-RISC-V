# -----------------------------------------------------------
# Bob needs a fast way to calculate the volume of a rectangular cuboid 
# with three values: the length, width and height of the cuboid.
# 
# Write a function to help Bob with this calculation.
# -----------------------------------------------------------

.section .text
.global get_volume_of_cuboid

# double get_volume_of_cuboid(double length, double width, double height)
# fa0 = length
# fa1 = width
# fa2 = height
# return = fa0 (volume = length * width * height)

get_volume_of_cuboid:
    # fmul - Multiply two double-precision floats
    fmul.d fa0, fa0, fa1      # fa0 = length * width
    fmul.d fa0, fa0, fa2      # fa0 = (length * width) * heigth
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