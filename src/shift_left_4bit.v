module shift_left_4bit (
    input [3:0] A, //Número de 4 bits que se va a desplazar
    input [1:0] B, //Selector de cuantas posiciones se va a desplazar
    output [3:0] R //Resultado del desplazamiento
);
    //Señales negadas de B, se usan para detectar cuando B vale 0 en cada bit
    //Esto es porque es el selector de la operación
    wire nB1;
    wire nB0;

    not (nB1, B[1]);
    not (nB0, B[0]);

    //R[0] es el bit más bajo del resultado y solo puede tener el valor de A[0]
    //cuando B = 00 (osea que no hay desplazamiento)
    //En cualquier otro caso, se rellena con 0 (por eso solo hay un término "and",
    //sin necesitar de un "or", es un caso particular para este bit)
    and (R[0], nB1, nB0, A[0]);

    // R[1]
    wire r1_0;
    wire r1_1;

    and (r1_0, nB1, nB0, A[1]);
    and (r1_1, nB1, B[0], A[0]);
    or  (R[1], r1_0, r1_1);

    // R[2]
    wire r2_0;
    wire r2_1;
    wire r2_2;

    and (r2_0, nB1, nB0, A[2]);
    and (r2_1, nB1, B[0], A[1]);
    and (r2_2, B[1], nB0, A[0]);
    or  (R[2], r2_0, r2_1, r2_2);

    // R[3]
    wire r3_0;
    wire r3_1;
    wire r3_2;
    wire r3_3;

    and (r3_0, nB1, nB0, A[3]);
    and (r3_1, nB1, B[0], A[2]);
    and (r3_2, B[1], nB0, A[1]);
    and (r3_3, B[1], B[0], A[0]);
    or  (R[3], r3_0, r3_1, r3_2, r3_3);
    //Se puede resumir el módulo de shift_left_4bit como la contra parte del
    //módulo shift_right_4bit, ya que realizan la misma función pero en
    //sentido opuesto.
endmodule
