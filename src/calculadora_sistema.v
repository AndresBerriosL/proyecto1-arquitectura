module calculadora_sistema (
    input clk,            //Señal de reloj
    input reset,          //si vale 1, resetea el sistema completo
    input confirmar,      // avanza al siguiente estado (operación -> A -> B -> resultado)
    input incrementar,    // incrementa el valor actualmente habilitado
    input disminuir,      // disminuye el valor actualmente habilitado
    input usar_anterior,  // si vale 1, se usa el resultado anterior como segundo operando

    output [1:0] estado,      // estado actual de la calculadora
    output [2:0] operacion,   // código de la operación seleccionada
    output [3:0] A,           // valor actual del operando A
    output [3:0] B,           // valor actual del operando B
    output [3:0] resultado    // resultado calculado por la calculadora
);

    //Señal negada del bit 0 de "estado", se usa para detectar el estado correspondiente a B
    wire nE0;
    
    //Señal que indica el momento en que se debe guardar el resultado (calcular)
    wire guardar;

    //Se controla la entrada del usuario: operación, operando A y operando B,
    //según el estado actual de la calculadora
    control_entrada ENTRADA (
        .clk(clk),
        .reset(reset),
        .confirmar(confirmar),
        .incrementar(incrementar),
        .disminuir(disminuir),
        .estado(estado),
        .operacion(operacion),
        .A(A),
        .B(B)
    );

    not (nE0, estado[0]);

    //guarda al confirmar el segundo operando
    //Esto ocurre específicamente cuando estado = 10 (operando B) y se presiona confirmar
    //Es en ese momento cuando ya se tienen ambos operandos y corresponde calcular el resultado
    and (guardar, confirmar, estado[1], nE0);

    //Módulo que realiza el cálculo real de la operación (suma, resta, shift, etc.)
    //y guarda el resultado en su registro interno cuando "guardar" está activo
    calculadora_core_4bit CALC (
        .clk(clk),
        .reset(reset),
        .guardar(guardar),
        .usar_anterior(usar_anterior),
        .operacion(operacion),
        .A(A),
        .OP2(B),
        .resultado(resultado)
    );

endmodule
