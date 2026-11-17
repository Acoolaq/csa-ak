.data
.org 0x88

input_addr:     .word 0x80
output_addr:    .word 0x84
overflow:       .word 0xCCCCCCCC
max_int32:      .word 0x40000000
n:              .word 0
result:         .word 0x1

.text
_start:
    read_input
    check_input
    if negative_input

    calculate
    write_output
    halt

negative_input:
    lit -1
    !p result
    write_output
    halt

read_input:
    @p input_addr
    a!
    @
    !p n
    ;

check_input:
    @p n
    -if _notneg
    lit 0
    ;

_notneg:
    lit 1
    ;

calculate:
_loop:
    @p result
    @p n
    inv
    +
    lit 1
    +
    if _done

    @p result
    @p n
    inv
    +
    lit 1
    +
    -if _done

    check_overflow
    if _save

    @p overflow
    !p result
    ;

_save:
    @p result
    2*
    !p result

    lit 0
    if _loop

_done:
    ;

check_overflow:
    @p result
    @p max_int32
    inv
    +
    lit 1
    +
    if _limit
    lit 0
    ;

_limit:
    lit 1
    ;

write_output:
    @p output_addr
    a!
    @p result
    !
    ;