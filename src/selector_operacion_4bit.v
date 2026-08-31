module selector_operacion_4bit (
    input [2:0] C,
    input [3:0] SUMA,
    input [3:0] RESTA,
    input [3:0] RESTA_INV,
    input [3:0] SHIFT_L,
    input [3:0] SHIFT_R,
    output [3:0] R
);

    wire nC2;
    wire nC1;
    wire nC0;

    wire sel_suma;
    wire sel_resta;
    wire sel_inv;
    wire sel_sl;
    wire sel_sr;

    wire s0, r0, i0, l0, d0;
    wire s1, r1, i1, l1, d1;
    wire s2, r2, i2, l2, d2;
    wire s3, r3, i3, l3, d3;

    not (nC2, C[2]);
    not (nC1, C[1]);
    not (nC0, C[0]);

    and (sel_suma,  nC2, nC1, C[0]);
    and (sel_resta, nC2, C[1], nC0);
    and (sel_inv,   nC2, C[1], C[0]);
    and (sel_sl,    C[2], nC1, nC0);
    and (sel_sr,    C[2], nC1, C[0]);

    and (s0, sel_suma, SUMA[0]);
    and (r0, sel_resta, RESTA[0]);
    and (i0, sel_inv, RESTA_INV[0]);
    and (l0, sel_sl, SHIFT_L[0]);
    and (d0, sel_sr, SHIFT_R[0]);
    or (R[0], s0, r0, i0, l0, d0);

    and (s1, sel_suma, SUMA[1]);
    and (r1, sel_resta, RESTA[1]);
    and (i1, sel_inv, RESTA_INV[1]);
    and (l1, sel_sl, SHIFT_L[1]);
    and (d1, sel_sr, SHIFT_R[1]);
    or (R[1], s1, r1, i1, l1, d1);

    and (s2, sel_suma, SUMA[2]);
    and (r2, sel_resta, RESTA[2]);
    and (i2, sel_inv, RESTA_INV[2]);
    and (l2, sel_sl, SHIFT_L[2]);
    and (d2, sel_sr, SHIFT_R[2]);
    or (R[2], s2, r2, i2, l2, d2);

    and (s3, sel_suma, SUMA[3]);
    and (r3, sel_resta, RESTA[3]);
    and (i3, sel_inv, RESTA_INV[3]);
    and (l3, sel_sl, SHIFT_L[3]);
    and (d3, sel_sr, SHIFT_R[3]);
    or (R[3], s3, r3, i3, l3, d3);

endmodule