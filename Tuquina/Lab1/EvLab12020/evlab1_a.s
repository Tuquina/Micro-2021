/* Escriba un programa en lenguaje ensamblador para el ARM Cortex-M4 que procesa un vector 
de bytes ubicado a partir de la dirección base, lee todos los elementos del vector hasta
encontrar el valor cero y en ese momento finalice devolviendo el resultado.

a) El programa debe almacenar en la dirección resultado la cantidad de números pares y en
la dirección resultado+1 la cantidad de números impares que contiene el vector.

b) Modifique el programa anterior para que además almacene en la dirección resultado+2
la cantidad de números positivos y en la dirección resultado+3 la cantidad de números
negativos que contiene el vector. */

    .cpu cortex-m4          // Indica el procesador de destino
    .syntax unified         // Habilita las instrucciones Thumb - 2
    .thumb                  // Usar instrucciones Thumb y no ARM

/*************************************************************************/
/*              Definición de variables globales                         */
/*************************************************************************/

    .section .data          // Define la sección de variables (RAM)    

    base:
            .byte   0x46, 0x1F, 0x33, 0x2A, 0x5D, 0x00

    resultado:
            .space  4       // Resultado cuenta con 4 espacios

/*************************************************************************/
/*                         Programa Principal                            */
/*************************************************************************/

    .section .text          // Define la sección de código (FLASH)
    .global reset           // Define el punto de entrada del código
    .func main              // Inidica al depurador el inicio de una funcion

reset: 
    MOV R0,#0x00            // Guardo el valor cero en R0, para contar pares
    MOV R1,#0x00            // Guardo el valor cero en R1, para contar impares
    LDR R2,=base            // Apunta a la dirección de base
    LDR R4,=resultado       // Apunto a la dirección de resultado

lazo: 
    LDRB R3,[R2],#1         // Carga el primer número del vector base e incremento la dirección de R2 (base)
    CMP R3,#0x00            // Compara para saber si el vector es 0
    BEQ guardar             // Si es igual a 0, termina el vector se dirige a guardar los resultados
                            
ParImpar:
    AND R3, #0x01           // Realizo un AND para ver si el vector termina en 1, osea, es impar
    CMP R3,#0x01            // Comparo R3 con 01 para saber si es impar
    ITE EQ                  // Si los registros son iguales
    ADDEQ R1,#1             // Entonces incrementa resultado en impar
    ADDNE R0,#1             // Entonces incrementa resultado en par
    B lazo                  // Retorno a lazo para leer el siguiente elemento del vector

guardar:
    STRB R0,[R4],#1         // Guardo el valor de los números pares en resultado e incremento uno
    STRB R1,[R4]            // Guardo el valor de los números impares en resultado+1

stop: 
    B stop

.endfunc