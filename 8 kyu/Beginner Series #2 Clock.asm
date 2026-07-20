# -----------------------------------------------------------
# Clock shows h hours, m minutes and s seconds after midnight.
# 
# Your task is to write a function which returns 
# the time since midnight in milliseconds.
# 
# Example:
# h = 0
# m = 1
# s = 1
# 
# result = 61000
# 
# Input constraints:
# 
# 0 <= h <= 23
# 0 <= m <= 59
# 0 <= s <= 59
# RISC-V: The function signature is:
# 
# int past(int h, int m, int s);
# -----------------------------------------------------------

.section .text
.globl past

# int past(int h, int m, int s)
# a0 = h  (hours, 0–23)
# a1 = m  (minutes, 0–59)
# a2 = s  (seconds, 0–59)
# return = a0 (time in milliseconds since midnight)
past:
    # Compute milliseconds from hours: h * 3600 * 1000 = h * 3_600_000
    li t0, 3600000    # t0 = 3_600_000 (ms in one hour)
    mul t1, a0, t0    # t1 = h * 3_600_000

    # Compute milliseconds from minutes: m * 60 * 1000 = m * 60_000
    li t0, 60000      # t0 = 60_000 (ms in one minute)
    mul t2, a1, t0    # t2 = m * 60_000

    # Compute milliseconds from seconds: s * 1000
    li t0, 1000       # t0 = 1_000 (ms in one second)
    mul t3, a2, t0    # t3 = s * 1_000

    # Sum all parts: result = h_ms + m_ms + s_ms
    add a0, t1, t2    # a0 = h_ms + m_ms
    add a0, a0, t3    # a0 = (h_ms + m_ms) + s_ms

    ret               # return result in a0
    

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