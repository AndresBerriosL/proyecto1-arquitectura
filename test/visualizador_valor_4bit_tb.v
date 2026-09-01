`timescale 1ns/1ps

module visualizador_valor_4bit_tb;

    reg [3:0] valor;

    wire [6:0] display_signo;
    wire [6:0] display_hex;

    visualizador_valor_4bit VIS (
        .valor(valor),
        .display_signo(display_signo),
        .display_hex(display_hex)
    );

    initial begin

        $dumpfile("visualizador_valor_4bit.vcd");
        $dumpvars(0, visualizador_valor_4bit_tb);

        valor = 4'b0011; // 3
        #10;

        valor = 4'b0111; // 7
        #10;

        valor = 4'b1110; // -2
        #10;

        valor = 4'b1011; // -5
        #10;

        valor = 4'b1000; // -8
        #10;

        $finish;

    end

endmodule