module restador_inverso_4bit (
    input [3:0] A,
    input [3:0] B,
    output [3:0] R,
    output Cout
);

    restador_4bit RESTA_INV (
        .A(B),
        .B(A),
        .R(R),
        .Cout(Cout)
    );

endmodule