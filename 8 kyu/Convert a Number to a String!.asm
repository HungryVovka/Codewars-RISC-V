# -----------------------------------------------------------
# We need a function that can transform a number (integer) into a string.
# 
# What ways of achieving this do you know?
# 
# Examples (input --> output):
# 123  --> "123"
# 999  --> "999"
# -100 --> "-100"
# 
# RISC-V: The function signature is:
# 
# void number_to_string(int n, char *out);
# 
# Convert the input number n to a string, and write the result to out. 
# You may assume out is large enough to hold the result. You do 
# not need to return anything.
# -----------------------------------------------------------

.globl number_to_string

# void number_to_string(int n, char *out)
# a0 = number
# a1 = output buffer

number_to_string:
    addi sp, sp, -16      # reverse temporary buffer on stack
    
    mv t0, a0             # t0 = working copy of number
    mv t1, sp             # t1 = temp buffer
    li t2, 0              # t2 = digit count
    
    beqz t0, zero_case    # special case: n == 0
    
    bgez t0, extract      # if n >= 0 skip minus sign
    
    li t3, '-'            # write minus sign
    sb t3, 0(a1)
    addi a1, a1, 1
    
    neg t0, t0            # t0 = -t0
    
extract:
    li t3, 10             # divisor
    
digit_loop:
    rem t4, t0, t3        # t4 = n % 10
    addi t4, t4, '0'      # convert digit ti ASCII
    
    sb t4, 0(t1)          # store digit in temp buffer
    addi t1, t1, 1        # advance temp pointer
    addi t2, t2, 1        # increment digit count
    
    div t0, t0, t3        # n = n / 10
    bnez t0, digit_loop   # continue while n != 0
    
copy_back:
    beqz t2, done         # all digits copied
    
    addi t1, t1, -1       # move to previous stored digit
    lb t4, 0(t1)          # load digit
    
    sb t4, 0(a1)          # write digit to output
    addi a1, a1, 1        # advance output pointer
    
    addi t2, t2, -1       # decrement counter
    j copy_back
    
zero_case:
    li t3, '0'            # write "0"
    sb t3, 0(a1)
    addi a1, a1, 1
    
done:
    sb zero, 0(a1)        # write '\0'
    
    addi sp, sp, 16       # restore stack
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