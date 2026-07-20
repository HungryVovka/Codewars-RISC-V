# -----------------------------------------------------------
# Return the number (count) of vowels in the given string.
# 
# We will consider a, e, i, o, u as vowels for this Kata (but not y).
# 
# The input string will only consist of lower case letters and/or spaces.
# -----------------------------------------------------------

.section .text
.global get_count

# size_t get_count(const char *s)
# a0 = pointer to input string
# return: a0 = count of vowels ('a', 'e', 'i', 'o', 'u')
get_count:
    li t0, 0      # t0 = vowel counter
    
loop:
    lb t1, 0(a0)            # Read character from string
    beqz t1, done           # If NUL terminator ('\0'), exit loop
    
    li t2, 'a'      
    beq t1, t2, is_vowel    # Check for 'a'
    li t2, 'e'
    beq t1, t2, is_vowel    # Check for 'e'
    li t2, 'i'
    beq t1, t2, is_vowel    # Check for 'i'
    li t2, 'o'
    beq t1, t2, is_vowel    # Check for 'o'
    li t2, 'u'
    beq t1, t2, is_vowel    # Check for 'u'
    j next_char             # Not a vowel -> move to next char
    
is_vowel:
    addi t0, t0, 1          # Increment vowel count
    
next_char:
    addi a0, a0, 1          # Advance string pointer
    j loop

done:
    mv a0, t0               # Return vowel count in a0
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