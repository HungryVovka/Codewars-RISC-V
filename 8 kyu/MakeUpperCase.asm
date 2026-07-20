# -----------------------------------------------------------
# Write a function which converts the input string to uppercase.
# 
# RISC-V: The function signature is
# 
# void to_upper_case(const char *str, char *out);
# str is the input string. Write your result to out. You may assume it is 
# large enough to hold the result. You do not need to return anything.
# -----------------------------------------------------------

.globl to_upper_case

# void to_upper_case(const char *str, char *out)
# a0 = input string
# a1 = output buffer

to_upper_case:

loop:
    lb t0, 0(a0)      # t0 = current character
    beqz t0, done     # if '\0' -> end
    
    li t1, 'a'        # lower bound
    blt t0, t1, store # if char < 'a' -> keep unchanged
    
    li t1, 'z'        # upper bound
    bgt t0, t1, store # if char > 'z' -> keep unchanged
    
    addi t0, t0, -32  # convert lowercase to uppercase
    
store:
    sb t0, 0(a1)      # store character in output
    
    addi a0, a0, 1    # move input pointer
    addi a1, a1, 1    # move output pointer
    j loop
    
done:
    sb zero, 0(a1)    # write null terminator
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