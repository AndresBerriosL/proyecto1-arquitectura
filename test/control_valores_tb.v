`timescale 1ns/1ps

module control_valores_tb;

    reg [1:0] estado;

    wire habilitar_op;
    wire habilitar_a;
    wire habilitar_b;

    control_valores CONTROL (
        .estado(estado),
        .habilitar_op(habilitar_op),
        .habilitar_a(habilitar_a),
        .habilitar_b(habilitar_b)
    );

    initial begin

        $dumpfile("control_valores.vcd");
        $dumpvars(0, control_valores_tb);

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