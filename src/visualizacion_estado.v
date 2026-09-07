module visualizacion_estado (
    input [1:0] estado,     //Estado actual de la calculadora (define qué valor se debe mostrar)
    input [3:0] A,          //Número A
    input [3:0] B,          //Número B
    input [3:0] resultado,  //Resultado de la operación

    output [6:0] display_signo, //Muestra el signo
    output [6:0] display_hex    //Muestra el valor hexadecimal
);
    //Señales negadas de "estado", se usan para detectar las distintas combinaciones de estado
    wire nE1;
    wire nE0;

   //Señales que indican qué valor se debe mostrar según el estado actual
    wire sel_a;         //1 --> Mostrar A
    wire sel_b;         //1 --> Mostrar B
    wire sel_resultado; //1 --> Mostrar resultado
    wire mostrar;       //1 --> Mostrar (condición de que se debe mostrar)

    //Valor de 4 bits que finalmente se enviará a los displays (A, B o resultado, según el estado)
    wire [3:0] valor;


    //Valores auxiliares para armar cada bit de "valor" según el estado
    wire a0, b0, r0;
    wire a1, b1, r1;
    wire a2, b2, r2;
    wire a3, b3, r3;


    //Señales internas que entrega el visualizador antes de decidir si se muestran o no
    wire [6:0] signo_interno;
    wire [6:0] hex_interno;


    //--------------------------  Ahora la lógica Combinacional -------------------------------

    
    
    // Se niega cada bit de "estado" para poder detectar las distintas combinaciones
    not (nE1, estado[1]);
    not (nE0, estado[0]);

    //Se determina qué valor corresponde mostrar según el estado:
    //Estado = 01 --> muestra A
    //Estado = 10 --> muestra B
    //Estado = 11 --> muestra el resultado
    and (sel_a, nE1, estado[0]);
    and (sel_b, estado[1], nE0);
    and (sel_resultado, estado[1], estado[0]);


    //"mostrar" es 1 si el estado corresponde a alguno de los tres casos anteriores
    //(si el estado es 00, no se muestra nada)
    or (mostrar, sel_a, sel_b, sel_resultado);


    //Para cada bit, se elige entre A, B o resultado según cuál esté seleccionado
    //Esto funciona como un multiplexor hecho con compuertas AND/OR
    //Se realiza para cada bit y luego se aplica el módulo visualizador_valor_4bit
    and (a0, sel_a, A[0]);
    and (b0, sel_b, B[0]);
    and (r0, sel_resultado, resultado[0]);
    or  (valor[0], a0, b0, r0);

    and (a1, sel_a, A[1]);
    and (b1, sel_b, B[1]);
    and (r1, sel_resultado, resultado[1]);
    or  (valor[1], a1, b1, r1);

    and (a2, sel_a, A[2]);
    and (b2, sel_b, B[2]);
    and (r2, sel_resultado, resultado[2]);
    or  (valor[2], a2, b2, r2);

    and (a3, sel_a, A[3]);
    and (b3, sel_b, B[3]);
    and (r3, sel_resultado, resultado[3]);
    or  (valor[3], a3, b3, r3);

    visualizador_valor_4bit VIS (
        .valor(valor),
        .display_signo(signo_interno),
        .display_hex(hex_interno)
    );


    //Las señales finales de los displays solo se activan si "mostrar" es 1,
    //Pero si "mostrar" es 0 (estado = 00), todos los segmentos quedan apagados
    and (display_signo[0], mostrar, signo_interno[0]);
    and (display_signo[1], mostrar, signo_interno[1]);
    and (display_signo[2], mostrar, signo_interno[2]);
    and (display_signo[3], mostrar, signo_interno[3]);
    and (display_signo[4], mostrar, signo_interno[4]);
    and (display_signo[5], mostrar, signo_interno[5]);
    and (display_signo[6], mostrar, signo_interno[6]);

    and (display_hex[0], mostrar, hex_interno[0]);
    and (display_hex[1], mostrar, hex_interno[1]);
    and (display_hex[2], mostrar, hex_interno[2]);
    and (display_hex[3], mostrar, hex_interno[3]);
    and (display_hex[4], mostrar, hex_interno[4]);
    and (display_hex[5], mostrar, hex_interno[5]);
    and (display_hex[6], mostrar, hex_interno[6]);

endmodule
