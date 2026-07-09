# -----------------------------------------------------------
# Determine the total number of digits in the integer (n>=0) given as input 
# to the function. For example, 9 is a single digit, 66 has 2 digits 
# and 128685 has 6 digits. Be careful to avoid overflows/underflows.
# 
# All inputs will be valid.
# -----------------------------------------------------------

.section .text
.global digits

# int digits(uint64_t n)
# a0 = n  (input number, n >= 0, 64-bit)
# return = a0   (number of decimal digits)
digits:
    li t0, 0              # t0 = count = 0
    li t1, 10             # t1 = divisor = 10   (64-bit constant)
    
    # Special case: if n == 0, answer is 1
    beqz a0, return_one   # if n == 0 -> jump to return 1
    
loop:
    beqz a0, done         # if n == 0 -> stop counting
    
    divu a0, a0, t1       # a0 = n / 10 (64-bit unsigned division)
    addi t0, t0, 1        # count++
    j loop
    
done:
    mv a0, t0       # move count into return register
    ret
    
return_one:
    li a0, 1        # special case n == 0 -> 1 digit
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