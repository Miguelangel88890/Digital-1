.section .text
.globl print_bin32

# Entrada:
#   a0 = valor de 32 bits a imprimir

print_bin32:
    addi sp, sp, -20
    sw ra, 16(sp)
    sw t0, 12(sp)
    sw t1, 8(sp)
    sw t2, 4(sp)
    sw a0, 0(sp)

    li t0, 32          # contador de bits

loop:
    srli t1, a0, 31    # extrae el MSB

    beqz t1, cero

uno:
    li a0, '1'
    call putchar
    j siguiente

cero:
    li a0, '0'
    call putchar

siguiente:
    lw a0, 0(sp)       # recuperar el dato
    slli a0, a0, 1     # desplazar al siguiente bit
    sw a0, 0(sp)

    addi t0, t0, -1
    bnez t0, loop

    # salto de línea
    li a0, 10
    call putchar
    li a0, 13
    call putchar

    lw a0, 0(sp)
    lw t2, 4(sp)
    lw t1, 8(sp)
    lw t0, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20
    ret