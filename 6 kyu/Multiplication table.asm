# -----------------------------------------------------------
# Your task, is to create N×N multiplication table, of size provided in parameter.
# 
# For example, when given size is 3:
# 
# 1 2 3
# 2 4 6
# 3 6 9
# 
# For the given example, the return value should be:
# 
# [[1,2,3],[2,4,6],[3,6,9]]
# -----------------------------------------------------------

.section .text
.global multab

# Note:
#   do not allocate memory!
#   A0 points to linear memory [1..n, .., n..n*n]
#   so do use appropriate indices!

# unsigned int *multab(unsigned int *tab, unsigned int n)
# a0 = pointer to linear buffer for N×N table (no allocation needed)
# a1 = n (size of the table)
# return = a0 (pointer to filled table)
multab:
    # Save callee-saved registers on stack (ABI-compliant 16-byte alignment)
    addi sp, sp, -16  # reserve 16 bytes for ra and a0
    sd ra, (sp)       # store return address
    sd a0, 8(sp)      # store original buffer pointer
    
    # Initialize loop counters and base pointer
    mv t0, a1         # t0 = n (table size limit)
    li t1, 0          # t1 = i (current row index)
    li t2, 0          # t2 = j (current column index)
    mv t3, a0         # t3 = base address of tab

outer_loop:
    # Check outer loop condition: if i >= n, exit
    bge t1, t0, done
    li t2, 0          # reset column index for new row

inner_loop:
    # Check inner loop condition: if j >= n, move to next row
    bge t2, t0, next_row

    # Compute memory address for tab[i*n + j]
    mul t4, t1, t0    # t4 = i * n
    add t4, t4, t2    # t4 = linear index (i*n + j)
    slli t4, t4, 2    # convert to byte offset (index * 4)
    add t5, t3, t4    # t5 = pointer to current element

    # Prepare operands for multiplication: (i+1) * (j+1)
    addi t1, t1, 1    # t1 = i + 1
    addi t2, t2, 1    # t2 = j + 1

    # Perform multiplication via repeated addition (no mul instruction used)
    li t4, 0          # t4 = result = 0
    li t5, 0          # t5 = counter = 0

mul_loop:
    bge t5, t2, mul_done  # if counter >= (j+1), exit loop
    add t4, t4, t1        # result += (i+1)
    addi t5, t5, 1        # increment counter
    j mul_loop

mul_done:
    # Restore original loop indices
    addi t1, t1, -1     # t1 = i
    addi t2, t2, -1     # t2 = j

    # Recompute address to store result (since t5 was reused as counter)
    mul t5, t1, t0      # t5 = i * n
    add t5, t5, t2      # t5 = linear index (i*n + j)
    slli t5, t5, 2      # convert to byte offset
    add t5, t3, t5      # t5 = correct pointer to current element

    sw t4, 0(t5)        # store computed product into tab[i][j]

    addi t2, t2, 1      # increment column index
    j inner_loop        # continue inner loop

next_row:
    addi t1, t1, 1      # increment row index
    j outer_loop        # continue outer loop

done:
    # Restore stack frame and return
    ld ra, (sp)         # restore return address
    addi sp, sp, 16     # restore stack pointer
    ret                 # return to caller
    

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