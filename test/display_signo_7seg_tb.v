`timescale 1ns/1ps

module display_signo_7seg_tb;

    reg signo;

    wire a, b, c, d, e, f, g;

    display_signo_7seg DISPLAY (
        .signo(signo),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g)
    );

    initial begin

        $dumpfile("display_signo_7seg.vcd");
        $dumpvars(0, display_signo_7seg_tb);

        signo = 0;
        #10;

        signo = 1;
        #10;

        signo = 0;
        #10;

        $finish;

    end

endmodule