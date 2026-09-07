module registro_operacion_3bit (
    input clk,          //Señal de reloj, sincroniza cuándo se actualiza el registro
    input reset,        //si vale 1, borra el registro (lo pone en 0)
    input habilitar,    //si vale 1, permite que el registro cambie de valor
    input incrementar,  //si vale 1 (y habilitar=1), se avanza al siguiente código de operación
    input disminuir,    //si vale 1 (y habilitar=1), se retrocede al código de operación anterior
    output reg [2:0] Q  //Código de operación actualmente almacenado (0 a 5)
);

    //Señales negadas de Q, se usan para detectar en qué estado (valor) está actualmente el registro
    wire nQ2, nQ1, nQ0;
    
    //Señales negadas de las entradas de control
    wire nInc, nDec, nReset;
    
    //Señales que detectan exactamente en qué estado está Q (de 0 a 5)
    wire e0, e1, e2, e3, e4, e5;

    //Señales auxiliares con el valor que tomaría cada bit si se está incrementando
    wire inc0, inc1, inc2;

    //Señales auxiliares con el valor que tomaría cada bit si se está decrementando
    wire dec0, dec1, dec2;

    //Señales que indican qué acción corresponde realizar
    wire sel_inc;    //1 si corresponde incrementar
    wire sel_dec;    //1 si corresponde decrementar
    wire sel_hold;   //1 si corresponde mantener el valor actual (no hay cambio)

    //Señales auxiliares para armar cada bit del valor "siguiente"
    wire si0, sd0, sh0, m0;
    wire si1, sd1, sh1, m1;
    wire si2, sd2, sh2, m2;

    //Valor que se calculará antes de aplicar el reset, y que se guardará en Q en el próximo flanco de clk
    wire [2:0] siguiente;

    //Se niega cada bit de Q y las entradas de control, para poder armar las distintas condiciones
    not (nQ2, Q[2]);
    not (nQ1, Q[1]);
    not (nQ0, Q[0]);

    not (nInc, incrementar);
    not (nDec, disminuir);
    not (nReset, reset);

    //Se detecta en qué estado exacto se encuentra Q actualmente (0 a 5)
    and (e0, nQ2, nQ1, nQ0);    //Q=0
    and (e1, nQ2, nQ1, Q[0]);   //Q=1
    and (e2, nQ2, Q[1], nQ0);   //Q=2
    and (e3, nQ2, Q[1], Q[0]);  //Q=3
    and (e4, Q[2], nQ1, nQ0);   //Q=4
    and (e5, Q[2], nQ1, Q[0]);  //Q=5

    //Va incrementando: 0 --> 1 --> 2 --> 3 --> 4 --> 5 --> 0
    //Se arma el valor de cada bit que le correspondería a Q en el siguiente estado (al incrementar)
    or (inc0, e0, e2, e4);
    or (inc1, e1, e2);
    or (inc2, e3, e4);

    //Va decreciendo: 0 --> 5 --> 4 --> 3 --> 2 --> 1 --> 0
    //Se arma el valor de cada bit que le correspondería a Q en el siguiente estado (al decrementar)
    or (dec0, e0, e2, e4);
    or (dec1, e3, e4);
    or (dec2, e0, e5);


    //Se determina qué acción corresponde realizar:
    // -Se incrementa si está habilitado, se presiona incrementar y no se presiona disminuir
    // -Se decrementa si está habilitado, se presiona disminuir y no se presiona incrementar
    // -Se mantiene el valor si no corresponde ni incrementar ni decrementar
    and (sel_inc, habilitar, incrementar, nDec);
    and (sel_dec, habilitar, disminuir, nInc);
    nor (sel_hold, sel_inc, sel_dec);


    //Para cada bit, se elige entre el valor incrementado, decrementado o el valor actual (mantener),
    //según cuál acción esté seleccionada. Esto funciona como un multiplexor hecho con compuertas AND/OR

    //Bit 0
    and (si0, sel_inc, inc0);
    and (sd0, sel_dec, dec0);
    and (sh0, sel_hold, Q[0]);
    or  (m0, si0, sd0, sh0);  // Si reset = 1, este bit se fuerza a 0, sin importar "m0", se replica para otros bits
    and (siguiente[0], nReset, m0);

    //Bit 1
    and (si1, sel_inc, inc1);
    and (sd1, sel_dec, dec1);
    and (sh1, sel_hold, Q[1]);
    or  (m1, si1, sd1, sh1);
    and (siguiente[1], nReset, m1);

    //Bit 2
    and (si2, sel_inc, inc2);
    and (sd2, sel_dec, dec2);
    and (sh2, sel_hold, Q[2]);
    or  (m2, si2, sd2, sh2);
    and (siguiente[2], nReset, m2);

    always @(posedge clk) begin
        Q <= siguiente;
    end

endmodule
