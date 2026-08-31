`timescale 1ns/1ps

module sumador_4bit_tb;

    reg [3:0] A;
    reg [3:0] B;

    wire [3:0] S;
    wire Cout;

    sumador_4bit SUM4 (
        .A(A),
        .B(B),
        .S(S),
        .Cout(Cout)
    );

    initial begin

        $dumpfile("sumador_4bit.vcd");
        $dumpvars(0, sumador_4bit_tb);

        // Prueba 1: 9 + 3 = 12
        A = 4'b1001;
        B = 4'b0011;
        #10;

        // Prueba 2: 15 + 1
        A = 4'b1111;
        B = 4'b0001;
        #10;

        $finish;

    end

endmodule