`timescale 1ns/1ps

module magnitud_4bit_tb;

    reg [3:0] valor;

    wire signo;
    wire [3:0] magnitud;

    magnitud_4bit MAG (
        .valor(valor),
        .signo(signo),
        .magnitud(magnitud)
    );

    initial begin

        $dumpfile("magnitud_4bit.vcd");
        $dumpvars(0, magnitud_4bit_tb);

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