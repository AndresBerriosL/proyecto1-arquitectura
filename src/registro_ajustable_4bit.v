module registro_ajustable_4bit (
    input clk,            //Señal de reloj, sincroniza cuándo se actualiza el registro
    input reset,          //si vale 1, borra el registro (lo pone en 0)
    input habilitar,      //si vale 1, permite que el registro cambie de valor
    input incrementar,    //si vale 1 (y habilitar=1), se suma 1 al valor actual
    input disminuir,      //si vale 1 (y habilitar=1), se resta 1 al valor actual
    output reg [3:0] Q    //Valor de 4 bits actualmente almacenado
);
    
    //Resultado de sumar 1 al valor actual de Q
    wire [3:0] suma;

    //Resultado de restar 1 al valor actual de Q
    wire [3:0] resta;

    //Señales que indican qué acción corresponde realizar
    wire sel_inc;  //1 si corresponde incrementar
    wire sel_dec;  //1 si corresponde decrementar
    wire sel_hold; //1 si corresponde mantener el valor actual (no hay cambio)

    //Señales negadas de las entradas de control
    wire nInc;
    wire nDec;
    wire nReset;

    //Valor que se calculará antes de aplicar el reset, y que se guardará en Q en el próximo flanco de clk
    wire [3:0] siguiente;

    //Señales auxiliares para armar cada bit del valor "siguiente"
    wire si0, sd0, sh0, m0;
    wire si1, sd1, sh1, m1;
    wire si2, sd2, sh2, m2;
    wire si3, sd3, sh3, m3;

    //Acarreos de salida de la suma y la resta (no se usan después, pero hay que conectarlos)
    wire cout_suma;
    wire cout_resta;

    //Se calcula Q + 1 (para el caso en que se incremente)
    sumador_4bit INC (
        .A(Q),
        .B(4'b0001),
        .S(suma),
        .Cout(cout_suma)
    );
    //Se calcula Q - 1 (para el caso en que se decremente)
    restador_4bit DEC (
        .A(Q),
        .B(4'b0001),
        .R(resta),
        .Cout(cout_resta)
    );

    //Se niegan las entradas de control, para poder armar las distintas condiciones
    not (nInc, incrementar);
    not (nDec, disminuir);
    not (nReset, reset);

    //Se determina qué acción corresponde realizar:
    // -Se incrementa si está habilitado, se presiona incrementar y no se presiona disminuir
    // -Se decrementa si está habilitado, se presiona disminuir y no se presiona incrementar
    // -Se mantiene el valor si no corresponde ni incrementar ni decrementar
    and (sel_inc, habilitar, incrementar, nDec);
    and (sel_dec, habilitar, disminuir, nInc);

    nor (sel_hold, sel_inc, sel_dec);

    
    //Para cada bit, se elige entre el valor de "suma", "resta" o el valor actual (mantener),
    //según cuál acción esté seleccionada. Esto funciona como un multiplexor hecho con compuertas AND/OR

    //Bit 0
    and (si0, sel_inc, suma[0]);
    and (sd0, sel_dec, resta[0]);
    and (sh0, sel_hold, Q[0]);
    or  (m0, si0, sd0, sh0); //Si reset = 1, este bit se fuerza a 0, sin importar "m0", se aplica a los otros bits también
    and (siguiente[0], nReset, m0);

    //Bit 1
    and (si1, sel_inc, suma[1]);
    and (sd1, sel_dec, resta[1]);
    and (sh1, sel_hold, Q[1]);
    or  (m1, si1, sd1, sh1);
    and (siguiente[1], nReset, m1);

    //Bit 2
    and (si2, sel_inc, suma[2]);
    and (sd2, sel_dec, resta[2]);
    and (sh2, sel_hold, Q[2]);
    or  (m2, si2, sd2, sh2);
    and (siguiente[2], nReset, m2);

    //Bit 3
    and (si3, sel_inc, suma[3]);
    and (sd3, sel_dec, resta[3]);
    and (sh3, sel_hold, Q[3]);
    or  (m3, si3, sd3, sh3);
    and (siguiente[3], nReset, m3);

    //En cada flanco de subida del reloj (posedge clk), el registro Q toma el valor
    //calculado en "siguiente" (que ya considera si hay que incrementar, decrementar, mantener o resetear)
    always @(posedge clk) begin
        Q <= siguiente;
    end

endmodule
