module control_estados (
    input clk,                 //Señal de reloj, sincroniza cuándo se actualiza el estado
    input reset,               //si vale 1, vuelve al estado inicial (00)
    input confirmar,           //si vale 1, avanza al siguiente estado
    output reg [1:0] estado    //estado actual de la calculadora
);

    //Señales negadas, se usan para armar la lógica de transición de estados
    wire nConfirmar;
    wire nReset;

    //Señales auxiliares para calcular el siguiente valor de cada bit del estado,
    //en caso de que corresponda avanzar (como si fuera un contador de 2 bits)
    wire inc0;
    wire inc1;


    //Señales auxiliares para armar cada bit del estado siguiente
    wire mantener0;
    wire avanzar0;
    wire mantener1;
    wire avanzar1;

    wire m0;
    wire m1;

    //Valor que se calculará antes de aplicar el reset, y que se guardará en "estado" en el próximo flanco de clk
    wire [1:0] siguiente;

    //00 operacion, 01 A, 10 B, 11 resultado
    not (nConfirmar, confirmar);
    not (nReset, reset);

    //Se calcula cómo cambiaría cada bit del estado si se avanza (comportamiento de un contador de 2 bits)
    not (inc0, estado[0]);
    xor (inc1, estado[1], estado[0]);

    //Bit 0 del estado:
    // -Si no se confirma, se mantiene el bit 0 actual
    // -Si se confirma, se toma el valor incrementado (inc0)
    and (mantener0, nConfirmar, estado[0]);
    and (avanzar0, confirmar, inc0);
    or  (m0, mantener0, avanzar0);  //Si reset = 1, este bit se fuerza a 0, sin importar "m0"
    and (siguiente[0], nReset, m0);

    //Bit 1 del estado:
    // -Si no se confirma, se mantiene el bit 1 actual
    // -Si se confirma, se toma el valor incrementado (inc1)
    and (mantener1, nConfirmar, estado[1]);
    and (avanzar1, confirmar, inc1);
    or  (m1, mantener1, avanzar1);
    and (siguiente[1], nReset, m1);

    //En cada flanco de subida del reloj (posedge clk), "estado" toma el valor
    //calculado en "siguiente" (que ya considera si hay que avanzar, mantener o resetear)
    always @(posedge clk) begin
        estado <= siguiente;
    end

endmodule
