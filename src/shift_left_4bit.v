module shift_left_4bit (
    input [3:0] A,
    input [1:0] B,
    output [3:0] R
);

    wire nB1;
    wire nB0;

    not (nB1, B[1]);
    not (nB0, B[0]);

    // R0
    and (R[0], nB1, nB0, A[0]);

    // R1
    wire r1_0;
    wire r1_1;

    and (r1_0, nB1, nB0, A[1]);
    and (r1_1, nB1, B[0], A[0]);
    or  (R[1], r1_0, r1_1);

    // R2
    wire r2_0;
    wire r2_1;
    wire r2_2;

    and (r2_0, nB1, nB0, A[2]);
    and (r2_1, nB1, B[0], A[1]);
    and (r2_2, B[1], nB0, A[0]);
    or  (R[2], r2_0, r2_1, r2_2);

    // R3
    wire r3_0;
    wire r3_1;
    wire r3_2;
    wire r3_3;

    and (r3_0, nB1, nB0, A[3]);
    and (r3_1, nB1, B[0], A[2]);
    and (r3_2, B[1], nB0, A[1]);
    and (r3_3, B[1], B[0], A[0]);
    or  (R[3], r3_0, r3_1, r3_2, r3_3);

endmodule