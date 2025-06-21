// Cambiar todo los nombres
module antirebote (
    input clk_slow,       // reloj lento (1 kHz)
    input btn_in,         // botón físico
    output reg btn_stable      // pulso de un ciclo en flanco de bajada
);

    reg q1, q2;

    always @(posedge clk_slow) begin
        q1 <= btn_in;
        q2 <= q1;
        btn_stable <= ~(q2 & q1); // La salida se pone en 1 cuando el botón está presionado y estable (activo bajo).
    end

endmodule