        .cpu cortex-m4                  // Indica el procesador de destino
        .syntax unified                 // Habilita las instrucciones Thumb - 2
        .thumb                          // Usar instrucciones Thumb y no ARM

/*************************************************************************/
/*              Definición de variables globales                         */
/*************************************************************************/

        .section .data                  // Define la sección de variables (RAM)    

        numero:  
                .word   0x81000304
                .word   0x00200605      // La parte baja está en el primer espacio de la dirección       


/*************************************************************************/
/*                          Programa Principal                           */
/*************************************************************************/

        .section .text                  //  Define la sección de código (FLASH)
        .global reset                   //  Define el punto de entrada del código
        .func main                      //  Indica al depurador el inicio de una función

reset:
        LDR     R0,=numero              //  Guardo la dirección de memoria de numero
        MOV     R1, #0x0102             //  Almaceno la parte baja en R1
        MOVT    R1, #0xA056             //  Almaceno la parte alta
        BL      suma                    //  Voy a la subrutina de suma

stop:   B       stop                    //  Lazo infinito para terminar la ejecución
        .pool                           //  Almacenar las constantes de código        
         
/*
    Subrutina: Suma
    Suma dos números de 64 y 32bits. Devuelve el resultado en 64bits
    Parámetros: M[R0] puntero a palabra de 64 bits, R1 de 32bits
    Retorno: Carga en la dirección R0 el resultado de la suma
 */
suma:
        LDR     R4, [R0]                //  Cargo la parte baja del número en R4
        ADDS    R4, R1                  //  Sumo los primeros 32bits
        LDR     R5, [R0, #4]            //  Cargo en R5 la parte alta del número
        ADC     R5, #0                  //  Sumo la parte alta con el carry
        STR     R4, [R0]                //  Cargo la parte baja de la suma
        STR     R5, [R0, #4]            //  Cargo la parte alta de la suma
        BX      LR                      //  Salgo de la subrutina

