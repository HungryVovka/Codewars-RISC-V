# -----------------------------------------------------------
# Given an array of integers your solution should find the smallest integer.
# 
# For example:
# 
# Given [34, 15, 88, 2] your solution will return 2
# Given [34, -345, -1, 100] your solution will return -345
# 
# You can assume, for the purpose of this kata, that 
# the supplied array will not be empty.
# -----------------------------------------------------------

.global find_smallest_int

# <-- A0 int find_smallest_int((A0) const int *v, A1 size_t n) -->
# int find_smallect_int(const int *v, size_t n)
# a0 = pointer to array
# a1 = number of elements

find_smallest_int:
    lw t0, 0(a0)        # t0 = current minimum; initialize with first element v[0]
    addi a0, a0, 4      # advance pointer: now a0 points to v[1]
    addi a1, a1, -1     # decrease counter: we already processed 1 element
    
loop:
    beqz a1, done       # if no more elements to check, jump to done
    
    lw t1, 0(a0)        # t1 = next element v[i]
    bge t1, t0, skip    # if t1 >= t0, it's not smaller -> skip update
    
    mv t0, t1           # t0 = t1; update minimum
    
skip:
    addi a0, a0, 4      # move pointer to next element (4 bytes per int)
    addi a1, a1, -1     # decrement remaining count
    j loop              # repeat
    
done:
    mv a0, t0           # return value in a0 = smallest integer found
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