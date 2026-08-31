`timescale 1ns/1ps

module shift_left_4bit_tb;

    reg [3:0] A;
    reg [1:0] B;

    wire [3:0] R;

    shift_left_4bit SHIFT_LEFT (
        .A(A),
        .B(B),
        .R(R)
    );

    initial begin

        $dumpfile("shift_left_4bit.vcd");
        $dumpvars(0, shift_left_4bit_tb);

        A = 4'b1011;

        // Shift 0
        B = 2'b00;
        #10;

        // Shift 1
        B = 2'b01;
        #10;

        // Shift 2
        B = 2'b10;
        #10;

        // Shift 3
        B = 2'b11;
        #10;

        $finish;

    end

endmodule