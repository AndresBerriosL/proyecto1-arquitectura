module display_signo_7seg (
    input signo, //1 si el número es negativo o 0 si es que es positivo
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g
);
    
    //Esto forma el símbolo "-" (signo menos) en el display
    buf (g, signo); //ya que "buf" es como decir que
    //g = signo pero de manera combinacional para la FPGA
    

    //Los segmentos "a, b, c, d, e, f" siempre quedan apagados porque nos interesa
    //El símbolo de "negativo" para este módulo
    and (a, signo, 1'b0);
    and (b, signo, 1'b0);
    and (c, signo, 1'b0);
    and (d, signo, 1'b0);
    and (e, signo, 1'b0);
    and (f, signo, 1'b0);

endmodule
