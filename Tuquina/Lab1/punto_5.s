        .cpu cortex-m4                  // Indica el procesador de destino
        .syntax unified                 // Habilita las instrucciones Thumb - 2
        .thumb                          // Usar instrucciones Thumb y no ARM

/*************************************************************************/
/*              Definición de variables globales                         */
/*************************************************************************/

        .section .data                  // Define la sección de variables (RAM)    

        base:
                .byte 0x00              // Mayor elemento del bloque (base)
                .byte 4                 // Cantidad de elementos del vector (base + 1)
                .byte 0x03, 0x3A, 0xAA, 0xF2    // Elementos del bloque de datos (base + 2)        


/*************************************************************************/
/*                          Programa Principal                           */
/*************************************************************************/

        .section .text                  //  Define la sección de código (FLASH)
        .global reset                   //  Define el punto de entrada del código
        .func main                      //  Indica al depurador el inicio de una función

reset:
        LDR     R0,=base                //  Guardo la dirección de base
        LDRB    R2, [R0], #1            //  En R2 irá el mayor elemento del vector
        LDRB    R1, [R0], #1            //  Guardo en R1 la cantidad de elementos del vector 
        MOV     R4, #0                  //  R4 será el índice
         

lazo:                                   //  Recorro el vector   
        LDRB    R3,[R0, R4]             //  Guardo el elemento [i] en R3 (R0+R4)
        CMP     R3, R2                  //  Comparo el elemento actual del vector con el mayor
        IT      HI                      //  Si es mayor sin signo:
        MOVHI   R2, R3                  //  Copio el valor máximo en R2
        ADD     R4, #1                  //  Incremento el índice en 1
        CMP     R4, R1                  //  Controlo si llegué al final del vector
        BLO     lazo                    //  Si no, regreso
        //LDR   R0,=base
        //STRB  R2, [R0]  
        STRB    R2,[R0,#-2]             //  Guardo el mayor valor

stop:   B       stop                    //  Lazo infinito para terminar la ejecución
        .pool                           //  Almacenar las constantes de código