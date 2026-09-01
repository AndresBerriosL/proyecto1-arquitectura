`timescale 1ns/1ps

module registro_operacion_3bit_tb;

    reg clk;
    reg reset;
    reg habilitar;
    reg incrementar;
    reg disminuir;

    wire [2:0] Q;

    registro_operacion_3bit REG_OP (
        .clk(clk),
        .reset(reset),
        .habilitar(habilitar),
        .incrementar(incrementar),
        .disminuir(disminuir),
        .Q(Q)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("registro_operacion_3bit.vcd");
        $dumpvars(0, registro_operacion_3bit_tb);

        clk = 0;
        reset = 1;
        habilitar = 0;
        incrementar = 0;
        disminuir = 0;

        #10;

        reset = 0;
        habilitar = 1;
        incrementar = 1;

        #60;

        incrementar = 0;
        disminuir = 1;

        #20;

        disminuir = 0;
        habilitar = 0;
        incrementar = 1;

        #10;

        incrementar = 0;

        $finish;

    end

endmodule