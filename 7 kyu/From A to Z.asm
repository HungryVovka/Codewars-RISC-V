# -----------------------------------------------------------
# Given a string indicating a range of letters, return a string which 
# includes all the letters in that range, including the last letter.
# Note that if the range is given in capital letters, return 
# the string in capitals also!
# 
# Examples
# "a-z" ➞ "abcdefghijklmnopqrstuvwxyz"
# "h-o" ➞ "hijklmno"
# "Q-Z" ➞ "QRSTUVWXYZ"
# "J-J" ➞ "J"
# 
# Notes
# A hyphen will separate the two letters in the string.
# You don't need to worry about error handling in this kata (i.e. both 
# letters will be the same case and the second letter will not be 
# before the first alphabetically).
# -----------------------------------------------------------

.global letters_range

# void letters_range(char *outp, const char *range)
# a0 = outp (output buffer)
# a1 = range (input string like "a-z")

letters_range:
    lb t0, 0(a1)        # t0 = first letter (e.g. 'a')
    lb t1, 2(a1)        # t1 = last letter (index 2 because of "X-Y" format)
    
loop:
    sb t0, 0(a0)            # write current letter to output
    addi a0, a0, 1          # move output pointer
    addi t0, t0, 1          # next letter
    blt t0, t1, loop        # if current < last, keep looping
    beq t0, t1, write_last  # if current == last, write it too
    j done                  # if current > last (error handling), stop

write_last:
    sb t0, 0(a0)            # write the last letter
    addi a0, a0, 1
    
done:
    li t2, 0
    sb t2, 0(a0)            # null_terminate the output string
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