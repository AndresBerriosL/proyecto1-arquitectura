module control_valores (
    input [1:0] estado,  //Estado actual de la calculadora
    output habilitar_op, //1 si en el estado actual se debe permitir modificar la operación
    output habilitar_a,  //1 si en el estado actual se debe permitir modificar el operando A
    output habilitar_b   //1 si en el estado actual se debe permitir modificar el operando B
);

    //Señales negadas de "estado", se usan para detectar las distintas combinaciones de estado
    wire nE1;
    wire nE0;

    not (nE1, estado[1]);
    not (nE0, estado[0]);

    //Se determina qué se debe habilitar según el estado actual:
    //estado = 00 -> se habilita la modificación de la operación
    //estado = 01 -> se habilita la modificación del operando A
    //estado = 10 -> se habilita la modificación del operando B
    and (habilitar_op, nE1, nE0);
    and (habilitar_a,  nE1, estado[0]);
    and (habilitar_b,  estado[1], nE0);

endmodule
