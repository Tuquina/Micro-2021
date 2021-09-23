        .cpu cortex-m4                  // Indica el procesador de destino
        .syntax unified                 // Habilita las instrucciones Thumb - 2
        .thumb                          // Usar instrucciones Thumb y no ARM

/*************************************************************************/
/*              Definición de variables globales                         */
/*************************************************************************/

        .section .data                  // Define la sección de variables (RAM)
        base:
                .hword  4               // Base -> Tamaño del vector (tendrá sólo 4 elementos)
                .hword  0x55, 0x55, 0x55, 0x55
    

/*************************************************************************/
/*                          Programa Principal                           */
/*************************************************************************/

        .section .text                  // Define la sección de código (FLASH)
        .global reset                   // Define el punto de entrada del código
        .func main                      // Indica al depurador el inicio de una función

reset   B   reset                       // Final del programa