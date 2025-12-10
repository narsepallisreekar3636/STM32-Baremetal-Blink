.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.thumb

.global g_pfnVectors
.global Reset_Handler

/* Top of stack */
.equ _estack, 0x20020000     /* 128KB SRAM end */

/* Vector table */
.section .isr_vector, "a", %progbits
g_pfnVectors:
    .word _estack            /* Initial stack pointer */
    .word Reset_Handler      /* Reset handler */
    .word 0                  /* NMI */
    .word 0                  /* HardFault */
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0

/* external symbols from linker */
.extern _sidata
.extern _sdata
.extern _edata
.extern _sbss
.extern _ebss
.extern SystemInit
.extern main

.section .text.Reset_Handler
Reset_Handler:

    /* Copy .data to RAM */
    ldr r0, =_sdata
    ldr r1, =_edata
    ldr r2, =_sidata
1:
    cmp r0, r1
    itt lt
    ldrlt r3, [r2], #4
    strlt r3, [r0], #4
    blt 1b

    /* Zero .bss */
    ldr r0, =_sbss
    ldr r1, =_ebss
    movs r2, #0
2:
    cmp r0, r1
    itt lt
    strlt r2, [r0], #4
    blt 2b

    /* Call SystemInit */
    bl SystemInit

    /* Call main */
    bl main

hang:
    b hang
