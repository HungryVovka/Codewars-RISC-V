# -----------------------------------------------------------
# Complete the function that takes a non-negative integer n as input, 
# and returns a list of all the powers of 2 with the exponent ranging 
# from 0 to n ( inclusive ).
# 
# Examples
# n = 0  ==> [1]        # [2^0]
# n = 1  ==> [1, 2]     # [2^0, 2^1]
# n = 2  ==> [1, 2, 4]  # [2^0, 2^1, 2^2]
# RISC-V: The function signature is:
# 
# void powers_of_two(size_t n, uint64_t powers[n + 1]);
# Write the result to powers. You may assume it is large enough to hold the # result. You should not return anything.
# -----------------------------------------------------------

.globl powers_of_two

# void powers_of_two(size_t n, uint64_t powers[n + 1])
# a0 = n (max ezponent)
# a1 = pointer to output array of uint64_t

powers_of_two:
    li t0, 1          # t0 = current power of 2, start with 2^0 = 1
    mv t1, a1         # t1 = current write pointer in powers[]
    li t2, 0          # t2 = current exponent (i)
    
loop:
    bgt t2, a0, done  # if i > n, we're done
    
    sd t0, 0(t1)      # store current power (uint64_t -> use sd)
    addi t1, t1, 8    # move pointer by 8 bytes (sizeof(uint64_t))
    
    slli t0, t0, 1    # t0 = t0 * 2 (next power of 2)
    addi t2, t2, 1    # i++
    j loop
    
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
# This file is part of the HungryVovka/Codewars-RISC-V
# (https://github.com/HungryVovka/Codewars-RISC-V)
# 
# License is GNU General Public License v3.0
# (https://github.com/HungryVovka/Codewars-RISC-V/blob/main/LICENSE)
# 
# You should have received a copy of the GNU General Public License v3.0
# along with this code. If not, see http://www.gnu.org/licenses/
# -----------------------------------------------------------