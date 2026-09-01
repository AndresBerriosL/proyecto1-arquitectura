module magnitud_4bit (
    input [3:0] valor,
    output signo,
    output [3:0] magnitud
);

    wire [3:0] negativo;
    wire cout;

    wire nSigno;

    wire pos0, neg0;
    wire pos1, neg1;
    wire pos2, neg2;
    wire pos3, neg3;

    buf (signo, valor[3]);
    not (nSigno, valor[3]);

    restador_4bit NEG (
        .A(4'b0000),
        .B(valor),
        .R(negativo),
        .Cout(cout)
    );

    and (pos0, nSigno, valor[0]);
    and (neg0, signo, negativo[0]);
    or  (magnitud[0], pos0, neg0);

    and (pos1, nSigno, valor[1]);
    and (neg1, signo, negativo[1]);
    or  (magnitud[1], pos1, neg1);

    and (pos2, nSigno, valor[2]);
    and (neg2, signo, negativo[2]);
    or  (magnitud[2], pos2, neg2);

    and (pos3, nSigno, valor[3]);
    and (neg3, signo, negativo[3]);
    or  (magnitud[3], pos3, neg3);

endmodule