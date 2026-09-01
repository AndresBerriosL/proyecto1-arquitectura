module leds_operacion (
    input [2:0] operacion,
    output [2:0] leds
);

    buf (leds[0], operacion[0]);
    buf (leds[1], operacion[1]);
    buf (leds[2], operacion[2]);

endmodule