`timescale 1ns/1ps

module selector_op2_4bit_tb;

    reg [3:0] OP2;
    reg [3:0] ANTERIOR;
    reg usar_anterior;

    wire [3:0] R;

    selector_op2_4bit SELECTOR (
        .OP2(OP2),
        .ANTERIOR(ANTERIOR),
        .usar_anterior(usar_anterior),
        .R(R)
    );

    initial begin

        $dumpfile("selector_op2_4bit.vcd");
        $dumpvars(0, selector_op2_4bit_tb);

        OP2 = 4'b0011;
        ANTERIOR = 4'b1010;

        usar_anterior = 0;
        #10;

        usar_anterior = 1;
        #10;

        $finish;

    end

endmodule