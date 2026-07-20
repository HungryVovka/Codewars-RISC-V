# -----------------------------------------------------------
# Write a function to convert a name into initials. This kata strictly 
# takes two words with one space in between them.
# 
# The output should be two capital letters with a dot separating them.
# 
# It should look like this:
# 
# Sam Harris => S.H
# 
# patrick feeney => P.F
# 
# RISC-V: The function signature is:
# 
# char *get_initials(const char *full_name, char initials[4]);
# 
# Write your result to initials, and return that buffer.
# -----------------------------------------------------------

.globl get_initials

# char *get_initials(const char *full_name, char initials[4])
# a0 = full_name
# a1 = initials (we'll keep original in t3 to return later)

get_initials:
    mv t3, a1                   # t3 = save original initials pointer (to return later)
    
    lb t0, 0(a0)                # t0 = first letter of first name
    addi a0, a0, 1              # move past it
    
    # Upercase first letter if lowercase
    li t1, 'a'
    blt t0, t1, first_no_upper
    li t2, 'z' 
    bgt t0, t2, first_no_upper
    li t4, 32
    sub t0, t0, t4              # convert t0 to uppercase
    
first_no_upper:
    sb t0, 0(a1)                # store first initial
    addi a1, a1, 1              # output pointer++
    
    li t0, '.'                  # t0 = '.'
    sb t0, 0(a1)                # store dot
    addi a1, a1, 1              # output pointer++
    
    # Skip first word until space
    
skip_space_search:
    lb t0, 0(a0)
    beqz t0, error_bad_input
    addi a0, a0, 1
    li t1, ' '
    bne t0, t1, skip_space_search
    
    # Now a0 points to the char after space -> first letter of second name
    lb t0, 0(a0)                # t0 = first letter of last name
    
    # Uppercase seconf letter if lowercase
    li t1, 'a'
    blt t0, t1, second_no_upper
    li t2, 'z'
    bgt t0, t2, second_no_upper
    li t4, 32
    sub t0, t0, t4              # convert t0 to uppercase
    
second_no_upper:
    sb t0, 0(a1)                # store second initial
    addi a1, a1, 1              # output pointer++
    
    li t0, 0                    # null terminator t0 = '\0'
    sb t0, 0(a1)                # write '\0'
    
    mv a0, t3                   # return original initials buffer pointer on a0
    ret
    
error_bad_input:
    # Fallback: just return empty string in buffer
    sb zero, 0(t3)              # initials[0] = '\0'
    mv a0, t3
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