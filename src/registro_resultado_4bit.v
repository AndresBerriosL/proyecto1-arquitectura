module registro_resultado_4bit (
    input clk,
    input reset,
    input guardar,
    input [3:0] D,
    output reg [3:0] Q
);

    wire nGuardar;
    wire nReset;

    wire d0, q0, m0;
    wire d1, q1, m1;
    wire d2, q2, m2;
    wire d3, q3, m3;

    wire [3:0] siguiente;

    not (nGuardar, guardar);
    not (nReset, reset);

    and (d0, guardar, D[0]);
    and (q0, nGuardar, Q[0]);
    or (m0, d0, q0);
    and (siguiente[0], nReset, m0);

    and (d1, guardar, D[1]);
    and (q1, nGuardar, Q[1]);
    or (m1, d1, q1);
    and (siguiente[1], nReset, m1);

    and (d2, guardar, D[2]);
    and (q2, nGuardar, Q[2]);
    or (m2, d2, q2);
    and (siguiente[2], nReset, m2);

    and (d3, guardar, D[3]);
    and (q3, nGuardar, Q[3]);
    or (m3, d3, q3);
    and (siguiente[3], nReset, m3);

    always @(posedge clk) begin
        Q <= siguiente;
    end

endmodule