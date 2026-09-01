`timescale 1ns/1ps

module leds_operacion_tb;

    reg [2:0] operacion;
    wire [2:0] leds;

    leds_operacion LEDS (
        .operacion(operacion),
        .leds(leds)
    );

    initial begin

        $dumpfile("leds_operacion.vcd");
        $dumpvars(0, leds_operacion_tb);

        operacion = 3'b000;
        #10;

        operacion = 3'b001;
        #10;

        operacion = 3'b010;
        #10;

        operacion = 3'b011;
        #10;

        operacion = 3'b100;
        #10;

        operacion = 3'b101;
        #10;

        $finish;

    end

endmodule