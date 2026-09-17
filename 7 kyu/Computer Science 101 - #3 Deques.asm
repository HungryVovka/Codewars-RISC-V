# -----------------------------------------------------------
# Computer Science 101 - #3 Deques
# NOTE: The major content of this Kata is contained within the "Lesson" and 
# "Task" headings. Furthermore, if you are already familiar with how a deque 
# works, you may simply skip to the "Task" heading which contains all 
# the instructions you need to complete the Kata.
# 
# About this Kata Series
# Learn fundamental computer science concepts that every CS student must 
# know in depth such as algorithms, data structures and common data types 
# through implementing them from first principles.
# 
# Translators' Note
# Translations to any language providing built-in deque implementations 
# and/or datatypes that can function as such will be rejected without further reason.
# 
# Lesson
# Deques, short for "double-ended queues", are a generalization of stacks a
# nd queues in that items can be inserted and/or removed from both ends. 
# Some deques restrict either input or output to one end only, but a 
# full-on deque typically implements the following operations:
# 
# push front - Add an item to the front of the deque.
# pop front - Remove an item from the front of the deque (and return it).
# push back - Add an item to the back of the deque.
# pop back - Remove an item from the back of the deque (and return it).
# is empty - Is the deque empty?
# 
# Deques not returning the popped item must also implement "peek front" 
# and "peek back" which simply returns the front and back item respectively. 
# Note also that the exact names of the operations mentioned above can vary 
# wildly between implementations.
# 
# Deques are perhaps slightly less common than plain stacks/queues but find use 
# in certain well-know algorithms such as maximum subarray of size k. For this 
# reason many languages provide a built-in deque implementation, e.g. 
# Rust's std::collections::VecDeque.
# 
# Unlike stacks/queues, deques cannot be implemented efficiently using a 
# singly linked list. Specifically, no matter how hard you try, you can't 
# pop from the back of the deque in constant time if you use a singly 
# linked list. Therefore, a special type of linked list called the doubly 
# linked list must be used instead - a doubly linked list is one whose 
# nodes store its parent (previous node) as well as its child (next node). 
# This way, it becomes possible for all key operations to operate 
# in O(1) time. The major drawback is of course that each node in a 
# doubly-linked list occupies even more memory - it has to store two 
# references as well as the item itself. Some deque implementations choose 
# to use a (growable) circular array instead but it won't be covered in this Kata.
# 
# Task
# In this Kata we will be implementing our deque as a doubly linked list 
# where each node is defined as follows:
# 
# typedef struct node {
#   int data;
#   struct node *prev, *next;
# } Node;
# 
# Our deque is then defined as a wrapper around that list:
# 
# typedef struct {
#   Node *front, *back;
# } Deque;
# 
# Implement the following key operations:
# 
# void deque_push_front(Deque *deque, int data) - Adds data to the front 
# of the deque
# int deque_pop_front(Deque *deque) - Removes the front item of the deque 
# and returns it
# int deque_peek_front(const Deque *deque) - Returns the front item 
# of the deque. Should not modify the deque.
# void deque_push_back(Deque *deque, int data) - Adds data to the back of the deque
# int deque_pop_back(Deque *deque) - Removes the back item of the deque and returns it
# int deque_peek_back(const Deque *deque) - Returns the back item 
# of the deque. Should not modify the deque.
# bool deque_is_empty(const Deque *deque) - Checks whether the deque is empty. 
# Should not modify the deque.
# All operations must complete in O(1) time, otherwise there will be a timeout. 
# You may assume that the pop/peek operations in either end won't be called 
# on an empty deque provided you implement all 7 key operations correctly. 
# Also, try to manage your memory properly (not explicitly tested) and 
# beware of dangling pointers - if you are not careful enough, depending on 
# where you leave them, the tests (or even your own code!) may or may not crash.
# -----------------------------------------------------------

.section .text
    .global deque_push_front, deque_pop_front, deque_peek_front 
    .global deque_push_back, deque_pop_back, deque_peek_back, deque_is_empty
    .extern malloc
    .extern free

# malloc - allocate 24 bytes for a new Node
# free - release a Node after pop

# Node struct offsets:
# data: 0 (int, 4 bytes)
# prev: 8 (ptr, 8 bytes)
# next: 16 (ptr, 8 bytes)
#
# Deque struct offsets:
# front: 0 (ptr, 8 bytes)
# back: 8 (ptr, 8 bytes)

