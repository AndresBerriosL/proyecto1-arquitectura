module full_adder_1bit (
    input A,
    input B,
    input Cin, //Agregamos soporte para un acarreo de antes que no estaba en el Half_adder (sumador_1bit.v)
    output S,
    output Cout //Y acá el accareo de salida del full adder
);

    wire X;
    wire C1;
    wire C2;

    sumador_1bit HA1 (
        .A(A),
        .B(B),
        .S(X),
        .C(C1)
    ); 
    
    //Cuando se llama a otro módulo, estamos llamando
    //Como si fuera una función multivariable que el
    //la FPGA internamente conecta los diferentes elementos,
    //en este caso nuestros half_adders son del formato:
    //"modulo(.arg1(algo) , .arg2(algo) [.....])"
    //Este tipo de llamadas las hacemos a lo largo de todos
    //los módulos del proyecto

    sumador_1bit HA2 (
        .A(X),
        .B(Cin),
        .S(S),
        .C(C2)
    );

    //En vez de hacer un full_adder desde cero, estamos
    //llamando dos veces al módulo del half_adder en cascada
    //ya que es una implementación más simple.
    or (Cout, C1, C2);

endmodule
