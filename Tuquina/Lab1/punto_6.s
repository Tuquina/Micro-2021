        .cpu cortex-m4                  // Indica el procesador de destino
        .syntax unified                 // Habilita las instrucciones Thumb - 2
        .thumb                          // Usar instrucciones Thumb y no ARM

/*************************************************************************/
/*              Definición de variables globales                         */
/*************************************************************************/

        .section .data                  // Define la sección de variables (RAM)    

        bloque:
                .byte   0x46, 0x1F, 0x33, 0x2A

        base:
                .word   bloque          // Dirección del vector (Base)
                .byte   0x00            // Checksum (Base + 4)

/*************************************************************************/
/*                          Programa Principal                           */
/*************************************************************************/

        .section .text                  //  Define la sección de código (FLASH)
        .global reset                   //  Define el punto de entrada del código
        .func main                      //  Indica al depurador el inicio de una función

reset:
        MOV     R0, #4                  //  Cantidad de elementos del bloque
        LDR     R1, =base               //  Almaceno la dirección a base
        LDR     R5, [R1]                //  Almaceno la dirección del bloque
        MOV     R2, #0                  //  Inicializo R2 como índice
        MOV     R4, #0                  //  R4 será el checksum y lo inicializo en 0

lazo:   LDRB    R3, [R5,R2]             //  Cargo el elemento [i] del bloque
        ADD     R2, #1                  //  Incremento el índice
        ADD     R4, R3                  //  Sumo el byte sin carry
        CMP     R2, R0                  //  ¿Llegué al final del bloque?
        BLO     lazo                    //  Si es así vuelvo al lazo
        STRB    R4, [R1, R2]            //  Guardo el checksum

stop:   B       stop                    //  Lazo infinito para terminar la ejecución
        .pool                           //  Almacenar las constantes de código