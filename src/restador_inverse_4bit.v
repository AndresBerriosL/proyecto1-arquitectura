module restador_inverso_4bit (
    input [3:0] A,
    input [3:0] B,
    output [3:0] R,
    output Cout
);

//Básicamente este es el módulo para cambiar el orden de
//operación de A - B ---> B - A
//Creo que de este no tenemos un diagrama, pero no debiese
//ser relevante, ya que combinacionalmente sería el equivalente
//a cambiar de orden las entradas.
//Por otra parte acá se puede observar un caso donde se podría
//generar confusión entre los nombres de los argumentos del módulo
//que está siendo llamado  y los nombres de las variables que 
//están siendo utilizadas por el módulo.

    restador_4bit RESTA_INV (
        .A(B),
        .B(A),
        .R(R),
        .Cout(Cout)
    );

endmodule
