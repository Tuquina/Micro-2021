        .cpu cortex-m4                  // Indica el procesador de destino
        .syntax unified                 // Habilita las instrucciones Thumb - 2
        .thumb                          // Usar instrucciones Thumb y no ARM

/*************************************************************************/
/*              Definición de variables globales                         */
/*************************************************************************/

        .section .data                  // Define la sección de variables (RAM)    

        destino:
            .byte 0x00                  // Espacio usado para guardar la conversión      


/*************************************************************************/
/*                          Programa Principal                           */
/*************************************************************************/

        .section .text                  //  Define la sección de código (FLASH)
        .global reset                   //  Define el punto de entrada del código
        .func main                      //  Indica al depurador el inicio de una función

reset:
        MOV     R0, #5                  //  Guardo el valor 5 que quiero convertir
        LDR     R1, =destino            //  Apunta R1 al bloque destino
        LDR     R2, =tabla              //  Apunta R2 al bloque con la tabla
        LDRB    R3,[R2, R0]             //  Carga en R3 el elemento convertido
        STRB    R3, [R1]                //  Guardo la conversión en destino

stop:   B       stop                    //  Lazo infinito para terminar la ejecución
        .pool                           //  Almacenar las constantes de código

tabla:
        .byte 0x3F, 0x06, 0x5B, 0x4F, 0x66
        .byte 0x6D, 0x7D, 0x07, 0x7F, 0x6F
        .endfunc