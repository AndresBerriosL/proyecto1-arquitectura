module control_entrada (
    input clk,            //Señal de reloj
    input reset,          //Si vale 1, resetea todos los registros internos
    input confirmar,      //avanza al siguiente estado (operación -> A -> B -> resultado)
    input incrementar,    //incrementa el valor actualmente habilitado (operación, A o B)
    input disminuir,      //disminuye el valor actualmente habilitado (operación, A o B)

    output [1:0] estado,    //Estado actual de la calculadora
    output [2:0] operacion, //Código de la operación seleccionada
    output [3:0] A,         //Valor actual del operando A
    output [3:0] B          //Valor actual del operando B
);

    //Señales que indican cuál valor está habilitado para ser modificado según el estado actual
    wire habilitar_op;
    wire habilitar_a;
    wire habilitar_b;


    //Se controla en qué estado se encuentra la calculadora (operación, A, B o resultado)
    control_estados ESTADOS (
        .clk(clk),
        .reset(reset),
        .confirmar(confirmar),
        .estado(estado)
    );

    //Según el estado actual, se determina cuál de los tres valores (operación, A o B)
    //debe estar habilitado para ser modificado con los botones de incrementar/disminuir
    control_valores VALORES (
        .estado(estado),
        .habilitar_op(habilitar_op),
        .habilitar_a(habilitar_a),
        .habilitar_b(habilitar_b)
    );

    //Registro que almacena el código de la operación seleccionada
    //Solo cambia de valor cuando "habilitar_op" está activo
    registro_operacion_3bit REG_OP (
        .clk(clk),
        .reset(reset),
        .habilitar(habilitar_op),
        .incrementar(incrementar),
        .disminuir(disminuir),
        .Q(operacion)
    );

    //Registro que almacena el valor del operando A
    //Solo cambia de valor cuando "habilitar_a" está activo
    registro_ajustable_4bit REG_A (
        .clk(clk),
        .reset(reset),
        .habilitar(habilitar_a),
        .incrementar(incrementar),
        .disminuir(disminuir),
        .Q(A)
    );

    //Registro que almacena el valor del operando B
    //Solo cambia de valor cuando "habilitar_b" está activo
    registro_ajustable_4bit REG_B (
        .clk(clk),
        .reset(reset),
        .habilitar(habilitar_b),
        .incrementar(incrementar),
        .disminuir(disminuir),
        .Q(B)
    );

endmodule
