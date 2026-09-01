`timescale 1ns/1ps

module visualizacion_estado_tb;

    reg [1:0] estado;
    reg [3:0] A;
    reg [3:0] B;
    reg [3:0] resultado;

    wire [6:0] display_signo;
    wire [6:0] display_hex;

    visualizacion_estado VIS (
        .estado(estado),
        .A(A),
        .B(B),
        .resultado(resultado),
        .display_signo(display_signo),
        .display_hex(display_hex)
    );

    initial begin

        $dumpfile("visualizacion_estado.vcd");
        $dumpvars(0, visualizacion_estado_tb);

        A = 4'b0011;          // 3
        B = 4'b1110;          // -2
        resultado = 4'b1011;  // -5

        estado = 2'b00;
        #10;

        estado = 2'b01;
        #10;

        estado = 2'b10;
        #10;

        estado = 2'b11;
        #10;

        $finish;

    end

endmodule