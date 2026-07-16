.equ bTB_BASE,   0x410000  
.equ bTB_OP_A,   0x04
.equ bTB_INIT,   0x0C
.equ bTB_RESULT, 0x10
.equ bTB_DONE,   0x14

.section .text
.globl test_binToBCD
# a0 * a1
  
test_binToBCD:
  li   gp, bTB_BASE 
  sw   a0, bTB_OP_A(gp) 
  li   t0, 1 
  sw   t0, bTB_INIT(gp)
  sw   zero, bTB_INIT(gp)  
espera:
    lw   t1, bTB_DONE(gp)
    and  t1, t1, t0
    beqz t1, espera
    lw   a0, bTB_RESULT(gp)
  ret