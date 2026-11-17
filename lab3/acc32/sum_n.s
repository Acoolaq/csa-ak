.data
.org 0x10

input_addr:  .word 0x80
output_addr: .word 0x84

minus_one:   .word 0xffffffff
overflow:   .word 0xcccccccc
n:      .word 0
buffer: .word 0
two:    .word 0x2
half:   .word 0
limit:  .word 65535


.text
.org 0x100
_start:
    load_addr input_addr
    load_acc
    store_addr n
    bgtz _check
    load_addr minus_one
    store_ind output_addr
    jmp _halt

_check:
    load_addr n
    sub limit
    bgtz _overflow

    load_addr n
    rem two
    beqz _even

    load_addr n
    store_addr buffer
    load_imm 0x1
    add n
    div two
    store_addr half
    load_addr buffer
    mul half
    store_ind output_addr
    jmp _halt

_even:
    load_addr n
    div two
    store_addr half
    load_imm 0x1
    add n
    mul half
    store_ind output_addr
    jmp _halt

_overflow:
    load_addr overflow
    store_ind output_addr

_halt:
    halt