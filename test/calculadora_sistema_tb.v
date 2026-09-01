`timescale 1ns/1ps

module calculadora_sistema_tb;

    reg clk;
    reg reset;
    reg confirmar;
    reg incrementar;
    reg disminuir;
    reg usar_anterior;

    wire [1:0] estado;
    wire [2:0] operacion;
    wire [3:0] A;
    wire [3:0] B;
    wire [3:0] resultado;

    calculadora_sistema SISTEMA (
        .clk(clk),
        .reset(reset),
        .confirmar(confirmar),
        .incrementar(incrementar),
        .disminuir(disminuir),
        .usar_anterior(usar_anterior),
        .estado(estado),
        .operacion(operacion),
        .A(A),
        .B(B),
        .resultado(resultado)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("calculadora_sistema.vcd");
        $dumpvars(0, calculadora_sistema_tb);

        clk = 0;
        reset = 1;
        confirmar = 0;
        incrementar = 0;
        disminuir = 0;
        usar_anterior = 0;

        #10;

        reset = 0;

        // operación 001: suma
        incrementar = 1;
        #10;
        incrementar = 0;

        confirmar = 1;
        #10;
        confirmar = 0;

        // A = 3
        incrementar = 1;
        #30;
        incrementar = 0;

        confirmar = 1;
        #10;
        confirmar = 0;

        // B = 2
        incrementar = 1;
        #20;
        incrementar = 0;

        // ejecutar 3 + 2
        confirmar = 1;
        #10;
        confirmar = 0;

        // volver a operación
        confirmar = 1;
        #10;
        confirmar = 0;

        // operación 010: resta
        incrementar = 1;
        #10;
        incrementar = 0;

        confirmar = 1;
        #10;
        confirmar = 0;

        // A pasa de 3 a 7
        incrementar = 1;
        #40;
        incrementar = 0;

        confirmar = 1;
        #10;
        confirmar = 0;

        // usar resultado anterior: 7 - 5
        usar_anterior = 1;
        confirmar = 1;
        #10;
        confirmar = 0;
        usar_anterior = 0;

        #10;

        $finish;

    end

endmodule