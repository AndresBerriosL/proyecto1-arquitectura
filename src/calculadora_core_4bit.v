module calculadora_core_4bit (
    input clk,
    input reset,
    input guardar,
    input usar_anterior,
    input [2:0] operacion,
    input [3:0] A,
    input [3:0] OP2,
    output [3:0] resultado
);

    wire [3:0] B;

    wire [3:0] suma;
    wire [3:0] resta;
    wire [3:0] resta_inv;
    wire [3:0] shift_l;
    wire [3:0] shift_r;

    wire [3:0] calculado;

    wire cout_suma;
    wire cout_resta;
    wire cout_inv;

    selector_op2_4bit SEL_B (
        .OP2(OP2),
        .ANTERIOR(resultado),
        .usar_anterior(usar_anterior),
        .R(B)
    );

    sumador_4bit SUM (
        .A(A),
        .B(B),
        .S(suma),
        .Cout(cout_suma)
    );

    restador_4bit REST (
        .A(A),
        .B(B),
        .R(resta),
        .Cout(cout_resta)
    );

    restador_inverso_4bit REST_INV (
        .A(A),
        .B(B),
        .R(resta_inv),
        .Cout(cout_inv)
    );

    shift_left_4bit SL (
        .A(A),
        .B(B[1:0]),
        .R(shift_l)
    );

    shift_right_4bit SR (
        .A(A),
        .B(B[1:0]),
        .R(shift_r)
    );

    selector_operacion_4bit SEL_OP (
        .C(operacion),
        .SUMA(suma),
        .RESTA(resta),
        .RESTA_INV(resta_inv),
        .SHIFT_L(shift_l),
        .SHIFT_R(shift_r),
        .R(calculado)
    );

    registro_resultado_4bit REG_RESULTADO (
        .clk(clk),
        .reset(reset),
        .guardar(guardar),
        .D(calculado),
        .Q(resultado)
    );

endmodule