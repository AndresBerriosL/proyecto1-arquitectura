module shift_right_4bit (
    input [3:0] A,
    input [1:0] B,
    output [3:0] R
);

    wire nB1;
    wire nB0;

    not (nB1, B[1]);
    not (nB0, B[0]);

    and (R[3], nB1, nB0, A[3]);

    wire r2_0;
    wire r2_1;

    and (r2_0, nB1, nB0, A[2]);
    and (r2_1, nB1, B[0], A[3]);
    or (R[2], r2_0, r2_1);

    wire r1_0;
    wire r1_1;
    wire r1_2;

    and (r1_0, nB1, nB0, A[1]);
    and (r1_1, nB1, B[0], A[2]);
    and (r1_2, B[1], nB0, A[3]);
    or (R[1], r1_0, r1_1, r1_2);

    wire r0_0;
    wire r0_1;
    wire r0_2;
    wire r0_3;

    and (r0_0, nB1, nB0, A[0]);
    and (r0_1, nB1, B[0], A[1]);
    and (r0_2, B[1], nB0, A[2]);
    and (r0_3, B[1], B[0], A[3]);
    or (R[0], r0_0, r0_1, r0_2, r0_3);

endmodule