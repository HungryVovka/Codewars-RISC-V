# -----------------------------------------------------------
# Given two strings comprised of + and -, return a new string 
# which shows how the two strings interact in the following way:
# 
# When positives and positives interact, they remain positive.
# When negatives and negatives interact, they remain negative.
# But when negatives and positives interact, they become neutral, 
# and are shown as the number 0.
# 
# Worked Example
# ("+-+", "+--") ➞ "+-0"
# # Compare the first characters of each string, then the next in turn.
# # "+" against a "+" returns another "+".
# # "-" against a "-" returns another "-".
# # "+" against a "-" returns "0".
# # Return the string of characters.
# 
# Examples
# ("--++--", "++--++") ➞ "000000"
# 
# ("-+-+-+", "-+-+-+") ➞ "-+-+-+"
# 
# ("-++-", "-+-+") ➞ "-+00"
# 
# Notes
# The two strings will be the same length.
# -----------------------------------------------------------

.section .text
.globl neutralize

# char *neutralize(char *outp, const char *s1, const char *s2)
# a0 = outp  (output buffer; assumed large enough)
# a1 = s1    (first input string of '+' and '-')
# a2 = s2    (second input string of '+' and '-')
# return = a0 (original outp pointer)
neutralize:
    mv t0, a0       # Save original outp pointer in t0; we will return it later

    # Loop over characters until NUL terminator in s1
loop:
    lb t1, 0(a1)    # Load Byte: read current char from s1
    beqz t1, done   # Branch if Zero: if NUL reached, exit loop

    lb t2, 0(a2)    # Load Byte: read current char from s2

    # Compare chars: if equal, keep sign; otherwise, result is '0'
    beq t1, t2, same_sign

    li t3, '0'      # Load Immediate: set result to '0' for opposite signs
    j write_result

same_sign:
    mv t3, t1       # Move: if signs match, result equals the sign char

write_result:
    sb t3, 0(a0)    # Store Byte: write result char to outp

    # Advance all pointers by 1 byte
    addi a0, a0, 1  # outp++
    addi a1, a1, 1  # s1++
    addi a2, a2, 1  # s2++
    j loop          # Jump back to process next character

done:
    sb zero, 0(a0)  # Store Byte: write NUL terminator to end outp string
    mv a0, t0       # Restore original outp pointer to a0 for return value
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