# -----------------------------------------------------------
# Complete the function that takes two integers (a, b, where a < b) and 
# return an array of all integers between the input parameters, including them.
# 
# For example:
# 
# a = 1
# b = 4
# --> [1, 2, 3, 4]
# -----------------------------------------------------------

.section .text
.global between


# void between(int a, int b, int *integers)
# a0 = a  (start value, a < b)
# a1 = b  (end value)
# a2 = integers (pointer to output array)
# no return value

between:
    mv t0, a0     # t0 = current value (start from a)
    mv t1, a2     # t1 = pointer to output array (keep base)
    
loop:
    blt t0, a1, write_val   # if current < b, write current AND next
    beq t0, a1, write_last  # if current == b, write and finish
    j done                  # if current > b -> exit
    
write_val:
    sw t0, 0(t1)      # store current value intp output array
    addi t0, t0, 1    # current++
    addi t1, t1, 4    # move to next word in output array (4 bytes)
    j loop
    
write_last:
    sw t0, 0(t1)      # store the last value (b)
    # pointer increment not needed here
    j done
    
done:
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