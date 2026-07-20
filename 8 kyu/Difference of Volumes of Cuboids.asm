# -----------------------------------------------------------
# In this simple exercise, you will create a program that will take 
# two lists of integers, a and b. Each list will consist of 3 positive 
# integers above 0, representing the dimensions of cuboids a and b. 
# You must find the difference of the cuboids' volumes regardless of 
# which is bigger.
# 
# For example, if the parameters passed are ([2, 2, 3], [5, 4, 1]), 
# the volume of a is 12 and the volume of b is 20. Therefore, 
# the function should return 8.
# 
# Your function will be tested with pre-made examples as well as random ones.
# 
# If you can, try writing it in one line of code.
# -----------------------------------------------------------

.section .text
.global find_diff

# int find_diff(const int a[3], const int b[3])
# a0 = pointer to array a (3 ints)
# a1 = pointer to array b (3 ints)
# return: a0 = |vol(a) - vol(b)| 
find_diff:
    # 1. Calculate volume of cuboid A
    lw t0, 0(a0)      # t0 = a[0]
    lw t1, 4(a0)      # t1 = a[1]
    lw t2, 8(a0)      # t2 = a[2]
    mul t0, t0, t1    # t0 = a[0] * a[1]
    mul t0, t0, t2    # t0 = vol(a)
    
    # 2. Calculate volume of cuboid B
    lw t3, 0(a1)      # t3 = a[0]
    lw t4, 4(a1)      # t4 = a[1]
    lw t5, 8(a1)      # t5 = a[2]
    mul t3, t3, t4    # t3 = b[0] * b[1]
    mul t3, t3, t5    # t3 = vol(b)
    
    # 3. Compute difference: vol(a) - vol(b)
    sub a0, t0, t3    # a0 = vol(a) - vol(b)
    
    # 4. Get absolute value: |a0|
    bgez a0, done     # if a0 >= 0, skip negation
    neg a0, a0        # a0 = -a0
    
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