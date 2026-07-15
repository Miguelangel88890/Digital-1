.equ WS_BASE,   0x430000  
.equ WS_OP_A,   0x04
.equ WS_INIT,   0x0C
.equ WS_RESULT, 0x10
.equ WS_DONE,   0x14

.section .text
.globl test_ws2812
# a0 * a1
  
test_ws2812:
  li   gp, WS_BASE 
  sw   a0, WS_OP_A(gp) 
  li   t0, 1 
  sw   t0, WS_INIT(gp)
  sw   zero, WS_INIT(gp)  
espera:
    lw   t1, WS_DONE(gp)
    and  t1, t1, t0
    beqz t1, espera
    lw   a0, WS_RESULT(gp)
  ret