module control_valores (
    input [1:0] estado,
    output habilitar_op,
    output habilitar_a,
    output habilitar_b
);

    wire nE1;
    wire nE0;

    not (nE1, estado[1]);
    not (nE0, estado[0]);

    and (habilitar_op, nE1, nE0);
    and (habilitar_a,  nE1, estado[0]);
    and (habilitar_b,  estado[1], nE0);

endmodule