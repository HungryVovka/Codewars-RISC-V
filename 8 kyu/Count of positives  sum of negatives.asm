# -----------------------------------------------------------
# Given an array of integers.
# 
# Return an array, where the first element is the count of positives 
# numbers and the second element is sum of negative numbers. 0 is 
# neither positive nor negative.
# 
# If the input is an empty array or is null, return an empty array.
# 
# Example
# For input [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, -11, -12, -13, -14, -15], 
# you should return [10, -65].
# -----------------------------------------------------------

.global cntpos_sumneg

# void cntpos_sumneg((A0) const int *v, A1 size_t cnt, (A2) size_t *poscnt, (A3) int *negsum)
# a0 = pointer to array
# a1 = number pf elements
# a2 = pointer to output count of positives
# a3 = pointer to output sum of negatives

cntpos_sumneg:
    li t0, 0                # t0 = pos_count (counter for positive numbers)
    li t1, 0                # t1 = neg_sum (accumulator for negative numbers)
    mv t2, a0               # t2 = current pointer to array element
    mv t3, a1               # t3 = remaining count (loop counter)
    
loop:
    beqz t3, done           # if no more elements, exit loop
    
    lw t4, 0(t2)            # t4 = current element v[i]
    addi t2, t2, 4          # advance pointer to next int (4 bytes)
    addi t3, t3, -1         # decrement remaining count
    
    bltz t4, check_negative # if t4 < 0 -> go to negative handling
    bgtz t4, is_positive    # if t4 > 0 -> go to positive handling
    j loop
    
check_negative:
    add t1, t1, t4          # neg_sum += t4 (t4 is negative here)
    j loop
    
is_positive:
    addi t0, t0, 1          # pos_count += 1
    j loop
    
done:
    sd t0, (a2)             # store pos_count into *poscnt (size_t)
    sw t1, (a3)             # store neg_sum into *negsum (int)
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