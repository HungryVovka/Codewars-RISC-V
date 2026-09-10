# -----------------------------------------------------------
# Introduction
# There is a war...between alphabets!
# There are two groups of hostile letters. The tension between left side letters 
# and right side letters was too high and the war began. The letters called 
# airstrike to help them in war - dashes and dots are spread throughout the 
# battlefield. Who will win?
# 
# Task
# Write a function that accepts a fight string which consists of only small 
# letters and * which represents a bomb drop place. Return who wins the fight 
# after bombs are exploded. When the left side wins return Left side wins!, 
# and when the right side wins return Right side wins!. In other cases, 
# return Let's fight again!.
# 
# The left side letters and their power:
# 
#  w - 4
#  p - 3 
#  b - 2
#  s - 1
# 
# The right side letters and their power:
# 
#  m - 4
#  q - 3 
#  d - 2
#  z - 1
# 
# The other letters don't have power and are only victims. Sum up each side's letters' 
# power values to determine which side wins. The * bombs kill the adjacent 
# letters ( i.e. aa*aa => a___a, **aa** => ______ );
# 
# Example (Input --> Output)
# "s*zz"           --> "Right side wins!"
# "*zd*qm*wp*bs*"  --> "Let's fight again!"
# "zzzz*s*"        --> "Right side wins!"
# "www*www****z"   --> "Left side wins!"
# -----------------------------------------------------------

.section .text
.globl alphabet_war

# char *alphabet_war(const char *fight)
# a0 = fight string (lowercase letters and '*')
# return: a0 = pointer to result string
# Registers:
# t0 = current position
# t1 = current char
# t2 = lest power sum
# t3 = right power sum
# t4/t5 = temps for neighbor and char checks

alphabet_war:
    mv t0, a0         # t0 = current position pointer
    li t2, 0          # t2 = left side power sum
    li t3, 0          # t3 = right side power sum
    
scan_loop:
    lb t1, 0(t0)      # t1 = current char
    beqz t1, compare  # end of string -> go to compare
    
    # Skip if current char is '*' (bomb itself, destroyed)
    li t4, '*'
    beq t1, t4, next_char
    
    # Check if left neighbor is '*' (kills this position)
    beq t0, a0, check_right     # first char has no left neighbor
    lb t4, -1(t0)               # t4 = char at position i-1
    li t5, '*'
    beq t4, t5, next_char       # left neighbor is bomb -> killed
    
check_right:
    # Check if right neighbor is '*' (kills this position)
    lb t4, 1(t0)                # t4 = char at position i+1
    beqz t4, survived           # end of string -> np right neighbor, safe
    li t5, '*'
    beq t4, t5, next_char       # right neighbor is bomb -> killed
  
survived:
    # Character survived bombs. Aff its power to the correct side.
    # Left side: w=4, p=3, b=2, s=1
    li t5, 'w'
    beq t1, t5, add_left4
    li t5, 'p'
    beq t1, t5, add_left3
    li t5, 'b'
    beq t1, t5, add_left2
    li t5, 's'
    beq t1, t5, add_left1
    # Right side: m=4, q=3, d=2, z=1
    li t5, 'm'
    beq t1, t5, add_right4
    li t5, 'q'
    beq t1, t5, add_right3
    li t5, 'd'
    beq t1, t5, add_right2
    li t5, 'z'
    beq t1, t5, add_right1
    j next_char                 # not a power letter -> victim, skip
    
add_left4:
    addi t2, t2, 4
    j next_char
add_left3:
    addi t2, t2, 3
    j next_char
add_left2:
    addi t2, t2, 2
    j next_char
add_left1:
    addi t2, t2, 1
    j next_char
add_right4:
    addi t3, t3, 4
    j next_char
add_right3:
    addi t3, t3, 3
    j next_char
add_right2:
    addi t3, t3, 2
    j next_char
add_right1:
    addi t3, t3, 1
    j next_char
    
next_char:
    addi t0, t0, 1
    j scan_loop
    
compare:
    # Compare left (t2) vs right (t3) power
    bgt t2, t3, left_wins
    blt t2, t3, right_wins
    lla a0, again_str         # tie -> "Let's fight again!"
    ret

left_wins:
    lla a0, left_str
    ret

right_wins:
    lla a0, right_str
    ret
  
.section .rodata
left_str:
    .asciz "Left side wins!"
right_str:
    .asciz "Right side wins!"
again_str:
    .asciz "Let's fight again!"


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