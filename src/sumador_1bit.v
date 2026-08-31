module sumador_1bit (
    input A,
    input B,
    output S,
    output C
);

    xor (S, A, B);
    and (C, A, B);

endmodule