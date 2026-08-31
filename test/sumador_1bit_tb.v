`timescale 1ns/1ps

module sumador_1bit_tb;

    reg A;
    reg B;

    wire S;
    wire C;

    sumador_1bit sumador (
        .A(A),
        .B(B),
        .S(S),
        .C(C)
    );

    initial begin

        $dumpfile("sumador_1bit.vcd");
        $dumpvars(0, sumador_1bit_tb);

        A = 0;
        B = 0;
        #10;

        A = 0;
        B = 1;
        #10;

        A = 1;
        B = 0;
        #10;

        A = 1;
        B = 1;
        #10;

        $finish;

    end

endmodule