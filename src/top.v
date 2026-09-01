module top (
    input clk,
    input reset,
    input confirmar,
    input incrementar,
    input disminuir,
    input usar_anterior,

    output [1:0] estado,
    output [2:0] operacion,
    output [3:0] A,
    output [3:0] B,
    output [3:0] resultado
);

    calculadora_sistema SISTEMA (
        .clk(clk),
        .reset(reset),
        .confirmar(confirmar),
        .incrementar(incrementar),
        .disminuir(disminuir),
        .usar_anterior(usar_anterior),
        .estado(estado),
        .operacion(operacion),
        .A(A),
        .B(B),
        .resultado(resultado)
    );

endmodule