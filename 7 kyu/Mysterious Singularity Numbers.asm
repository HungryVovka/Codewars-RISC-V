# -----------------------------------------------------------
# This is a rather simple but interesting kata. Try to solve it using logic. 
# The shortest solution can be fit into one line.
# 
# Task
# The point is that a natural number N (1 <= N <= 10^9) is given. You need 
# to write a function which finds the number of natural numbers not exceeding 
# N and not divided by any of the numbers [2, 3, 5].
# 
# Example
# Let's take the number 5 as an example:
# 
# 1 - doesn't divide integer by 2, 3, and 5
# 2 - divides integer by 2
# 3 - divides integer by 3
# 4 - divides integer by 2
# 5 - divides integer by 5
# 
# Answer: 1
# 
# because only one number doesn't divide integer by any of 2, 3, 5
# 
# Note
# Again, try to think of a formula that will shorten your solution 
# and help you pass big tests.
# 
# Good luck :)
# -----------------------------------------------------------

.section .text
.global realnums

# unsigned realnums(unsigned num)
# a0 = N
# return: a0 = count of numbers <= N not divisible by 2, 3, 5
realnums:
    mv t0, a0           # t0 = original N for all division operations
    
    # Principle of Inclusion-Exclusion
    
    # 1. Substract multiples of 2 (N / 2)
    srli t1, t0, 1      # t1 = N / 2
    sub a0, a0, t1      # a0 = N - N/2
    
    # 2. Substract multiples of 3 (N / 3)
    li t2, 3            # divisor = 3
    divu t1, t0, t2     # t1 = N / 3
    sub a0, a0, t1      # a0 = a0 - N/3
    
    # 3. Substract multiples of 5 (N / 5)
    li t2, 5            # divisor = 5
    divu t1, t0, t2     # t1 = N / 5
    sub a0, a0, t1      # a0 = a0 - N/5
    
    # 4. Substract multiples of 6 (N / 6)
    li t2, 6            # divisor = 6
    divu t1, t0, t2     # t1 = N / 6
    add a0, a0, t1      # a0 = a0 + N/6
    
    # 5. Substract multiples of 10 (N / 10)
    li t2, 10           # divisor = 10
    divu t1, t0, t2     # t1 = N / 10
    add a0, a0, t1      # a0 = a0 + N/10
    
    # 6. Substract multiples of 15 (N / 15)
    li t2, 15           # divisor = 15
    divu t1, t0, t2     # t1 = N / 15
    add a0, a0, t1      # a0 = a0 + N/15
    
    # 7. Substract multiples of 30 (N / 30)
    li t2, 30           # divisor = 30
    divu t1, t0, t2     # t1 = N / 30
    sub a0, a0, t1      # a0 = a0 - N/30
    
    ret                 # return result in a0
    

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