# void deque_push_front(Deque * deque, int data)
# a0 = deque, a1 = data
deque_push_front:
    addi sp, sp, -32
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    
    mv s0, a0           # s0 = deque (preserved across malloc)
    mv s1, a1           # s1 = data (preserved across malloc)
    
    li a0, 24           # node size
    call malloc         # a0 = new node
    
    sw s1, 0(a0)        # node->data = data
    sd zero, 8(a0)      # node->prev = NULL
    sd zero, 16(a0)     # node->next = NULL
    
    ld t0, 0(s0)        # t0 = deque->front
    bnez t0, pf_link    # if not empty, link at front
    
    # Empty deque: both pointers -> new node
    sd a0, 0(s0)        # deque->front = node
    sd a0, 8(s0)        # deque->back = node
    j pf_done
    
pf_link:
    # Link new node before current front
    sd t0, 16(a0)       # node->next = old front
    sd a0, 8(t0)        # old_front->prev = node
    sd a0, 0(s0)        # deque->front = node
    
pf_done:
    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    addi sp, sp, 32
    ret


# int deque_pop_front(Deque *deque)
# a0 = deque
# return: a0 = front element's data
deque_pop_front:
    addi sp, sp, -32
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)
    
    mv s0, a0           # s0 = deque
    
    ld t0, 0(s0)        # t0 = node to remove (deque->front)
    lw s1, 0(t0)        # s1 = node->data (save before free clobbers it)
    
    ld t1, 16(t0)       # t1 = node->next
    beqz t1, pf_last    # if next == NULL, was the only node
    
    # Not last: update front, clear new front's prev
    sd t1, 0(s0)
    sd zero, 8(t1)      # new_front->prev = NULL
    j pf_free
    
pf_last:
    # Was the only node: clear both pointers
    sd zero, 0(s0)      # deque->front = NULL
    sd zero, 8(s0)      # deque->back = NULL
    
pf_free:
    mv a0, t0           # free(node)
    call free
    
    mv a0, s1           # return saved data
    
    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    addi sp, sp, 32
    ret


# int deque_peek_front(const Deque *deque)
# a0 = deque
# return: a0 = front element's data
deque_peek_front:
    ld t0, 0(a0)        # t0 = deque->front
    lw a0, 0(t0)        # return front->data
    ret
    
  
# void deque_push_back(Deque *deque, int data)
# a0 = deque, a1 = data
deque_push_back:
    addi sp, sp, -32
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)

    mv s0, a0           # s0 = deque
    mv s1, a1           # s1 = data

    li a0, 24           # node size
    call malloc         # a0 = new node

    sw s1, 0(a0)        # node->data = data
    sd zero, 8(a0)      # node->prev = NULL
    sd zero, 16(a0)     # node->next = NULL

    ld t0, 8(s0)        # t0 = deque->back
    bnez t0, pb_link    # if not empty, link at back

    # Empty deque: both pointers -> new node
    sd a0, 0(s0)        # deque->front = node
    sd a0, 8(s0)        # deque->back = node
    j pb_done

pb_link:
    # Link new node after current back
    sd t0, 8(a0)        # node->prev = old back
    sd a0, 16(t0)       # old_back->next = node
    sd a0, 8(s0)        # deque->back = node

pb_done:
    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    addi sp, sp, 32
    ret


# int deque_pop_back(Deque *deque)
# a0 = deque
# return: a0 = back element's data
deque_pop_back:
    addi sp, sp, -32
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)

    mv s0, a0           # s0 = deque

    ld t0, 8(s0)        # t0 = node to remove (deque->back)
    lw s1, 0(t0)        # s1 = node->data (save before free)

    ld t1, 8(t0)        # t1 = node->prev
    beqz t1, pb_last    # if prev == NULL, was the only node

    # Not last: update back, clear new back's next
    sd t1, 8(s0)        # deque->back = node->prev
    sd zero, 16(t1)     # new_back->next = NULL
    j pb_free

pb_last:
    # Was the only node: clear both pointers
    sd zero, 0(s0)      # deque->front = NULL
    sd zero, 8(s0)      # deque->back = NULL

pb_free:
    mv a0, t0           # free(node)
    call free

    mv a0, s1           # return saved data

    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    addi sp, sp, 32
    ret
    
    
# int deque_peek_back(const Deque *deque)
# a0 = deque
# return: a0 = back element's data
deque_peek_back:
    ld t0, 8(a0)        # t0 = deque->back
    lw a0, 0(t0)        # return back->data
    ret


# bool deque_is_empty(const Deque *deque)
# a0 = deque
# return: a0 = 1 if empty, 0 otherwise
deque_is_empty:
    ld t0, 0(a0)        # t0 = deque->front
    seqz a0, t0         # a0 = (front == NULL) ? 1 : 0
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