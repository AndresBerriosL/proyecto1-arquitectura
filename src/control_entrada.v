module control_entrada (
    input clk,
    input reset,
    input confirmar,
    input incrementar,
    input disminuir,

    output [1:0] estado,
    output [2:0] operacion,
    output [3:0] A,
    output [3:0] B
);

    wire habilitar_op;
    wire habilitar_a;
    wire habilitar_b;

    control_estados ESTADOS (
        .clk(clk),
        .reset(reset),
        .confirmar(confirmar),
        .estado(estado)
    );

    control_valores VALORES (
        .estado(estado),
        .habilitar_op(habilitar_op),
        .habilitar_a(habilitar_a),
        .habilitar_b(habilitar_b)
    );

    registro_operacion_3bit REG_OP (
        .clk(clk),
        .reset(reset),
        .habilitar(habilitar_op),
        .incrementar(incrementar),
        .disminuir(disminuir),
        .Q(operacion)
    );

    registro_ajustable_4bit REG_A (
        .clk(clk),
        .reset(reset),
        .habilitar(habilitar_a),
        .incrementar(incrementar),
        .disminuir(disminuir),
        .Q(A)
    );

    registro_ajustable_4bit REG_B (
        .clk(clk),
        .reset(reset),
        .habilitar(habilitar_b),
        .incrementar(incrementar),
        .disminuir(disminuir),
        .Q(B)
    );

endmodule