# -----------------------------------------------------------
# There is a war and nobody knows - the alphabet war!
# There are two groups of hostile letters. The tension between left 
# side letters and right side letters was too high and the war began.
# 
# Task
# Write a function that accepts fight string consists of only small letters 
# and return who wins the fight. When the left side wins return Left side wins!, 
# when the right side wins return Right side wins!, in other case return Let's 
# fight again!.
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
# The other letters don't have power and are only victims. Sum up each 
# side's letters' power values to determine which side wins.
# 
# Example
# AlphabetWar("z");        //=> Right side wins!
# AlphabetWar("zdqmwpbs"); //=> Let's fight again!
# AlphabetWar("zzzzs");    //=> Right side wins!
# AlphabetWar("wwwwwwz");  //=> Left side wins!
# -----------------------------------------------------------

.section .text
    .globl alphabet_war

# char *alphabet_war(const char *fight)
# a0 = fight string (lowercase letters only)
# return: a0 = pointer to result string
# Registers:
# t0 = current char
# t1 = left power sum
# t2 = right ppower sum
# t3 = current position pointer
# t4 = temp for comparisons

alphabet_war:
    mv t3, a0       # t3 = current position pointer
    li t1, 0        # t1 = left power sum = 0
    li t2, 0        # t2 = right power sum = 0
  
scan_loop:
    lb t0, 0(t3)        # t0 = current char
    beqz t0, compare    # end of string -> compare sums
    
    # Left side: w = 4, p = 3, b = 2, s = 1
    li t4, 'w'
    beq t0, t4, add_left4
    li t4, 'p'
    beq t0, t4, add_left3
    li t4, 'b'
    beq t0, t4, add_left2
    li t4, 's'
    beq t0, t4, add_left1
    
    # Right side: m = 4, q = 3, d = 2, z = 1
    li t4, 'm'
    beq t0, t4, add_right4
    li t4, 'q'
    beq t0, t4, add_right3
    li t4, 'd'
    beq t0, t4, add_right2
    li t4, 'z'
    beq t0, t4, add_right1
    
    j next_char         # not a power letter -> victim, skip
    
add_left4:
    addi t1, t1, 4
    j next_char
add_left3:
    addi t1, t1, 3
    j next_char
add_left2:
    addi t1, t1, 2
    j next_char
add_left1:
    addi t1, t1, 1
    j next_char
add_right4:
    addi t2, t2, 4
    j next_char
add_right3:
    addi t2, t2, 3
    j next_char
add_right2:
    addi t2, t2, 2
    j next_char
add_right1:
    addi t2, t2, 1
    
next_char:
    addi t3, t3, 1
    j scan_loop
    
compare:
    bgt t1, t2, left_wins
    blt t1, t2, right_wins
    lla a0, again_str       # tie -> "Let's fight again!"
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