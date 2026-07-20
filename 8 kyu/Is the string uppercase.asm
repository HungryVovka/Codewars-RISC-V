# -----------------------------------------------------------
# Is the string uppercase?
# 
# Task
# Create a method to see whether the string is ALL CAPS.
# 
# Examples (input -> output)
# "c" -> False
# "C" -> True
# "hello I AM DONALD" -> False
# "HELLO I AM DONALD" -> True
# "ACSKLDFJSgSKLDFJSKLDFJ" -> False
# "ACSKLDFJSGSKLDFJSKLDFJ" -> True
# 
# In this Kata, a string is said to be in ALL CAPS whenever 
# it does not contain any lowercase letter so any string containing 
# no letters at all is trivially considered to be in ALL CAPS.
# 
# RISC-V: The function signature is
# 
# bool is_uppercase(const char *);
# -----------------------------------------------------------

.global is_uppercase

# bool is_uppercase(const char *str)
# a0 = pointer to input string
# return: a0 = 1 (true) if all uppercase / no lowercase, 0 (false) otherwise
is_uppercase:
check_loop:
    lb t0, 0(a0)              # load current character
    beqz t0, return_true      # reached end of string ('\0') without lowercase -> true

    # Check if character is a lowercase letter ('a'..'z')
    li t1, 'a'
    blt t0, t1, next_char     # if < 'a', it cannot be lowercase -> continue
    
    li t2, 'z'
    ble t0, t2, return_false  # if 'a' <= char <= 'z', found lowercase -> return false

next_char:
    addi a0, a0, 1    # move to next character
    j check_loop

return_false:
    li a0, 0          # return false
    ret

return_true:
    li a0, 1          # return true
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