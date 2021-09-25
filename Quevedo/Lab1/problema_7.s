    .cpu 	cortex-m4       // Indica el procesador de destino  
    .syntax unified         // Habilita las instrucciones Thumb-2
    .thumb                  // Usar instrucciones Thumb y no ARM

/* Definicion de variables globales ***************************************/

    .section .data          // Define la sección de variables (RAM)
destino:    
    .byte 0xFF              // Variable de 20 bytes en blanco

/* Programa principal *****************************************************/

    .section .text          // Define la sección de código (FLASH)
    .global reset           // Define el punto de entrada del código
    .func	main            // Indica al depurador el inicio de una funcion

reset:
    MOV     R0,#9           // Digito a representar en R0
    LDR     R1,=destino     // Apunta R1 al bloque de destino
    LDR     R3,=tabla       // Apunta R3 al bloque con la tabla
loop:
    LDRB    R0,[R3,R0]      // Cargo en R0 el elemento convertido con la tabla
    STRB    R0,[R1]         // Guardo el elemento convertido en 'destino'

stop:
    B       stop            // Lazo infinito para detener

    .pool                   // Almacenar las constantes de código

@ tabla:                      // Define la tabla de conversión 
@     .byte 0xFC,0x60,0xDA,0xF2,0x66      //0,1,2,3,4 (abcdefg0)
@     .byte 0xB6,0xBE,0xE0,0xFE,0xF6      //5,6,7,8,9

tabla:                      // Define la tabla de conversión 
    .byte 0x3F,0x60,0x5B,0x4F,0x66      //0,1,2,3,4 (0gfedcba)
    .byte 0x6D,0xCD,0x07,0x7F,0x6F      //5,6,7,8,9
    // 0xFC 1111.1100 -> 0011.1111 0x3F
    // 0110.0000 -> 0000.0110
    // 1101.1010 -> 0101.1011

    // 0xF6 1111.0110 -> 0110.1111 0x6F
    .endfunc
