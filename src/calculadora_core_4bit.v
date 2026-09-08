module calculadora_core_4bit (
    input clk,                //Señal de reloj
    input reset,              //si vale 1, resetea el resultado almacenado
    input guardar,            //si vale 1, se calcula y guarda el nuevo resultado
    input usar_anterior,      //si vale 1, se usa el resultado anterior como segundo operando
    input [2:0] operacion,    //Código de la operación a realizar
    input [3:0] A,            //Primer operando
    input [3:0] OP2,          //Segundo operando ingresado normalmente
    output [3:0] resultado    //Resultado final almacenado por la calculadora
);

    //Segundo operando final que se usará en los cálculos (puede ser OP2 o el resultado anterior)
    wire [3:0] B;

    //Resultados de cada una de las operaciones posibles, calculadas todas en paralelo
    wire [3:0] suma;
    wire [3:0] resta;
    wire [3:0] resta_inv;
    wire [3:0] shift_l;
    wire [3:0] shift_r;

    //Resultado ya seleccionado, según la operación indicada, antes de guardarse en el registro
    wire [3:0] calculado;

    //Acarreos de salida de la suma y las restas (no se usan después, pero hay que conectarlos)
    wire cout_suma;
    wire cout_resta;
    wire cout_inv;

    //Se decide si el segundo operando será "OP2" o el resultado de la operación anterior
    selector_op2_4bit SEL_B (
        .OP2(OP2),
        .ANTERIOR(resultado),
        .usar_anterior(usar_anterior),
        .R(B)
    );

    //Se calculan todas las operaciones posibles en paralelo, usando A y B

    //Suma de A y B
    sumador_4bit SUM (
        .A(A),
        .B(B),
        .S(suma),
        .Cout(cout_suma)
    );

    //Resta de A menos B
    restador_4bit REST (
        .A(A),
        .B(B),
        .R(resta),
        .Cout(cout_resta)
    );

    //Resta de B menos A (resta invertida)
    restador_inverso_4bit REST_INV (
        .A(A),
        .B(B),
        .R(resta_inv),
        .Cout(cout_inv)
    );

    //Desplazamiento de A hacia la izquierda, usando los 2 bits menos significativos de B como cantidad
    shift_left_4bit SL (
        .A(A),
        .B(B[1:0]),
        .R(shift_l)
    );

    //Desplazamiento de A hacia la derecha, usando los 2 bits menos significativos de B como cantidad
    shift_right_4bit SR (
        .A(A),
        .B(B[1:0]),
        .R(shift_r)
    );

    //Se elige cuál de todos los resultados calculados corresponde utilizar,
    //según el código de operación indicado
    selector_operacion_4bit SEL_OP (
        .C(operacion),
        .SUMA(suma),
        .RESTA(resta),
        .RESTA_INV(resta_inv),
        .SHIFT_L(shift_l),
        .SHIFT_R(shift_r),
        .R(calculado)
    );

    //Se guarda el resultado calculado en un registro, para que quede disponible
    //de forma estable hasta que se realice un nuevo cálculo
    registro_resultado_4bit REG_RESULTADO (
        .clk(clk),
        .reset(reset),
        .guardar(guardar),
        .D(calculado),
        .Q(resultado)
    );

endmodule
