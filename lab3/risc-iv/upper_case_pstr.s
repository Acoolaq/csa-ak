.data
buffer: .byte '________________________________'

.text
.org 0x88
_start:
    addi    t1, zero, 1
    addi    t2, zero, 0x20
    addi    t3, zero, '\n'
    addi    t4, zero, 'a'
    addi    t5, zero, 123
read_loop:
    lb      t0, 0x80(zero)
    beq     t0, t3, read_done
    beq     t1, t2, overflow
    blt     t0, t4, store_char
    bge     t0, t5, store_char
    addi    t0, t0, -32
store_char:
    sb      t0, 0(t1)
    addi    t1, t1, 1
    j       read_loop
read_done:
    addi    t1, t1, -1
    sb      t1, 0(zero)
    addi    t2, zero, 1
print_loop:
    blt     t1, t2, exit
    lb      t0, 0(t2)
    sb      t0, 0x84(zero)
    addi    t2, t2, 1
    j       print_loop
overflow:
    lui     t0, %hi(0xCCCCCCCC)
    addi    t0, t0, %lo(0xCCCCCCCC)
    sw      t0, 0x84(zero)
exit:
    halt