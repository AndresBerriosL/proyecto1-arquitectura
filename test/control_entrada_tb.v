`timescale 1ns/1ps

module control_entrada_tb;

    reg clk;
    reg reset;
    reg confirmar;
    reg incrementar;
    reg disminuir;

    wire [1:0] estado;
    wire [2:0] operacion;
    wire [3:0] A;
    wire [3:0] B;

    control_entrada CONTROL (
        .clk(clk),
        .reset(reset),
        .confirmar(confirmar),
        .incrementar(incrementar),
        .disminuir(disminuir),
        .estado(estado),
        .operacion(operacion),
        .A(A),
        .B(B)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("control_entrada.vcd");
        $dumpvars(0, control_entrada_tb);

        clk = 0;
        reset = 1;
        confirmar = 0;
        incrementar = 0;
        disminuir = 0;

        #10;

        reset = 0;

        // operación: 000 -> 001 -> 010
        incrementar = 1;
        #20;
        incrementar = 0;

        // pasar a A
        confirmar = 1;
        #10;
        confirmar = 0;

        // A: 0 -> 1 -> 2 -> 3
        incrementar = 1;
        #30;
        incrementar = 0;

        // pasar a B
        confirmar = 1;
        #10;
        confirmar = 0;

        // B: 0 -> 1 -> 2
        incrementar = 1;
        #20;
        incrementar = 0;

        // B: 2 -> 1
        disminuir = 1;
        #10;
        disminuir = 0;

        // pasar a resultado
        confirmar = 1;
        #10;
        confirmar = 0;

        // acá no debería cambiar nada
        incrementar = 1;
        #10;
        incrementar = 0;

        // volver a operación
        confirmar = 1;
        #10;
        confirmar = 0;

        $finish;

    end

endmodule