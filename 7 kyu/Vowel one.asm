# -----------------------------------------------------------
# vowelOne
# Write a function that takes a string and outputs a strings 
# of 1's and 0's where vowels become 1's and non-vowels become 0's.
# 
# All non-vowels including non alpha characters (spaces,commas etc.) 
# should be included.
# 
# Examples:
# 
# vowelOne "abceios" -- "1001110"
# 
# vowelOne "aeiou, abc" -- "1111100100"
# -----------------------------------------------------------

.section .text
.global vowel_one

# char *vowel_one(const char *input, char *output)
# a0 = input
# a1 = output (we must return this same pointer)
# return: a0 = original output pointer
vowel_one:
    # Save the original output pointer in t3 to return it later.
    mv t3, a1                # t3 = original output pointer 
    mv t2, a1                # t2 = current write pointer for output
    
    # Preload constants that we need throughout the loop.
    addi t4, x0, 65          # t4 = ASCII code for 'A'
    addi t5, x0, 90          # t5 = ASCII code for 'Z'
    addi t6, x0, 32          # t6 = 32 (difference between uppercase and lowercase letters)
    
loop:
    lb t0, 0(a0)             # t0 = current char from input
    beqz t0, done            # if '\0', end of string, exit loop
    
    # Convert to lowercase if it's an uppercase letter.
    blt t0, t4, check_vowel  # if < 'A', skip conversion
    bgt t0, t5, check_vowel  # if > 'Z', skip conversion
    
    add t0, t0, t6           # t0 = t0 + 32 -> lowercase letter
    
check_vowel:
    # Check for vowels: a, e, i, o, u
    addi t1, x0, 97       # t1 = 'a'
    beq t0, t1, set_one
    
    addi t1, x0, 101      # t1 = 'e'
    beq t0, t1, set_one
    
    addi t1, x0, 105      # t1 = 'i'
    beq t0, t1, set_one
    
    addi t1, x0, 111      # t1 = 'o'
    beq t0, t1, set_one
    
    addi t1, x0, 117      # t1 = 'u'
    beq t0, t1, set_one
    
    # Not a vowel -> write '0' (ASCII 48)
    addi t1, x0, 48       # t1 = '0'  (reuse t1 instead of allocating a new register)
    sb t1, 0(t2)
    j next_char
    
set_one:
    addi t1, x0, 49       # t1 = '1'  (reuse t1 again)
    sb t1, 0(t2)          # write '1' to output
    
next_char:
    addi a0, a0, 1        # advance input pointer
    addi t2, t2, 1        # advance output write pointer
    j loop
    
done:
    sb zero, 0(t2)        # ASCII for '\0', null terminate output
    mv a0, t3             # return original output pointer
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