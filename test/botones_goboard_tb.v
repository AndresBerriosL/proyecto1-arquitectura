`timescale 1ns/1ps

module botones_goboard_tb;

    reg clk;
    reg reset;

    reg sw_incrementar;
    reg sw_disminuir;
    reg sw_confirmar;
    reg sw_anterior;

    wire incrementar;
    wire disminuir;
    wire confirmar;
    wire usar_anterior;

    botones_goboard BOTONES (
        .clk(clk),
        .reset(reset),
        .sw_incrementar(sw_incrementar),
        .sw_disminuir(sw_disminuir),
        .sw_confirmar(sw_confirmar),
        .sw_anterior(sw_anterior),
        .incrementar(incrementar),
        .disminuir(disminuir),
        .confirmar(confirmar),
        .usar_anterior(usar_anterior)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("botones_goboard.vcd");
        $dumpvars(0, botones_goboard_tb);

        clk = 0;
        reset = 1;

        sw_incrementar = 0;
        sw_disminuir = 0;
        sw_confirmar = 0;
        sw_anterior = 0;

        #20;
        reset = 0;

        #30;

        sw_incrementar = 1;

        #30;

        DUT_CONTADOR_INC;

        #30;

        sw_incrementar = 0;

        #30;

        DUT_CONTADOR_RELEASE;

        #30;

        $finish;

    end

    task DUT_CONTADOR_INC;
        begin
            BOTONES.contador = 18'h3FFFE;
        end
    endtask

    task DUT_CONTADOR_RELEASE;
        begin
            BOTONES.contador = 18'h3FFFE;
        end
    endtask

endmodule