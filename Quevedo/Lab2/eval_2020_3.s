    .cpu 	cortex-m4       // Indica el procesador de destino  
    .syntax unified         // Habilita las instrucciones Thumb-2
    .thumb                  // Usar instrucciones Thumb y no ARM

/* Definicion de variables globales ***************************************/
    .section .data          // Define la sección de variables (RAM)
vector_divisores:
    .space  40,0

/* Programa principal *****************************************************/
    .section .text          // Define la sección de código (FLASH)
    .global reset           // Define el punto de entrada del código
    .func	main            // Indica al depurador el inicio de una funcion
reset:
    MOV     R0,#18
    LDR     R1,=vector_divisores
    CMP     R0,#255
    BHI     stop
    BL      divisores
stop:
    B       stop            // Lazo infinito para detener
    .pool                   // Almacenar las constantes de código
    .endfunc
    
    .func   divisores
divisores:
    PUSH    {R4-R6}
    MOV     R4,#0           // Contador desde R4 hasta el numero ingresado
    MOV     R6,R1           // Contador desde R4 hasta el numero ingresado
recorrer:
    CMP     R4,R0           // Verifico si ya se llego al numero
    BEQ     final
    ADD     R4,#1
modulo:
    UDIV    R5,R0,R4        // Calculo el cociente de numero / divisor actual (R4)
    MUL     R5,R5,R4        // Calculo cociente * divisor (R4)
    SUB     R5,R0,R5        // Calculo resto = numero - cociente
    CMP     R5,#0           // Verifico si resto=0
    IT      EQ
    STRBEQ  R4,[R1],#1      // Si num mod contador = 0 guardo en el vector y desplazo
    B       recorrer
final:
    SUB     R0,R1,R6
    POP     {R4-R6}
    BX      LR
    .pool
    .endfunc
