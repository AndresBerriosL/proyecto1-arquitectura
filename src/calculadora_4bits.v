module calculadora_4bits (
    input  wire       clk,
    input  wire       ejecutar,
    input  wire [2:0] codigo,
    input  wire       sel_op2,
    input  wire [3:0] op1,
    input  wire [3:0] op2_ext,
    output wire [3:0] resultado
);

    wire reset;
    reg iniciado = 1'b0;

    always @(posedge clk) begin
        iniciado <= 1'b1;
    end

    not (reset, iniciado);

    calculadora_core_4bit CORE (
        .clk(clk),
        .reset(reset),
        .guardar(ejecutar),
        .usar_anterior(sel_op2),
        .operacion(codigo),
        .A(op1),
        .OP2(op2_ext),
        .resultado(resultado)
    );

endmodule