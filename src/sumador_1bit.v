module sumador_1bit (
    input A,
    input B,
    output S,
    output C
);
//En efecto si tenemos un sumador de 1 bit que incluye el acarreo de
//salida, es nuestro half_adder de un solo bit, coincide con la lógica
//combinacional del Seba, además es importante recordar que los
//inputs en este módulo son de solamente 1 bit, no son los números
//reales con los que si queremos operar. Este si mal no recuerdo es
//el módulo más simple combinacionalmente.
    xor (S, A, B);
    and (C, A, B);

endmodule
