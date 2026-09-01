module top (
    input clk,
    input reset,
    input guardar,
    input usar_anterior,
    input [2:0] operacion,
    input [3:0] A,
    input [3:0] OP2,
    output [3:0] resultado
);

    calculadora_core_4bit CALC (
        .clk(clk),
        .reset(reset),
        .guardar(guardar),
        .usar_anterior(usar_anterior),
        .operacion(operacion),
        .A(A),
        .OP2(OP2),
        .resultado(resultado)
    );

endmodule