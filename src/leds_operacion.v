module leds_operacion (
    input [2:0] operacion, //Operacion seleccionada (3 bits)
    output [2:0] leds      //Representación con los leds pequeños
);
    //Asigna el valor de la operacion a los leds,
    //este módulo es incluso más simple que el 
    //módulo de sumador_1bit
    buf (leds[0], operacion[0]);
    buf (leds[1], operacion[1]);
    buf (leds[2], operacion[2]);

endmodule
