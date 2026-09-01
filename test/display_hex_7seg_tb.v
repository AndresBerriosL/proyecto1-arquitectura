`timescale 1ns/1ps

module display_hex_7seg_tb;

    reg [3:0] valor;

    wire a, b, c, d, e, f, g;

    display_hex_7seg DISPLAY (
        .valor(valor),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g)
    );

    initial begin

        $dumpfile("display_hex_7seg.vcd");
        $dumpvars(0, display_hex_7seg_tb);

        valor = 4'h0; #10;
        valor = 4'h1; #10;
        valor = 4'h2; #10;
        valor = 4'h3; #10;
        valor = 4'h4; #10;
        valor = 4'h5; #10;
        valor = 4'h6; #10;
        valor = 4'h7; #10;
        valor = 4'h8; #10;
        valor = 4'h9; #10;
        valor = 4'hA; #10;
        valor = 4'hB; #10;
        valor = 4'hC; #10;
        valor = 4'hD; #10;
        valor = 4'hE; #10;
        valor = 4'hF; #10;

        $finish;

    end

endmodule