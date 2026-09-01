module registro_ajustable_4bit (
    input clk,
    input reset,
    input habilitar,
    input incrementar,
    input disminuir,
    output reg [3:0] Q
);

    wire [3:0] suma;
    wire [3:0] resta;

    wire sel_inc;
    wire sel_dec;
    wire sel_hold;

    wire nInc;
    wire nDec;
    wire nReset;

    wire [3:0] siguiente;

    wire si0, sd0, sh0, m0;
    wire si1, sd1, sh1, m1;
    wire si2, sd2, sh2, m2;
    wire si3, sd3, sh3, m3;

    wire cout_suma;
    wire cout_resta;

    sumador_4bit INC (
        .A(Q),
        .B(4'b0001),
        .S(suma),
        .Cout(cout_suma)
    );

    restador_4bit DEC (
        .A(Q),
        .B(4'b0001),
        .R(resta),
        .Cout(cout_resta)
    );

    not (nInc, incrementar);
    not (nDec, disminuir);
    not (nReset, reset);

    and (sel_inc, habilitar, incrementar, nDec);
    and (sel_dec, habilitar, disminuir, nInc);

    nor (sel_hold, sel_inc, sel_dec);

    and (si0, sel_inc, suma[0]);
    and (sd0, sel_dec, resta[0]);
    and (sh0, sel_hold, Q[0]);
    or  (m0, si0, sd0, sh0);
    and (siguiente[0], nReset, m0);

    and (si1, sel_inc, suma[1]);
    and (sd1, sel_dec, resta[1]);
    and (sh1, sel_hold, Q[1]);
    or  (m1, si1, sd1, sh1);
    and (siguiente[1], nReset, m1);

    and (si2, sel_inc, suma[2]);
    and (sd2, sel_dec, resta[2]);
    and (sh2, sel_hold, Q[2]);
    or  (m2, si2, sd2, sh2);
    and (siguiente[2], nReset, m2);

    and (si3, sel_inc, suma[3]);
    and (sd3, sel_dec, resta[3]);
    and (sh3, sel_hold, Q[3]);
    or  (m3, si3, sd3, sh3);
    and (siguiente[3], nReset, m3);

    always @(posedge clk) begin
        Q <= siguiente;
    end

endmodule