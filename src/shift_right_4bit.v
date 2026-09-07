module shift_right_4bit (
    input [3:0] A, //Número de 4 bits que va a ser desplazado
    input [1:0] B, //Cantidad de posiciones a desplazar (de 0 a 3)
    output [3:0] R //Valor que queda del desplazamiento hacia la derecha
);


    //Señales negadas de B, se usan para detectar cuando B vale 0 en cada bit
    //Esto es porque es el selector de la operación
    wire nB1;
    wire nB0;

    not (nB1, B[1]);
    not (nB0, B[0]);


    //R[3] es el bit más alto del resultado y solo puede tener el valor de A[3]
    //cuando B = 00 (osea que no hay desplazamiento)
    //En cualquier otro caso, se rellena con 0 (por eso solo hay un término "and",
    //sin necesitar de un "or", es un caso particular para este bit)
    and (R[3], nB1, nB0, A[3]);


    //R[2] depende de A[3]
    // -Si B = 00, R[2] = A[2] (no hay desplazamiento)
    // -Si B = 01, R[2] = A[3] (se desplazó 1 posición)
    wire r2_0;
    wire r2_1;

    and (r2_0, nB1, nB0, A[2]);
    and (r2_1, nB1, B[0], A[3]);
    or (R[2], r2_0, r2_1);


    //R[1] depende de A[3] y A[2]
    // -Si B = 00, R[1] = A[1]
    // -Si B = 01, R[1] = A[2]
    // -Si B = 10, R[1] = A[3]
    wire r1_0;
    wire r1_1;
    wire r1_2;

    and (r1_0, nB1, nB0, A[1]);
    and (r1_1, nB1, B[0], A[2]);
    and (r1_2, B[1], nB0, A[3]);
    or (R[1], r1_0, r1_1, r1_2);


    // R[0] depende de A[3], A[2] y de A[1]
    // -Si B = 00, R[0] = A[0]
    // -Si B = 01, R[0] = A[1]
    // -Si B = 10, R[0] = A[2]
    // -Si B = 11, R[0] = A[3]
    wire r0_0;
    wire r0_1;
    wire r0_2;
    wire r0_3;

    and (r0_0, nB1, nB0, A[0]);
    and (r0_1, nB1, B[0], A[1]);
    and (r0_2, B[1], nB0, A[2]);
    and (r0_3, B[1], B[0], A[3]);
    or (R[0], r0_0, r0_1, r0_2, r0_3);

endmodule
