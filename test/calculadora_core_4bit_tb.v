`timescale 1ns/1ps

module calculadora_core_4bit_tb;

    reg clk;
    reg reset;
    reg guardar;
    reg usar_anterior;

    reg [2:0] operacion;
    reg [3:0] A;
    reg [3:0] OP2;

    wire [3:0] resultado;

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

    always #5 clk = ~clk;

    initial begin

        $dumpfile("calculadora_core_4bit.vcd");
        $dumpvars(0, calculadora_core_4bit_tb);

        clk = 0;
        reset = 1;
        guardar = 0;
        usar_anterior = 0;

        operacion = 3'b000;
        A = 4'b0000;
        OP2 = 4'b0000;

        #10;

        reset = 0;

        // 3 + 2 = 5
        operacion = 3'b001;
        A = 4'b0011;
        OP2 = 4'b0010;
        guardar = 1;

        #10;

        // 7 - resultado anterior (5) = 2
        operacion = 3'b010;
        A = 4'b0111;
        usar_anterior = 1;

        #10;

        // 3 << resultado anterior[1:0] (2) = 12
        operacion = 3'b100;
        A = 4'b0011;

        #10;

        // operación 000 deja resultado en 0
        operacion = 3'b000;
        usar_anterior = 0;

        #10;

        guardar = 0;

        $finish;

    end

endmodule