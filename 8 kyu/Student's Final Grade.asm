# -----------------------------------------------------------
# Create a function finalGrade, which calculates 
# the final grade of a student depending on two parameters: 
# a grade for the exam and a number of completed projects.
# 
# This function should take two arguments: exam - grade for 
# exam (from 0 to 100); projects - number of completed 
# projects (from 0 and above);
# 
# This function should return a number (final grade). There are 
# four types of final grades:
# 
# 100, if a grade for the exam is more than 90 or if a number 
# of completed projects more than 10.
# 90, if a grade for the exam is more than 75 and if a number 
# of completed projects is minimum 5.
# 75, if a grade for the exam is more than 50 and if a number 
# of completed projects is minimum 2.
# 0, in other cases
# 
# Examples(Inputs-->Output):
# 
# 100, 12 --> 100
# 99, 0 --> 100
# 10, 15 --> 100
# 
# 85, 5 --> 90
# 
# 55, 3 --> 75
# 
# 55, 0 --> 0
# 20, 2 --> 0
# 
# *Use Comparison and Logical Operators.
# -----------------------------------------------------------

.section .text
.globl final_grade

# unsigned final_grade(unsigned exam, unsigned nproj)
# a0 = exam   (0–100)
# a1 = nproj  (>= 0)
# return = a0 (final grade: 100, 90, 75, or 0)
final_grade:
    # Check first condition: exam > 90 OR nproj > 10 → return 100
    li t0, 90
    bgt a0, t0, return_100    # if exam > 90 → 100

    li t0, 10
    bgt a1, t0, return_100    # if nproj > 10 → 100

    # Check second condition: exam > 75 AND nproj >= 5 → return 90
    li t0, 75
    ble a0, t0, check_third   # if exam <= 75 → skip to third condition

    li t0, 5
    blt a1, t0, check_third   # if nproj < 5 → skip to third condition

    li a0, 90                 # set result to 90
    ret

check_third:
    # Check third condition: exam > 50 AND nproj >= 2 → return 75
    li t0, 50
    ble a0, t0, return_0      # if exam <= 50 → 0

    li t0, 2
    blt a1, t0, return_0      # if nproj < 2 → 0

    li a0, 75                 # set result to 75
    ret

return_100:
    li a0, 100    # set result to 100
    ret

return_0:
    li a0, 0      # set result to 0
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