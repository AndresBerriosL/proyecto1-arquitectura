module botones_goboard (
    input clk,
    input reset,

    input sw_incrementar,
    input sw_disminuir,
    input sw_confirmar,
    input sw_anterior,

    output incrementar,
    output disminuir,
    output confirmar,
    output usar_anterior
);

    wire nReset;

    reg inc_s1, inc_s2;
    reg dec_s1, dec_s2;
    reg conf_s1, conf_s2;
    reg ant_s1, ant_s2;

    wire inc_s1_next, inc_s2_next;
    wire dec_s1_next, dec_s2_next;
    wire conf_s1_next, conf_s2_next;
    wire ant_s1_next, ant_s2_next;

    not (nReset, reset);

    and (inc_s1_next, nReset, sw_incrementar);
    and (inc_s2_next, nReset, inc_s1);

    and (dec_s1_next, nReset, sw_disminuir);
    and (dec_s2_next, nReset, dec_s1);

    and (conf_s1_next, nReset, sw_confirmar);
    and (conf_s2_next, nReset, conf_s1);

    and (ant_s1_next, nReset, sw_anterior);
    and (ant_s2_next, nReset, ant_s1);

    always @(posedge clk) begin
        inc_s1 <= inc_s1_next;
        inc_s2 <= inc_s2_next;

        dec_s1 <= dec_s1_next;
        dec_s2 <= dec_s2_next;

        conf_s1 <= conf_s1_next;
        conf_s2 <= conf_s2_next;

        ant_s1 <= ant_s1_next;
        ant_s2 <= ant_s2_next;
    end


    reg [17:0] contador;

    wire [17:0] inc_contador;
    wire [18:0] carry;
    wire [17:0] contador_siguiente;

    wire tick;

    buf (carry[0], 1'b1);

    xor (inc_contador[0], contador[0], carry[0]);
    and (carry[1], contador[0], carry[0]);

    xor (inc_contador[1], contador[1], carry[1]);
    and (carry[2], contador[1], carry[1]);

    xor (inc_contador[2], contador[2], carry[2]);
    and (carry[3], contador[2], carry[2]);

    xor (inc_contador[3], contador[3], carry[3]);
    and (carry[4], contador[3], carry[3]);

    xor (inc_contador[4], contador[4], carry[4]);
    and (carry[5], contador[4], carry[4]);

    xor (inc_contador[5], contador[5], carry[5]);
    and (carry[6], contador[5], carry[5]);

    xor (inc_contador[6], contador[6], carry[6]);
    and (carry[7], contador[6], carry[6]);

    xor (inc_contador[7], contador[7], carry[7]);
    and (carry[8], contador[7], carry[7]);

    xor (inc_contador[8], contador[8], carry[8]);
    and (carry[9], contador[8], carry[8]);

    xor (inc_contador[9], contador[9], carry[9]);
    and (carry[10], contador[9], carry[9]);

    xor (inc_contador[10], contador[10], carry[10]);
    and (carry[11], contador[10], carry[10]);

    xor (inc_contador[11], contador[11], carry[11]);
    and (carry[12], contador[11], carry[11]);

    xor (inc_contador[12], contador[12], carry[12]);
    and (carry[13], contador[12], carry[12]);

    xor (inc_contador[13], contador[13], carry[13]);
    and (carry[14], contador[13], carry[13]);

    xor (inc_contador[14], contador[14], carry[14]);
    and (carry[15], contador[14], carry[14]);

    xor (inc_contador[15], contador[15], carry[15]);
    and (carry[16], contador[15], carry[15]);

    xor (inc_contador[16], contador[16], carry[16]);
    and (carry[17], contador[16], carry[16]);

    xor (inc_contador[17], contador[17], carry[17]);
    and (carry[18], contador[17], carry[17]);

    buf (tick, carry[18]);

    and (contador_siguiente[0], nReset, inc_contador[0]);
    and (contador_siguiente[1], nReset, inc_contador[1]);
    and (contador_siguiente[2], nReset, inc_contador[2]);
    and (contador_siguiente[3], nReset, inc_contador[3]);
    and (contador_siguiente[4], nReset, inc_contador[4]);
    and (contador_siguiente[5], nReset, inc_contador[5]);
    and (contador_siguiente[6], nReset, inc_contador[6]);
    and (contador_siguiente[7], nReset, inc_contador[7]);
    and (contador_siguiente[8], nReset, inc_contador[8]);
    and (contador_siguiente[9], nReset, inc_contador[9]);
    and (contador_siguiente[10], nReset, inc_contador[10]);
    and (contador_siguiente[11], nReset, inc_contador[11]);
    and (contador_siguiente[12], nReset, inc_contador[12]);
    and (contador_siguiente[13], nReset, inc_contador[13]);
    and (contador_siguiente[14], nReset, inc_contador[14]);
    and (contador_siguiente[15], nReset, inc_contador[15]);
    and (contador_siguiente[16], nReset, inc_contador[16]);
    and (contador_siguiente[17], nReset, inc_contador[17]);

    always @(posedge clk) begin
        contador <= contador_siguiente;
    end


    reg inc_anterior;
    reg dec_anterior;
    reg conf_anterior;
    reg ant_anterior;

    wire nTick;

    wire nIncAnterior;
    wire nDecAnterior;
    wire nConfAnterior;

    wire inc_keep, inc_load, inc_m, inc_next;
    wire dec_keep, dec_load, dec_m, dec_next;
    wire conf_keep, conf_load, conf_m, conf_next;
    wire ant_keep, ant_load, ant_m, ant_next;

    not (nTick, tick);

    not (nIncAnterior, inc_anterior);
    not (nDecAnterior, dec_anterior);
    not (nConfAnterior, conf_anterior);

    and (incrementar, tick, inc_s2, nIncAnterior);
    and (disminuir, tick, dec_s2, nDecAnterior);
    and (confirmar, tick, conf_s2, nConfAnterior);

    and (inc_keep, nTick, inc_anterior);
    and (inc_load, tick, inc_s2);
    or  (inc_m, inc_keep, inc_load);
    and (inc_next, nReset, inc_m);

    and (dec_keep, nTick, dec_anterior);
    and (dec_load, tick, dec_s2);
    or  (dec_m, dec_keep, dec_load);
    and (dec_next, nReset, dec_m);

    and (conf_keep, nTick, conf_anterior);
    and (conf_load, tick, conf_s2);
    or  (conf_m, conf_keep, conf_load);
    and (conf_next, nReset, conf_m);

    and (ant_keep, nTick, ant_anterior);
    and (ant_load, tick, ant_s2);
    or  (ant_m, ant_keep, ant_load);
    and (ant_next, nReset, ant_m);

    always @(posedge clk) begin
        inc_anterior <= inc_next;
        dec_anterior <= dec_next;
        conf_anterior <= conf_next;
        ant_anterior <= ant_next;
    end

    buf (usar_anterior, ant_anterior);

endmodule