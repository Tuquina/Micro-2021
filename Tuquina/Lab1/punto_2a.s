        .cpu cortex-m4                  // Indica el procesador de destino
        .syntax unified                 // Habilita las instrucciones Thumb - 2
        .thumb                          // Usar instrucciones Thumb y no ARM

/*************************************************************************/
/*              Definición de variables globales                         */
/*************************************************************************/

        .section .data                  // Define la sección de variables (RAM)
        base:
                .hword  10              // Base -> Tamaño del vector (tendrá sólo 4 elementos)
                .space  20, 0x00        // Base+2 en adelante (máximo de 10 elementos)

/*************************************************************************/
/*                          Programa Principal                           */
/*************************************************************************/

        .section .text                  // Define la sección de código (FLASH)
        .global reset                   // Define el punto de entrada del código
        .func main                      // Indica al depurador el inicio de una función

reset:
        LDR     R0,=base                //  Apunto R0 al bloque de origen
        MOV     R1, #0                  //  Índice del vector
        MOV     R2, #0x55               //  Valor que quiero cargar
        LDR     R4, [R0]                //  Guardo el tope del vector en R4

lazo:                      
        STRH    R2, [R0,#2]!            //  Cargamos en base + 2
        ADD     R1, R1, #1              //  Incrementamos el índice en 1   
        CMP     R1, R4                  //  Determina si se cargó completo el vector
        BEQ     stop                    //  Termina la carga
        B       lazo                    //  Regresa al lazo

stop:   B       stop                    //  Lazo infinito para terminar la ejecución
        .pool                           //  Almacenar las constantes de código