`timescale 1ns/1ps

module restador_4bit_tb;

    reg [3:0] A;
    reg [3:0] B;

    wire [3:0] R;
    wire Cout;

    restador_4bit RESTA (
        .A(A),
        .B(B),
        .R(R),
        .Cout(Cout)
    );

    initial begin

        $dumpfile("restador_4bit.vcd");
        $dumpvars(0, restador_4bit_tb);

        // Prueba 1: 5 - 3 = 2
        A = 4'b0101;
        B = 4'b0011;
        #10;

        // Prueba 2: 3 - 5 = -2
        A = 4'b0011;
        B = 4'b0101;
        #10;

        $finish;

    end

endmodule