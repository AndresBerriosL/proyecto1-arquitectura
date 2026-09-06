module display_hex_7seg (
    input [3:0] valor, //Número de 4 bits (del 0 al 15, pero en hexadecimal)
    
    //Cada output representa un segmento del display de 7 segmentos
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g
);
    //Señales negadas de cada bit de "valor", se usan para detectar cuando un bit es 0
    wire n3, n2, n1, n0;

    //Señales que representan cada posible valor hexadecimal
    wire v0, v1, v2, v3;
    wire v4, v5, v6, v7;
    wire v8, v9, vA, vB;
    wire vC, vD, vE, vF;

    //Se niega cada bit de "valor" para poder detectar los ceros del número
    not (n3, valor[3]);
    not (n2, valor[2]);
    not (n1, valor[1]);
    not (n0, valor[0]);

    // Cada "and" detecta una combinación específica de bits, es decir, un número exacto
    // Esto es como decodificar el número de 4 bits en 16 señales, 
    //una por cada valor posible de lo que queremos mostrar (0-15)
    and (v0, n3, n2, n1, n0);
    and (v1, n3, n2, n1, valor[0]);
    and (v2, n3, n2, valor[1], n0);
    and (v3, n3, n2, valor[1], valor[0]);

    and (v4, n3, valor[2], n1, n0);
    and (v5, n3, valor[2], n1, valor[0]);
    and (v6, n3, valor[2], valor[1], n0);
    and (v7, n3, valor[2], valor[1], valor[0]);

    and (v8, valor[3], n2, n1, n0);
    and (v9, valor[3], n2, n1, valor[0]);
    and (vA, valor[3], n2, valor[1], n0);
    and (vB, valor[3], n2, valor[1], valor[0]);

    and (vC, valor[3], valor[2], n1, n0);
    and (vD, valor[3], valor[2], n1, valor[0]);
    and (vE, valor[3], valor[2], valor[1], n0);
    and (vF, valor[3], valor[2], valor[1], valor[0]);

    // a b c d e f g (se prende cada segmento dependiendo del valor ingresado)
    //Estos "or" son en pocas palabras el decodificador para el display de 
    //7 segmentos en base a una cadena de las compuertas lógicas "or"
    or (a, v0, v2, v3, v5, v6, v7, v8, v9, vA, vC, vE, vF);
    or (b, v0, v1, v2, v3, v4, v7, v8, v9, vA, vD);
    or (c, v0, v1, v3, v4, v5, v6, v7, v8, v9, vA, vB, vD);
    or (d, v0, v2, v3, v5, v6, v8, v9, vB, vC, vD, vE);
    or (e, v0, v2, v6, v8, vA, vB, vC, vD, vE, vF);
    or (f, v0, v4, v5, v6, v8, v9, vA, vB, vC, vE, vF);
    or (g, v2, v3, v4, v5, v6, v8, v9, vA, vB, vD, vE, vF);

endmodule
