# -----------------------------------------------------------
# An AI has infected a text with a character!!
# 
# This text is now fully mutated to this character.
# 
# Starting with the original text, and given a character, return 
# the text once it has been mutated so that all of the characters 
# in the original text have been replaced with the character.
# 
# If the text is empty, return an empty string.
# 
# Example
# text before = "abc"
# character   = "z"
# text after  = "zzz"
# 
# RISC-V: The function signature is
# 
# void contamination(const char *text, char mutation, char *result);
# 
# The function does not have a return value - you should write 
# the mutated string into result. You may safely assume that 
# result will be large enough to hold the result.
# -----------------------------------------------------------

.section .text
.globl contamination

# void contamination(const char *text, char mutation, char *result)
# a0 = text (input string)
# a1 = mutation (single char to fill with)
# a2 = result (output buffer; assumed large enough)
# no return value

contamination:
    # Save mutation char in t0 so we can use it repeatedly
    mv t0, a1       # t0 = mutation character
    
loop:
    lb t1, 0(a0)        # Load Byte: read current char from text
    beqz t1, done       # Branch if Zero: if NUL reached, end of string
    
    sb t0, 0(a2)        # Store Byte: write mutation char to result
    
    addi a0, a0, 1      # Advance input pointer (text++)
    addi a2, a2, 1      # Advance output pointer (result++)
    j loop              # Jump back to process next character
    
done:
    sb zero, 0(a2)      # Store Byte: write NUL terminator to result string
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