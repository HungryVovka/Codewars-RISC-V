# -----------------------------------------------------------
# In this example you have to validate if a user input string 
# is alphanumeric. The given string is not nil/null/NULL/None, 
# so you don't have to check that.
# 
# The string has the following conditions to be alphanumeric:
# 
# At least one character ("" is not valid)
# Allowed characters are uppercase / lowercase latin letters 
# and digits from 0 to 9
# No whitespaces / underscore
# -----------------------------------------------------------

.global alphanum

# bool alphanum(const char *s)
# a0 = pointer to string
# return: a0 = 1 (true) if alphanumeric, 0 (false) otherwise

alphanum:
    lb t0, 0(a0)              # t0 = first char
    beqz t0, return_false     # empty string "" -> not valid
    
check_loop:
    beqz t0, return_true      # reached '\0' without bad chars -> valid
    
    # Check if t0 is digit '0'..'9'
    li t1, '0'
    blt t0, t1, check_upper   # if < '0', not digit -> check letters
    li t2, '9'
    ble t0, t2, next_char     # if <= '9', it's a digit

check_upper:
    # Check if t0 is uppercase 'A'..'Z'
    li t1, 'A'
    blt t0, t1, check_lower   # if < 'A', not upper -> check lowercase
    li t2, 'Z'
    ble t0, t2, next_char     # if <= 'Z', it's upper letter -> OK
    
check_lower:
    # Check if t0 is lowercase 'a'..'z'
    li t1, 'a'
    blt t0, t1, return_false  # if < 'a', not alnum -> invalid
    li t2, 'z'
    bgt t0, t2, return_false  # if <= 'z', not alnum -> invalid
    
next_char:
    addi a0, a0, 1            # move to next char
    lb t0, 0(a0)              # load next char
    j check_loop
    
return_true:
    li a0, 1                  # true
    ret
    
return_false:
    li a0, 0                  # false
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