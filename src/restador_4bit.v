module restador_4bit (
    input [3:0] A,
    input [3:0] B,
    output [3:0] R,
    output Cout
);

    wire B0_neg;
    wire B1_neg;
    wire B2_neg;
    wire B3_neg;

    wire C1;
    wire C2;
    wire C3;

    // Invertimos todos los bits de B
    not (B0_neg, B[0]);
    not (B1_neg, B[1]);
    not (B2_neg, B[2]);
    not (B3_neg, B[3]);

    // A + NOT(B) + 1
    full_adder_1bit FA0 (
        .A(A[0]),
        .B(B0_neg),
        .Cin(1'b1),
        .S(R[0]),
        .Cout(C1)
    );

    full_adder_1bit FA1 (
        .A(A[1]),
        .B(B1_neg),
        .Cin(C1),
        .S(R[1]),
        .Cout(C2)
    );

    full_adder_1bit FA2 (
        .A(A[2]),
        .B(B2_neg),
        .Cin(C2),
        .S(R[2]),
        .Cout(C3)
    );

    full_adder_1bit FA3 (
        .A(A[3]),
        .B(B3_neg),
        .Cin(C3),
        .S(R[3]),
        .Cout(Cout)
    );

endmodule