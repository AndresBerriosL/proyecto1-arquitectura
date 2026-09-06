module magnitud_4bit (
    input [3:0] valor,        //El módulo recive un número de 4 bits
    output signo,             //Tiene dos outputs uno es el signo (1 = negativo o 0 = positivo)
    output [3:0] magnitud     //y el otro output es la magnitud del número recibido, sin el signo
);
    //Todas las señales internas (cables) que se usan para calcular la magnitud
    wire [3:0] negativo;
    wire cout;

    wire nSigno;

    wire pos0, neg0;
    wire pos1, neg1;
    wire pos2, neg2;
    wire pos3, neg3;


    //El signo del número es directamente el bit más significativo (valor[3])
    buf (signo, valor[3]);
    //nSigno es lo contrario del signo (si signo=0, nSigno=1, y viceversa)
    not (nSigno, valor[3]);

    //Se utiliza el módulo restador_4bit para obtener cambio de signo
    //Al realizar la operación 0 + "valor"  ---> 0 - "valor"
    restador_4bit NEG (
        .A(4'b0000),
        .B(valor),
        .R(negativo),
        .Cout(cout)
    );

    // Bit 0 de la magnitud
    and (pos0, nSigno, valor[0]);
    and (neg0, signo, negativo[0]);
    or  (magnitud[0], pos0, neg0);

    //Acá es importante recalcar que las compuertas lógicas en
    //Verilog funcionan como "pos0 = nSigno Y valor[0]",
    //Lo mismo aplica para las otras compuertas lógicas

    // Bit 1 de la magnitud
    and (pos1, nSigno, valor[1]);
    and (neg1, signo, negativo[1]);
    or  (magnitud[1], pos1, neg1);

    // Bit 2 de la magnitud
    and (pos2, nSigno, valor[2]);
    and (neg2, signo, negativo[2]);
    or  (magnitud[2], pos2, neg2);

    // Bit 3 de la magnitud
    and (pos3, nSigno, valor[3]);
    and (neg3, signo, negativo[3]);
    or  (magnitud[3], pos3, neg3);

endmodule
