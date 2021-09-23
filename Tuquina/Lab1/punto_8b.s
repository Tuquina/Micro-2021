        .cpu cortex-m4                  // Indica el procesador de destino
        .syntax unified                 // Habilita las instrucciones Thumb - 2
        .thumb                          // Usar instrucciones Thumb y no ARM

/*************************************************************************/
/*              Definición de variables globales                         */
/*************************************************************************/

        .section .data                  // Define la sección de variables (RAM)    

/*************************************************************************/
/*                          Programa Principal                           */
/*************************************************************************/

        .section .text                  //  Define la sección de código (FLASH)
        .global reset                   //  Define el punto de entrada del código
        .func main                      //  Indica al depurador el inicio de una función

reset: 
        MOV     R1, #145                //  Guardo el valor 49 que quiero calcular su raíz
        MOV     R0, #1                  //  Inicializo un contador

lazo:   MOV     R2, R0                  //  Copio el valor del contador en R2
        LSL     R2, #1                  //  Multiplico el contador por dos
        SUB     R2, #1                  //  Le resto 1 al resultado
        ADD     R3, R2                  //  Sumo el valor en R3
        CMP     R3, R1                  //  Comparo el resultado con el valor al que quiero calcular la raíz
        BHS     final                   //  Si es menor sigo, sino salto
        ADD     R0, #1                  //  Incremento en 1 el contador
        B       lazo

final:
        IT      HI                      //  Si el valor es mayor, decremento el contador
        SUBHI   R0, #1

stop:   B       stop                    //  Lazo infinito para terminar la ejecución
        .pool                           //  Almacenar las constantes de código