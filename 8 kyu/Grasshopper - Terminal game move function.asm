# -----------------------------------------------------------
# Terminal game move function
# In this game, the hero moves from left to right. The player 
# rolls the die and moves the number of spaces indicated by the die two times.
# 
# Create a function for the terminal game that takes the current position 
# of the hero and the roll (1-6) and return the new position.
# 
# Example:
# move(3, 6) should equal 15
# -----------------------------------------------------------

.global move

# unsigned short move(unsigned short pos, unsigned short roll)
# a0 = current position of the hero
# a1 = dice roll value (1-6)
# return: a0 = new position after moving twice
move:
    # Multiply roll by 2 to get total steps
    add a1, a1, a1      # a1 = roll * 2
    
    # Add total steps to current position
    add a0, a0, a1      # a0 = pos + (roll * 2)
    
    ret                 # return new position in a0
    

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