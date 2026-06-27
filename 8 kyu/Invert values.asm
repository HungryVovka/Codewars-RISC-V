# -----------------------------------------------------------
# Given a set of numbers, return the additive inverse of each. Each 
# positive becomes negatives, and the negatives become positives.
# 
# [1, 2, 3, 4, 5] --> [-1, -2, -3, -4, -5]
# [1, -2, 3, -4, 5] --> [-1, 2, -3, 4, -5]
# [] --> []
# Notes:
# All values are greater than INT_MIN
# The input should be modified, not returned.
# RISC-V: The function signature is:
# 
# void invert(int *arr, size_t size);
# The input array is arr which contains size elements. Mutate 
# the array in-place according to the above specification. 
# You do not need to return anything.
# -----------------------------------------------------------

.globl invert

# void invert(int *arr, size_t size)
# a0 = pointer to array
# a1 = number of elements

invert:
    beqz a1, done       # if size == 0, nothing to do
    
loop:
    lw t0, 0(a0)        # t0 = current element arr[i]
    neg t0, t0          # t0 = -arr[i] (additive inverse)
    sw t0, 0(a0)        # write back the negated value (in-place)
    
    addi a0, a0, 4      # move pointer to next int (4 bytes)
    addi a1, a1, -1     # decrement counter
    bnez a1, loop       # continue while there are elements left
    
done:
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