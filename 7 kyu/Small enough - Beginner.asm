# -----------------------------------------------------------
# You will be given an array and a limit value. You must check that all values 
# in the array are below or equal to the limit value. If they are, return true. 
# Else, return false.
# 
# You can assume all values in the array are numbers.
# -----------------------------------------------------------

.section .text
.global small_enough

# bool small_enough(const int *arr, size_t len, int lim)
# a0 = arr  (pointer to array)
# a1 = len  (number of elements)
# a2 = lim  (limit value)
# return = a0 (1 = true if all <= lim, 0 = false otherwise)
small_enough:
    li t0, 0    # t0 = i = 0 (loop counter)
    
loop:
    bge t0, a1, all_ok      # if i >= len -> all elements checked, return true
    
    slli t1, t0, 2          # t1 = i * 4 (byte offset)
    add t1, a0, t1          # t1 = &arr[i]
    lw t2, 0(t1)            # t2 = arr[i]
    
    blt t2, a2, next_iter   # if arr[i] < lim -> OK, go to next
    beq t2, a2, next_iter   # if arr[i] == lim -> OK, go to next
    
    # If we are here, arr[i] > lim -> condition failed
    li a0, 0                # set result = false
    ret
    
next_iter:
    addi t0, t0, 1      # i++
    j loop
    
all_ok:
    li a0, 1            # set result = true (all elements <= lim)
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