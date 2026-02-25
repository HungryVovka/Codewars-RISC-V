# -----------------------------------------------------------
Complete the function which converts a binary number (given as a string) to a decimal number.
# -----------------------------------------------------------

.global bin2dec

# <-- A0 unsigned long bin2dec((A0) const char *bin) -->
# Converts null-terminated binary string to unsigned long
# Arguments: a0 = pointer to binary string
# Returns: a0 = answer
# Complexity: O(n)

bin2dec:

    li t0, 0          # t0 <- answer = 0
    mv t1, a0         # t1 <- strptr = pointer to input string

loop:
    lb t2, 0(t1)      # t2 <- load current character
    beqz t2, done     # if '\0' -> end

    addi t2, t2, -48  # convert ASCII '0'/'1' -> 0/1
    slli t0, t0, 1    # answer *= 2
    add t0, t0, t2    # answer += bit

    addi t1, t1, 1    # move to next character
    j loop

done:
    mv a0, t0         # move answer to return register
    ret

# -----> endof bin2dec <-----

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