        .cpu cortex-m4                  // Indica el procesador de destino
        .syntax unified                 // Habilita las instrucciones Thumb - 2
        .thumb                          // Usar instrucciones Thumb y no ARM

/*************************************************************************/
/*              Definición de variables globales                         */
/*************************************************************************/

        .section .data                  // Define la sección de variables (RAM)    

        base:
                .byte 0x06, 0x7A, 0x7B, 0x7C, 0x00         

/*************************************************************************/
/*                          Programa Principal                           */
/*************************************************************************/

        .section .text                  //  Define la sección de código (FLASH)
        .global reset                   //  Define el punto de entrada del código
        .func main                      //  Indica al depurador el inicio de una función

reset:
        LDR     R0,=base                //  Guardo la dirección de la cadena

lazo:                                   //  Recorro la cadena   
        LDRB    R1,[R0]                 //  Guardo el elemento [i] en R1
        MOV     R2, #0                  //  Contador de 1's
        MOV     R3, #0x01               //  Máscara        
        CMP     R1, 0x00                //  Controlo si es el final de la cadena
        BEQ     stop

control:                                //  Controlo la paridad bit a bit
        AND     R4, R1, R3              //  Guardo en R4 el resultado de operar R1 con la máscara
        LSL     R3, #1                  //  Desplazo la máscara un lugar a izquierda
        CMP     R4, 0x00                //  Reviso si el resultado del AND es mayor que 0
        IT      HI                      //  Si lo es:
        ADDHI   R2, #1                  //  Incremento el contador de 1's
        CMP     R3, 0x80                //  Controlo si la máscara llegó a 1000.0000 
        BLS     control                 //  Si no llegó salto a control
        LSRS    R2,#1                   //  Roto un bit a la derecha
                                        //  El lsb de R2 nos indica la paridad
        IT      HS                      //  Controlo el valor del carry
        ORRHS   R1, #0x80               //  Pongo en 1 el msb del primer byte
        STRB    R1, [R0], #1            //  Reescribo el valor del elemento [i] del vector y hago i+1
        B       lazo            

stop:   B       stop                    //  Lazo infinito para terminar la ejecución
        .pool                           //  Almacenar las constantes de código
