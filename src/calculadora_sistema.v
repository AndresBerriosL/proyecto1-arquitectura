module calculadora_sistema (
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

    wire nE0;
    wire guardar;

    control_entrada ENTRADA (
        .clk(clk),
        .reset(reset),
        .confirmar(confirmar),
        .incrementar(incrementar),
        .disminuir(disminuir),
        .estado(estado),
        .operacion(operacion),
        .A(A),
        .B(B)
    );

    not (nE0, estado[0]);

    // guarda al confirmar el segundo operando
    and (guardar, confirmar, estado[1], nE0);

    calculadora_core_4bit CALC (
        .clk(clk),
        .reset(reset),
        .guardar(guardar),
        .usar_anterior(usar_anterior),
        .operacion(operacion),
        .A(A),
        .OP2(B),
        .resultado(resultado)
    );

endmodule