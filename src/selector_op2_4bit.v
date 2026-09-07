module selector_op2_4bit (
    input [3:0] OP2,          //Segundo operando ingresado normalmente
    input [3:0] ANTERIOR,     //Resultado de la operación anterior (para encadenar cálculos)
    input usar_anterior,      //1 si se debe usar el resultado anterior en vez de OP2
    output [3:0] R            //Valor final que se usará como segundo operando
);
   
    //Señal negada de "usar_anterior", se usa para detectar cuando corresponde usar OP2
    wire nSel;

    //Señales auxiliares para armar cada bit del resultado final
    wire op2_0, ant_0;
    wire op2_1, ant_1;
    wire op2_2, ant_2;
    wire op2_3, ant_3;

    not (nSel, usar_anterior);


    //Para cada bit, se elige entre OP2 o ANTERIOR según el valor de "usar_anterior"
    //Esto funciona como un multiplexor hecho con compuertas and y or:
    //Si usar_anterior = 0, se usa OP2
    //Si usar_anterior = 1, se usa ANTERIOR

    and (op2_0, nSel, OP2[0]);
    and (ant_0, usar_anterior, ANTERIOR[0]);
    or (R[0], op2_0, ant_0);

    and (op2_1, nSel, OP2[1]);
    and (ant_1, usar_anterior, ANTERIOR[1]);
    or (R[1], op2_1, ant_1);

    and (op2_2, nSel, OP2[2]);
    and (ant_2, usar_anterior, ANTERIOR[2]);
    or (R[2], op2_2, ant_2);

    and (op2_3, nSel, OP2[3]);
    and (ant_3, usar_anterior, ANTERIOR[3]);
    or (R[3], op2_3, ant_3);

endmodule
