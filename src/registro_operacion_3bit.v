module registro_operacion_3bit (
    input clk,
    input reset,
    input habilitar,
    input incrementar,
    input disminuir,
    output reg [2:0] Q
);

    wire nQ2, nQ1, nQ0;
    wire nInc, nDec, nReset;

    wire e0, e1, e2, e3, e4, e5;

    wire inc0, inc1, inc2;
    wire dec0, dec1, dec2;

    wire sel_inc;
    wire sel_dec;
    wire sel_hold;

    wire si0, sd0, sh0, m0;
    wire si1, sd1, sh1, m1;
    wire si2, sd2, sh2, m2;

    wire [2:0] siguiente;

    not (nQ2, Q[2]);
    not (nQ1, Q[1]);
    not (nQ0, Q[0]);

    not (nInc, incrementar);
    not (nDec, disminuir);
    not (nReset, reset);

    and (e0, nQ2, nQ1, nQ0);
    and (e1, nQ2, nQ1, Q[0]);
    and (e2, nQ2, Q[1], nQ0);
    and (e3, nQ2, Q[1], Q[0]);
    and (e4, Q[2], nQ1, nQ0);
    and (e5, Q[2], nQ1, Q[0]);

    // incremento: 0 -> 1 -> 2 -> 3 -> 4 -> 5 -> 0
    or (inc0, e0, e2, e4);
    or (inc1, e1, e2);
    or (inc2, e3, e4);

    // decremento: 0 -> 5 -> 4 -> 3 -> 2 -> 1 -> 0
    or (dec0, e0, e2, e4);
    or (dec1, e3, e4);
    or (dec2, e0, e5);

    and (sel_inc, habilitar, incrementar, nDec);
    and (sel_dec, habilitar, disminuir, nInc);
    nor (sel_hold, sel_inc, sel_dec);

    and (si0, sel_inc, inc0);
    and (sd0, sel_dec, dec0);
    and (sh0, sel_hold, Q[0]);
    or  (m0, si0, sd0, sh0);
    and (siguiente[0], nReset, m0);

    and (si1, sel_inc, inc1);
    and (sd1, sel_dec, dec1);
    and (sh1, sel_hold, Q[1]);
    or  (m1, si1, sd1, sh1);
    and (siguiente[1], nReset, m1);

    and (si2, sel_inc, inc2);
    and (sd2, sel_dec, dec2);
    and (sh2, sel_hold, Q[2]);
    or  (m2, si2, sd2, sh2);
    and (siguiente[2], nReset, m2);

    always @(posedge clk) begin
        Q <= siguiente;
    end

endmodule