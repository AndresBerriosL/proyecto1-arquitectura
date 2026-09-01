module control_estados (
    input clk,
    input reset,
    input confirmar,
    output reg [1:0] estado
);

    wire nConfirmar;
    wire nReset;

    wire inc0;
    wire inc1;

    wire mantener0;
    wire avanzar0;
    wire mantener1;
    wire avanzar1;

    wire m0;
    wire m1;

    wire [1:0] siguiente;

    // 00 operacion, 01 A, 10 B, 11 resultado
    not (nConfirmar, confirmar);
    not (nReset, reset);

    not (inc0, estado[0]);
    xor (inc1, estado[1], estado[0]);

    and (mantener0, nConfirmar, estado[0]);
    and (avanzar0, confirmar, inc0);
    or  (m0, mantener0, avanzar0);
    and (siguiente[0], nReset, m0);

    and (mantener1, nConfirmar, estado[1]);
    and (avanzar1, confirmar, inc1);
    or  (m1, mantener1, avanzar1);
    and (siguiente[1], nReset, m1);

    always @(posedge clk) begin
        estado <= siguiente;
    end

endmodule