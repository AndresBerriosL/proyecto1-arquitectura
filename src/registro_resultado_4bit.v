module registro_resultado_4bit (
    input clk,           //Señal de reloj, sincroniza cuándo se actualiza el registro
    input reset,         //Si vale 1, borra el registro (lo pone en 0)
    input guardar,       //Si vale 1, indica que se debe guardar un nuevo valor (D) en el registro
    input [3:0] D,       //Nuevo valor que se quiere guardar
    output reg [3:0] Q   //Valor actualmente almacenado en el registro
);
    
    //Señales negadas, se usan para armar la lógica de selección
    wire nGuardar;
    wire nReset;

    //Señales auxiliares para armar cada bit del valor "siguiente"
    //(el valor que tomará Q en el próximo flanco de reloj)
    wire d0, q0, m0;
    wire d1, q1, m1;
    wire d2, q2, m2;
    wire d3, q3, m3;

    //Valor que se calculará antes de reset, y que se guardará en Q en el próximo flanco de clk
    wire [3:0] siguiente;

    
    //Para cada bit, se decide qué valor debe tomar "siguiente" antes de aplicar el reset:
    //Si guardar = 1, se toma el nuevo valor D
    //Si guardar = 0, se mantiene el valor actual Q (no cambia)
    //Esto funciona como un multiplexor hecho con compuertas and y or
    not (nGuardar, guardar);
    not (nReset, reset);

    //Bit 0
    and (d0, guardar, D[0]);
    and (q0, nGuardar, Q[0]);
    or (m0, d0, q0);
    //Si reset = 1, este bit se fuerza a 0, sin importar "m0", luego se aplica a los otros bits
    and (siguiente[0], nReset, m0);

    //Bit 1
    and (d1, guardar, D[1]);
    and (q1, nGuardar, Q[1]);
    or (m1, d1, q1);
    and (siguiente[1], nReset, m1);

    //Bit 2
    and (d2, guardar, D[2]);
    and (q2, nGuardar, Q[2]);
    or (m2, d2, q2);
    and (siguiente[2], nReset, m2);

    //Bit 3
    and (d3, guardar, D[3]);
    and (q3, nGuardar, Q[3]);
    or (m3, d3, q3);
    and (siguiente[3], nReset, m3);

    //En cada flanco de subida del reloj (posedge clk), el registro Q toma el valor
    //calculado en "siguiente" (que ya considera si hay que guardar, mantener o resetear)
    always @(posedge clk) begin
        Q <= siguiente;
    end

endmodule
