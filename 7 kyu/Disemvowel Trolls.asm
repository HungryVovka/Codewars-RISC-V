# -----------------------------------------------------------
# Trolls are attacking your comment section!
# 
# A common way to deal with this situation is to remove all 
# of the vowels from the trolls' comments, neutralizing the threat.
# 
# Your task is to write a function that takes a string and return 
# a new string with all vowels removed.
# 
# For example, the string "This website is for losers LOL!" 
# would become "Ths wbst s fr lsrs LL!".
# 
# Note: for this kata y isn't considered a vowel.
# -----------------------------------------------------------

.section .text
.global disemvowel
.extern strlen            # get input length to know how much memory we need
.extern malloc            # allocate fresh buffer for the output string

# char *disemvowel(const char *input)
# a0 = input string pointer
# return = a0 = pointer to newly allocated string (without vowels)
disemvowel:
    # Save return address and input pointer on stack
    addi sp, sp, -16      # reserve 16 bytes for ra and a0
    sd ra, (sp)           # store return address
    sd a0, 8(sp)          # store original input pointer

    # Allocate memory for result: len(input) + 1
    call strlen           # a0 = length of input
    addi a0, a0, 1        # reserve space for null terminator
    call malloc           # a0 = new buffer address
    beqz a0, exit_func    # if malloc fails, skip to cleanup

    # Setup pointers: a1 = input, a2 = output buffer
    ld a1, 8(sp)          # a1 = original input pointer
    mv a2, a0             # a2 = current write position in output buffer

    # Restore stack frame before main loop
    ld ra, (sp)           # restore return address
    addi sp, sp, 16       # restore stack pointer

loop:
    lb a5, (a1)           # load current character from input
    addi a1, a1, 1        # advance input pointer
    sb a5, (a2)           # tentatively write character to output
    beqz a5, done         # if null terminator, exit loop

    addi a2, a2, 1        # tentatively advance output pointer

    # Check if character is a vowel (A, E, I, O, U, a, e, i, o, u)
    li t0, 'A'
    beq a5, t0, rollback  # skip if 'A'
    li t0, 'E'
    beq a5, t0, rollback
    li t0, 'I'
    beq a5, t0, rollback
    li t0, 'O'
    beq a5, t0, rollback
    li t0, 'U'
    beq a5, t0, rollback

    li t0, 'a'
    beq a5, t0, rollback
    li t0, 'e'
    beq a5, t0, rollback
    li t0, 'i'
    beq a5, t0, rollback
    li t0, 'o'
    beq a5, t0, rollback
    li t0, 'u'
    beq a5, t0, rollback

    j loop                # not a vowel: keep character, continue

rollback:
    addi a2, a2, -1       # vowel detected: move output pointer back (drop character)
    j loop

done:
    ret

exit_func:
    # Restore stack and return if malloc failed
    ld ra, (sp)
    addi sp, sp, 16
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