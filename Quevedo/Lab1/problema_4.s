    .cpu 	cortex-m4       // Indica el procesador de destino  
    .syntax unified         // Habilita las instrucciones Thumb-2
    .thumb                  // Usar instrucciones Thumb y no ARM

/* Definicion de variables globales ***************************************/

    .section .data           // Define la sección de variables (RAM)
@ cadena:
@     .ascii "SISTEMAS CON MICROPROCESADORES"
@     .byte   0x00
cadena_2:
    .byte   0x01,0x06,0x7A,0x7B,0x7C,0x00

/* Programa principal *****************************************************/

    .section .text          // Define la sección de código (FLASH)
    .global reset           // Define el punto de entrada del código
    .func	main              // Indica al depurador el inicio de una funcion

reset:
    LDR     R0,=cadena_2      // Apunto R0 a vector (direccion base)
loop:
    BEQ     stop

    B       loop

stop:
    B       stop            //Lazo infinito para detener

    .pool                   // Almacenar las constantes de código
    .endfunc
