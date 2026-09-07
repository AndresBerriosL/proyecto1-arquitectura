module visualizador_valor_4bit (
    input [3:0] valor,      //Número de 4 bits en complemento a 2 que queremos ver
    output [6:0] display_signo, //Señales para el display que muestra el signo + o -
    output [6:0] display_hex    //Señales para el display que muestra el valor en hexadecimal
);

    wire signo;
    wire [3:0] magnitud;

    //Se calcula el signo y la magnitud del número de entrada
    magnitud_4bit MAG (
        .valor(valor),
        .signo(signo),
        .magnitud(magnitud)
    );

    //Cada segmento del display (a-g) se conecta a un bit del bus display_signo
    display_signo_7seg SIGNO (
        .signo(signo),
        .a(display_signo[6]),
        .b(display_signo[5]),
        .c(display_signo[4]),
        .d(display_signo[3]),
        .e(display_signo[2]),
        .f(display_signo[1]),
        .g(display_signo[0])
    );

    //Cada segmento del display (a-g) se conecta a un bit del bus display_hex
    display_hex_7seg HEX (
        .valor(magnitud),
        .a(display_hex[6]),
        .b(display_hex[5]),
        .c(display_hex[4]),
        .d(display_hex[3]),
        .e(display_hex[2]),
        .f(display_hex[1]),
        .g(display_hex[0])
    );

endmodule
