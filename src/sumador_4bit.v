module sumador_4bit (
    input [3:0] A,
    input [3:0] B,
    output [3:0] S,
    output Cout
);

    wire C1;
    wire C2;
    wire C3;

    full_adder_1bit FA0 (
        .A(A[0]),
        .B(B[0]),
        .Cin(1'b0),
        .S(S[0]),
        .Cout(C1)
    );

    full_adder_1bit FA1 (
        .A(A[1]),
        .B(B[1]),
        .Cin(C1),
        .S(S[1]),
        .Cout(C2)
    );

    full_adder_1bit FA2 (
        .A(A[2]),
        .B(B[2]),
        .Cin(C2),
        .S(S[2]),
        .Cout(C3)
    );

    full_adder_1bit FA3 (
        .A(A[3]),
        .B(B[3]),
        .Cin(C3),
        .S(S[3]),
        .Cout(Cout)
    );

endmodule