module full_adder_1bit (
    input A,
    input B,
    input Cin,
    output S,
    output Cout
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

    sumador_1bit HA2 (
        .A(X),
        .B(Cin),
        .S(S),
        .C(C2)
    );

    or (Cout, C1, C2);

endmodule