# -----------------------------------------------------------
# You are the greatest chef on earth. No one boils eggs like you! Your 
# restaurant is always full of guests, who love your boiled eggs. But 
# when there is a greater order of boiled eggs, you need some time, 
# because you have only one pot for your job. How much time do you need?
# 
# Your Task
# Implement a function, which takes a non-negative integer, representing 
# the number of eggs to boil. It must return the time in minutes (integer), 
# which it takes to have all the eggs boiled.
# 
# Rules
# you can put at most 8 eggs into the pot at once
# it takes 5 minutes to boil an egg
# we assume, that the water is boiling all the time (no time to heat up)
# for simplicity we also don't consider the time it takes to put eggs into 
# the pot or get them out of it
# 
# Example (Input --> Output)
# 0 --> 0
# 5 --> 5
# 10 --> 10
# -----------------------------------------------------------

.section .text
.global cooktime

# unsigned cooktime(unsigned eggs)
# a0 = number of eggs
# return: a0 = time in minutes required to cook all eggs
cooktime:
    beqz a0, done       # if eggs == 0 -> return 0
    
    # Convert unsigned 32-bit a0 to clean 64-bit to prevebt overflow on +7
    slli a0, a0, 32
    srli a0, a0, 32     # clear upper 32 bits (zero-extension)
    
    # Calculate batches = ceil(eggs / 8) using formula (eggs + 7) / 8
    addi a0, a0, 7      # a0 = eggs + 7
    srli a0, a0, 3      # a0 = (eggs + 7) / 8 (shift right by 3 divides by 8)
    
    # Calculate time = batches * 5
    li t0, 5
    mul a0, a0, t0      # a0 = batches * 5
    
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