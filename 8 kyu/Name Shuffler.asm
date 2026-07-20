# -----------------------------------------------------------
# Write a function that returns a string in which firstname is swapped with last name.
# 
# Example(Input --> Output)
# 
# "john McClane" --> "McClane john"
# 
# RISC-V: The function signature is:
# 
# char *name_shuffler(char *shuffled, const char *name);
# 
# name is the input string and shuffled is the output buffer you should write to. 
# You may assume the output buffer is large enough to hold the result. 
# Return the output buffer.
# -----------------------------------------------------------

.section .text
.globl name_shuffler

# char *name_shuffler(char *shuffled, const char *name)
# a0 = shuffled (pointer to output buffer)
# a1 = name     (pointer to input string "FirstName LastName")
# return = a0   (original shuffled pointer)
name_shuffler:
    mv t0, a0   # Save original shuffled pointer to return in a0
    mv t1, a1   # t1 = pointer to start of first name
    
# Step: find the space character ' ' separating first and last na,e
find_space:
    lb t2, 0(t1)                # Read character from name
    li t3, ' '                  # ASCII space
    beq t2, t3, found_space     # Found space -> t1 now points to space
    addi t1, t1, 1              # Move forward
    j find_space
    
found_space:
    addi t2, t1, 1    # t2 = pointer to start of last name (right after space)
    
# Step 2: Copy last name to shuffled
copy_last_name:
    lb t3, 0(t2)          # Read character from last name
    beqz t3, add_space    # Reached end of string ('\0') -> go add space
    sb t3, 0(a0)          # Write to shuffled
    addi t2, t2, 1        # Advance last name pointer
    addi a0, a0, 1        # Advance output pointer
    j copy_last_name
    
# Step 3: Add space between last name and first name
add_space:
    li t3, ' '
    sb t3, 0(a0)      # Write ' ' to shuffled
    addi a0, a0, 1    # Advance output pointer
    
# Step 4: Copy first name to shuffled
copy_first_name:
    lb t3, 0(a1)      # Read character from first name
    li t4, ' '        # Stop when we hit the space
    beq t3, t4, done  # Reached space -> first name complete
    sb t3, 0(a0)      # Write to shuffled
    addi a1, a1, 1    # Advance first name pointer
    addi a0, a0, 1    # Advance output pointer
    j copy_first_name
    
# Step 5: Null-terminate and return original shuffled pointer
done:
    sb zero, 0(a0)    # Write NUL terminator
    mv a0, t0         # Restore original shuffled pointer for return
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