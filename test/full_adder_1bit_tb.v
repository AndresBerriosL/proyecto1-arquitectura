`timescale 1ns/1ps

module full_adder_1bit_tb;

    reg A;
    reg B;
    reg Cin;

    wire S;
    wire Cout;

    full_adder_1bit FA (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );

    initial begin

        $dumpfile("full_adder_1bit.vcd");
        $dumpvars(0, full_adder_1bit_tb);

        A = 0; B = 0; Cin = 0;
        #10;

        A = 0; B = 0; Cin = 1;
        #10;

        A = 0; B = 1; Cin = 0;
        #10;

        A = 0; B = 1; Cin = 1;
        #10;

        A = 1; B = 0; Cin = 0;
        #10;

        A = 1; B = 0; Cin = 1;
        #10;

        A = 1; B = 1; Cin = 0;
        #10;

        A = 1; B = 1; Cin = 1;
        #10;

        $finish;

    end

endmodule