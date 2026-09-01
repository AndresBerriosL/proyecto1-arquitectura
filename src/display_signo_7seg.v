module display_signo_7seg (
    input signo,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g
);

    buf (g, signo);

    and (a, signo, 1'b0);
    and (b, signo, 1'b0);
    and (c, signo, 1'b0);
    and (d, signo, 1'b0);
    and (e, signo, 1'b0);
    and (f, signo, 1'b0);

endmodule