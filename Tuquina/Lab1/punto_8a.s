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
        MOV     R1, #15                 //  Guardo el valor 49 que quiero calcular su raíz
        LDR     R2, =tabla              //  Apunto R2 a la tabla
        MOV     R0, #0                  //  Inicializo un contador

lazo:   LDRH    R3, [R2, R0, LSL #1]    //  Guardo en R3 el elemento [i] de la tabla
        CMP     R3, R1                  //  Comparo el cuadrado de la tabla con el valor que cargué en R1
        BHI     final                   //  Si la potencia es mayor voy al final
        ADD     R0, #1                  //  Incremento el contador
        B       lazo

final:  SUB     R0, #1                  //  Resto 1 al contador

stop:   B       stop                    //  Lazo infinito para terminar la ejecución
        .pool                           //  Almacenar las constantes de código

tabla:
        .hword 0x0001, 0x0001, 0x0004, 0x0009, 0x0010   // Debería ser una tabla de 256 valores de 16bits de ancho
        .hword 0x0019, 0x0024, 0x0031, 0x0040, 0x0051   // Por practicidad sólo se hicieron 10 para este ejercicio
        .endfunc