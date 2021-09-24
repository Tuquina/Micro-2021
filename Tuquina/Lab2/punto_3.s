/****************************************************************************/
/*Rutina de incremento de segundos                                         */    
/*Recibe en R0 el valor numérico 1 (bandera de incremento)                  */
/*Recibe en R1 la direccion de los datos                                    */
/****************************************************************************/
.func incrementar
incrementar:
    PUSH {R4-R5}
    LDRB    R4, [R1]                //  Busca el valor menos significatio
    ADD     R4, R0                  //  Se incrementa en R0 cantidad (en 1)      
    MOV     R0, #0                  //  Setea el valor de retorno por defecto

    CMP     R4, #9                  
    BLS     final_incrementar       //  Salta si es menor o igual que 9

    SUB     R4, #9                  //  Calcula la cantidad que desbordó
    LDRB    R5, [R1, #1]            //  Busca el valor más significativo
    ADD     R5, R4                  //  Se incrementa en la cantidad de desborde
    MOV     R4, #0                  //  Resetea el menos significativo

    CMP     R5, #5                  
    BLS     salto_incrementar       //  Salta si es menor o igual que 5

    MOV     R5, #0                  //  Resetea el más significativo
    MOV     R0, #1                  //  Setea el valor de retorno por desborde

salto_incrementar:
    STRB    R5, [R1, #1]            //  Almacena el nuevo valor más significativo

final_incrementar:
    STRB    R4, [R1]                //  Almacena el nuevo valor menos significativo
    POP     {R4-R5}
    BX      LR                      //  Retorna al programa principal

    .pool                           //  Almacena las constantes de código
    .endfunc