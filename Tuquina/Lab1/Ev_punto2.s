        .cpu cortex-m4                  // Indica el procesador de destino
        .syntax unified                 // Habilita las instrucciones Thumb - 2
        .thumb                          // Usar instrucciones Thumb y no ARM

/*************************************************************************/
/*              Definición de variables globales                         */
/*************************************************************************/

        .section .data                  // Define la sección de variables (RAM)    

        vector:
                .byte 0x06, 0x85, 0x78, 0xF8, 0xE8, 0x80         

/*************************************************************************/
/*                          Programa Principal                           */
/*************************************************************************/

        .section .text                  //  Define la sección de código (FLASH)
        .global reset                   //  Define el punto de entrada del código
        .func main                      //  Indica al depurador el inicio de una función

reset:
        LDR     R0,=vector                //  Guardo la dirección de la cadena

lazo:                                   //  Recorro la cadena   
        LDRB    R1,[R0]                 //  Guardo el elemento [i] en R1   
        MOV     R2, 0x01                //  Máscara que voy a usar 
        MOV     R3, 0x00                //  Usaré R3 como bandera
        MOV     R5, 0x00                //  Usaré R5 como contador de negativos
        CMP     R1, 0x80                //  Controlo si es el final de la cadena
        BEQ     final
        
lazo1:
        AND     R4, R1, 0x80            //  Hago un AND con el último bit 
        CMP     R4, 0x80                //  Controlo si el número es negativo
        IT      EQ
        ADDEQ   R5, #1                  //  Incremento el contador
        BNE     lazo3                   //  Si no lo es sale:

lazo2:  AND     R4, R1, R2
        CMP     R4, R2                  //  Controlo el bit [i] con la máscara
        IT      EQ
        ADDEQ   R3, #1                  //  Al encontrar un 1 incremento el control                            
        CMP     R3, #1                  //  Controlo si el control es mayor que 1
        IT      HI 
        EORHI   R1, R2                  //  Invierto el bit que marca la máscara
        LSL     R2, #1                  //  Desplazo la máscara un lugar a izquierda
        CMP     R2, 0x80                //  Controlo si la máscara está en el último bit
        BEQ     lazo3
        B       lazo2

lazo3:
        STRB    R1, [R0], #1            //  Reescribo el valor del elemento [i] del vector y hago i+1
        B       lazo          

final:
        LDR     R2, =tabla              //  Apunta R2 al bloque con la tabla
        LDRB    R1,[R2, R5]             //  Carga en R5 el elemento convertido

stop:   B       stop                    //  Lazo infinito para terminar la ejecución
        .pool                           //  Almacenar las constantes de código
tabla:
        .byte 0x3F, 0x06, 0x5B, 0x4F, 0x66
        .byte 0x6D, 0x7D, 0x07, 0x7F, 0x6F