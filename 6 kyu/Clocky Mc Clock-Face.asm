# -----------------------------------------------------------
# Story
# Due to lack of maintenance the minute-hand has fallen 
# off Town Hall clock face.
# 
# And because the local council has lost most of our tax 
# money to an elaborate email scam there are no funds 
# to fix the clock properly.
# 
# Instead, they are asking for volunteer programmers 
# to write some code that tell the time by only looking at 
# the remaining hour-hand!
# 
# What a bunch of cheapskates!
# 
# Can you do it?
# 
# Kata
# Given the angle (in degrees) of the hour-hand, return 
# the time in 12 hour HH:MM format. Round down to the nearest minute.
# 
# Examples
# 12:00 = 0 degrees
# 
# 03:00 = 90 degrees
# 
# 06:00 = 180 degrees
# 
# 09:00 = 270 degrees
# 
# 12:00 = 360 degrees
# 
# Notes
# 0 <= angle <= 360
# 
# Do not make any AM or PM assumptions for the HH:MM result. 
# They are indistinguishable for this Kata.
# 
# 3 o'clock is 03:00, not 15:00
# 7 minutes past midnight is 12:07
# 7 minutes past noon is also 12:07
# -----------------------------------------------------------

.section .text
.global whatstime

# char *whatstime(char *outp, double angle)
# a0 = outp buffer (at least 6 bytes: HH:MM\0)
# fa0 = angle (double, 0–360)
# return = a0 (pointer to outp)
whatstime:
    # Save callee-saved registers on stack
    addi sp, sp, -16      # reserve 16 bytes for ra and a0
    sd ra, (sp)           # store return address
    sd a0, 8(sp)          # store original outp pointer
    
    # Compute total minutes in 12-hour cycle: minutes = angle * 2
    # fadd.d: FP double add; here used as angle * 2.0 (fa0 = fa0 + fa0)
    fadd.d fa0, fa0, fa0  # fa0 = angle + angle  (i.e., angle * 2.0)

    # Convert double minutes to integer (truncate toward zero)
    # fcvt.w.d: convert double (fa0) to 32-bit int (t0); rtz = round toward zero
    fcvt.w.d t0, fa0, rtz # t0 = (int)(angle * 2)

    # Compute hours and minutes from total minutes
    li t1, 60             # t1 = 60 (minutes per hour)
    div t2, t0, t1        # t2 = hours (0–11)
    rem t3, t0, t1        # t3 = minutes (0–59)

    # Adjust hour: 0 hours → 12 for 12-hour format
    beqz t2, set_twelve
    j write_time
    
set_twelve:
    li t2, 12             # set hour to 12 when it's 0

write_time:
    li t4, 10             # t4 = 10 (for digit decomposition)
    li t5, '0'            # t5 = ASCII '0' offset

    # Write hour tens digit
    div t6, t2, t4        # t6 = tens digit of hour
    add t6, t6, t5        # convert to ASCII
    sb t6, (a0)           # write to outp[0]

    # Write hour ones digit
    rem t6, t2, t4        # t6 = ones digit of hour
    add t6, t6, t5        # convert to ASCII
    sb t6, 1(a0)          # write to outp[1]

    # Write colon separator
    li t6, ':'            # t6 = ':'
    sb t6, 2(a0)          # write to outp[2]

    # Write minute tens digit
    div t6, t3, t4        # t6 = tens digit of minutes
    add t6, t6, t5        # convert to ASCII
    sb t6, 3(a0)          # write to outp[3]

    # Write minute ones digit
    rem t6, t3, t4        # t6 = ones digit of minutes
    add t6, t6, t5        # convert to ASCII
    sb t6, 4(a0)          # write to outp[4]

    # Null-terminate the string
    sb zero, 5(a0)        # write '\0' to outp[5]

    # Restore stack frame and return
    ld ra, (sp)           # restore return address
    addi sp, sp, 16       # restore stack pointer
    ret                   # return to caller
    

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