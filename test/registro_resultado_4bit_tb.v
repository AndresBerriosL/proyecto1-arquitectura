`timescale 1ns/1ps

module registro_resultado_4bit_tb;

    reg clk;
    reg reset;
    reg guardar;
    reg [3:0] D;

    wire [3:0] Q;

    registro_resultado_4bit REGISTRO (
        .clk(clk),
        .reset(reset),
        .guardar(guardar),
        .D(D),
        .Q(Q)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("registro_resultado_4bit.vcd");
        $dumpvars(0, registro_resultado_4bit_tb);

        clk = 0;
        reset = 1;
        guardar = 0;
        D = 4'b0000;

        #10;

        reset = 0;
        guardar = 1;
        D = 4'b0101;

        #10;

        guardar = 0;
        D = 4'b1010;

        #10;

        guardar = 1;

        #10;

        guardar = 0;
        D = 4'b0011;

        #10;

        $finish;

    end

endmodule