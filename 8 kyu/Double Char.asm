# -----------------------------------------------------------
# Given a string, you have to return a string in which each character 
# (case-sensitive) is repeated once.
# 
# Examples (Input -> Output):
# * "String"      -> "SSttrriinngg"
# * "Hello World" -> "HHeelllloo  WWoorrlldd"
# * "1234!_ "     -> "11223344!!__  "
# 
# Good Luck!
# 
# RISC-V: The function signature is
# 
# char *double_char(const char *string, char *doubled);
# 
# Write your result to doubled. You may assume it is large enough to hold the result.
# Return doubled when you are done.
# -----------------------------------------------------------

.section .text
.globl double_char

# char *double_char(const char *string, char *doubled);

# string (a0): Start of NUL-terminated input string
# doubled (a1): Write NUL-terminated string output starting here
# return value (a0): Original value of doubled

# a0 = string   (pointer to input string)
# a1 = doubled  (pointer to output buffer)
# return = a0   (original doubled pointer)
double_char:
    mv t0, a1         # Save original doubled pointer to return in a0 later
    
loop:
    lb t1, 0(a0)      # Load current character from input string
    beqz t1, done     # If NUL terminator reached, exit loop
    
    sb t1, 0(a1)      # Store character first time
    sb t1, 1(a1)      # Store character second time
    
    addi a0, a0, 1    # Advance input pointer by 1
    addi a1, a1, 2    # Advance output pointer by 2
    j loop
    
done:
    sb zero, 0(a1)    # Write NUL terminator
    mv a0, t0         # Return original doubled pointer
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