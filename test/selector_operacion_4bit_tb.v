`timescale 1ns/1ps

module selector_operacion_4bit_tb;

    reg [2:0] C;

    reg [3:0] SUMA;
    reg [3:0] RESTA;
    reg [3:0] RESTA_INV;
    reg [3:0] SHIFT_L;
    reg [3:0] SHIFT_R;

    wire [3:0] R;

    selector_operacion_4bit SELECTOR (
        .C(C),
        .SUMA(SUMA),
        .RESTA(RESTA),
        .RESTA_INV(RESTA_INV),
        .SHIFT_L(SHIFT_L),
        .SHIFT_R(SHIFT_R),
        .R(R)
    );

    initial begin

        $dumpfile("selector_operacion_4bit.vcd");
        $dumpvars(0, selector_operacion_4bit_tb);

        SUMA      = 4'b0001;
        RESTA     = 4'b0010;
        RESTA_INV = 4'b0011;
        SHIFT_L   = 4'b0100;
        SHIFT_R   = 4'b0101;

        C = 3'b000;
        #10;

        C = 3'b001;
        #10;

        C = 3'b010;
        #10;

        C = 3'b011;
        #10;

        C = 3'b100;
        #10;

        C = 3'b101;
        #10;

        C = 3'b110;
        #10;

        C = 3'b111;
        #10;

        $finish;

    end

endmodule