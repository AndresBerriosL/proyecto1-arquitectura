module top (
    input i_Clk,            //Señal de reloj proveniente de la Go Board
    input [3:0] i_Switch,   //Señales de los 4 botones físicos de la placa

    output [3:0] o_LED,     //4 leds físicos de la placa

    //Segmentos del primer display (signo)
    output o_Segment1_A,
    output o_Segment1_B,
    output o_Segment1_C,
    output o_Segment1_D,
    output o_Segment1_E,
    output o_Segment1_F,
    output o_Segment1_G,

    //Segmentos del segundo display (valor hexadecimal)
    output o_Segment2_A,
    output o_Segment2_B,
    output o_Segment2_C,
    output o_Segment2_D,
    output o_Segment2_E,
    output o_Segment2_F,
    output o_Segment2_G
);
    
    //Señal de reset generada internamente
    wire reset;

    //Registro que indica si el sistema ya arrancó (empieza en 0)
    reg iniciado = 1'b0;

    //En el primer flanco de reloj, "iniciado" pasa a 1 y se queda así para siempre
    //Esto se usa para generar un pulso de reset automático justo al encender la FPGA
    always @(posedge i_Clk) begin
        iniciado <= 1'b1;
    end

    //Mientras "iniciado" sea 0 (es decir, antes del primer flanco de reloj), reset vale 1
    //Esto asegura que todo el sistema arranque correctamente resetado
    not (reset, iniciado);

    //Señales que representan las acciones del usuario, ya traducidas desde los botones físicos
    wire incrementar;
    wire disminuir;
    wire confirmar;
    wire usar_anterior;

    //Señales principales del estado interno de la calculadora
    wire [1:0] estado;
    wire [2:0] operacion;

    wire [3:0] A;
    wire [3:0] B;
    wire [3:0] resultado;

    //Señales para los leds y los displays
    wire [2:0] leds;
    wire [6:0] display_signo;
    wire [6:0] display_hex;


    //Módulo que traduce las señales físicas de los botones en señales de control
    //(por ejemplo, aplicando detección de flancos o antirrebote)
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

    //Módulo principal que contiene toda la lógica de la calculadora
    //(control de estados, registros de operación y operandos, cálculo del resultado, etc.)
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


    //Se calculan las señales para mostrar la operación seleccionada en los leds
    leds_operacion LEDS (
        .operacion(operacion),
        .leds(leds)
    );

    //Se conectan los 3 bits de "leds" a los 3 primeros leds físicos de la placa
    //El cuarto led se deja apagado (fijo en 0), ya que no se utiliza
    buf (o_LED[0], leds[0]);
    buf (o_LED[1], leds[1]);
    buf (o_LED[2], leds[2]);
    buf (o_LED[3], 1'b0);


    //Se calcula qué se debe mostrar en los displays según el estado actual
    //(la operación, el operando A, el operando B, o el resultado)
    visualizacion_estado VIS (
        .estado(estado),
        .A(A),
        .B(B),
        .resultado(resultado),

        .display_signo(display_signo),
        .display_hex(display_hex)
    );

    //Los displays de la Go Board son active-low
    //Esto significa que un segmento se enciende cuando la señal vale 0, y se apaga cuando vale 1
    //Por eso se niegan todas las señales antes de conectarlas a los pines físicos de los displays
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
