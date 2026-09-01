module top (
    input i_Clk,
    input [3:0] i_Switch,

    output [3:0] o_LED,

    output o_Segment1_A,
    output o_Segment1_B,
    output o_Segment1_C,
    output o_Segment1_D,
    output o_Segment1_E,
    output o_Segment1_F,
    output o_Segment1_G,

    output o_Segment2_A,
    output o_Segment2_B,
    output o_Segment2_C,
    output o_Segment2_D,
    output o_Segment2_E,
    output o_Segment2_F,
    output o_Segment2_G
);

    wire reset;

    reg iniciado = 1'b0;

    always @(posedge i_Clk) begin
        iniciado <= 1'b1;
    end

    not (reset, iniciado);


    wire incrementar;
    wire disminuir;
    wire confirmar;
    wire usar_anterior;

    wire [1:0] estado;
    wire [2:0] operacion;

    wire [3:0] A;
    wire [3:0] B;
    wire [3:0] resultado;

    wire [2:0] leds;

    wire [6:0] display_signo;
    wire [6:0] display_hex;


    botones_goboard BOTONES (
        .clk(i_Clk),
        .reset(reset),

        .sw_incrementar(i_Switch[0]),
        .sw_disminuir(i_Switch[1]),
        .sw_confirmar(i_Switch[2]),
        .sw_anterior(i_Switch[3]),

        .incrementar(incrementar),
        .disminuir(disminuir),
        .confirmar(confirmar),
        .usar_anterior(usar_anterior)
    );


    calculadora_sistema SISTEMA (
        .clk(i_Clk),
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


    leds_operacion LEDS (
        .operacion(operacion),
        .leds(leds)
    );

    buf (o_LED[0], leds[0]);
    buf (o_LED[1], leds[1]);
    buf (o_LED[2], leds[2]);
    buf (o_LED[3], 1'b0);


    visualizacion_estado VIS (
        .estado(estado),
        .A(A),
        .B(B),
        .resultado(resultado),

        .display_signo(display_signo),
        .display_hex(display_hex)
    );


    // Los displays de la Go Board son active-low
    not (o_Segment1_A, display_signo[6]);
    not (o_Segment1_B, display_signo[5]);
    not (o_Segment1_C, display_signo[4]);
    not (o_Segment1_D, display_signo[3]);
    not (o_Segment1_E, display_signo[2]);
    not (o_Segment1_F, display_signo[1]);
    not (o_Segment1_G, display_signo[0]);

    not (o_Segment2_A, display_hex[6]);
    not (o_Segment2_B, display_hex[5]);
    not (o_Segment2_C, display_hex[4]);
    not (o_Segment2_D, display_hex[3]);
    not (o_Segment2_E, display_hex[2]);
    not (o_Segment2_F, display_hex[1]);
    not (o_Segment2_G, display_hex[0]);

endmodule