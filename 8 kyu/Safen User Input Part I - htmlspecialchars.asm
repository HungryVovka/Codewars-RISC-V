# -----------------------------------------------------------
# Safen User Input Part I - htmlspecialchars
# You are a(n) novice/average/experienced/professional/world-famous 
# Web Developer (choose one) who owns a(n) 
# simple/clean/slick/beautiful/complicated/professional/business 
# website (choose one or more) which contains form fields 
# so visitors can send emails or leave a comment on your 
# website with ease. However, with ease comes danger. Every now 
# and then, a hacker visits your website and attempts to compromise 
# it through the use of XSS (Cross Site Scripting). This is done 
# by injecting script tags into the website through form fields 
# which may contain malicious code (e.g. a redirection to 
# a malicious website that steals personal information).
# 
# Mission
# Your mission is to implement a function that converts the following 
# potentially harmful characters:
# 
# < --> &lt;
# > --> &gt;
# " --> &quot;
# & --> &amp;
# 
# Good luck :D
# 
# RISC-V: the function signature is
# 
# void htmlspecialchars(const char *str, char *out);
# 
# str is the input string. Write your result to out. You may 
# assume out is large enough to hold the result. 
# You do not need to return anything.
# -----------------------------------------------------------

.section .text
.globl htmlspecialchars

# void htmlspecialchars(const char *str, char *out)
# a0 = str  (input string pointer)
# a1 = out  (output buffer pointer; assumed large enough for result)
# no return value
htmlspecialchars:
    # Main processing loop: iterate over input string until NUL terminator
loop:
    lb t0, 0(a0)    # t0 = current character from str[a0]
    beqz t0, done   # if char == 0 (NUL), end of string → go to done

    # Check for '<' -> replace with "&lt;"
    li t1, '<'
    beq t0, t1, write_lt

    # Check for '>' -> replace with "&gt;"
    li t1, '>'
    beq t0, t1, write_gt

    # Check for '"' -> replace with "&quot;"
    li t1, '"'
    beq t0, t1, write_quot

    # Check for '&' -> replace with "&amp;"
    li t1, '&'
    beq t0, t1, write_amp

    # If none of the special characters, copy as-is
    sb t0, 0(a1)      # out[a1] = str[a0] (single byte copy)
    addi a0, a0, 1    # move input pointer to next character
    addi a1, a1, 1    # move output pointer to next position
    j loop            # continue to next iteration

write_lt:
    # Write "&lt;" (4 bytes: '&', 'l', 't', ';')
    li t2, '&'                      # t2 = '&'
    sb t2, 0(a1); addi a1, a1, 1
    li t2, 'l'                      # t2 = 'l'
    sb t2, 0(a1); addi a1, a1, 1
    li t2, 't'                      # t2 = 't'
    sb t2, 0(a1); addi a1, a1, 1
    li t2, ';'                      # t2 = ';'
    sb t2, 0(a1); addi a1, a1, 1

    addi a0, a0, 1    # advance input pointer past processed '<'
    j loop            # return to main loop

write_gt:
    # Write "&gt;" (4 bytes: '&', 'g', 't', ';')
    li t2, '&'                      # t2 = '&'
    sb t2, 0(a1); addi a1, a1, 1
    li t2, 'g'                      # t2 = 'g'
    sb t2, 0(a1); addi a1, a1, 1
    li t2, 't'                      # t2 = 't'
    sb t2, 0(a1); addi a1, a1, 1
    li t2, ';'                      # t2 = ';'
    sb t2, 0(a1); addi a1, a1, 1

    addi a0, a0, 1    # advance input pointer past processed '>'
    j loop            # return to main loop

write_quot:
    # Write "&quot;" (6 bytes: '&', 'q', 'u', 'o', 't', ';')
    li t2, '&'                      # t2 = '&'
    sb t2, 0(a1); addi a1, a1, 1
    li t2, 'q'                      # t2 = 'q'
    sb t2, 0(a1); addi a1, a1, 1
    li t2, 'u'                      # t2 = 'u'
    sb t2, 0(a1); addi a1, a1, 1
    li t2, 'o'                      # t2 = 'o'
    sb t2, 0(a1); addi a1, a1, 1
    li t2, 't'                      # t2 = 't'
    sb t2, 0(a1); addi a1, a1, 1
    li t2, ';'                      # t2 = ';'
    sb t2, 0(a1); addi a1, a1, 1

    addi a0, a0, 1    # advance input pointer past processed '"'
    j loop            # return to main loop

write_amp:
    # Write "&amp;" (5 bytes: '&', 'a', 'm', 'p', ';')
    li t2, '&'                      # t2 = '&'
    sb t2, 0(a1); addi a1, a1, 1
    li t2, 'a'                      # t2 = 'a'
    sb t2, 0(a1); addi a1, a1, 1
    li t2, 'm'                      # t2 = 'm'
    sb t2, 0(a1); addi a1, a1, 1
    li t2, 'p'                      # t2 = 'p'
    sb t2, 0(a1); addi a1, a1, 1
    li t2, ';'                      # t2 = ';'
    sb t2, 0(a1); addi a1, a1, 1

    addi a0, a0, 1    # advance input pointer past processed '&'
    j loop            # return to main loop

done:
    sb zero, 0(a1)    # write NUL terminator ('\0') to finish output string
    ret               # return to caller
    

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