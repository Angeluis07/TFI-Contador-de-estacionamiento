/*
module antirrebote (
    input clk_slow,       // reloj lento (1 kHz)
    input btn_in,         // botón físico
    output btn_stable     // señal estable, libre de rebote
);

    reg q1, q2;

    // Flip-flops en cascada sincronizados con reloj lento
    always @(posedge clk_slow) begin
        q1 <= btn_in;
        q2 <= q1;
    end

    // Salida estable: solo cambia si el botón fue igual 2 ciclos seguidos
    assign btn_stable = (q1 & q2);

endmodule
*/
module antirrebote (
    input clk_slow,       // reloj lento (1 kHz)
    input btn_in,         // botón físico
    output reg btn_stable      // pulso de un ciclo en flanco de bajada
);

    reg q1, q2;

    always @(posedge clk_slow) begin
        q1 <= btn_in;
        q2 <= q1;
        btn_stable <= ~(q2 & q1); // Pulso de 1 ciclo en flanco de SUBIDA
    end

endmodule