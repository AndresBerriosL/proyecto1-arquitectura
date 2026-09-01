`timescale 1ns/1ps

module control_estados_tb;

    reg clk;
    reg reset;
    reg confirmar;

    wire [1:0] estado;

    control_estados CONTROL (
        .clk(clk),
        .reset(reset),
        .confirmar(confirmar),
        .estado(estado)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("control_estados.vcd");
        $dumpvars(0, control_estados_tb);

        clk = 0;
        reset = 1;
        confirmar = 0;

        #10;

        reset = 0;

        confirmar = 1;
        #10;

        confirmar = 0;
        #10;

        confirmar = 1;
        #10;

        confirmar = 0;
        #10;

        confirmar = 1;
        #10;

        confirmar = 0;
        #10;

        confirmar = 1;
        #10;

        confirmar = 0;
        #10;

        $finish;

    end

endmodule