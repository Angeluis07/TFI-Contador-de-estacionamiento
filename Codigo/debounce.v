module debounce (
    input wire clk,        // reloj lento (por ejemplo, 1 kHz)
    input wire btn_in,     // entrada directa del botón (con rebote)
    output reg btn_out     // salida limpia, sin rebote
);

  // Dos flip-flops en cascada para detectar estabilidad
  reg q1, q2;
  reg [1:0] estable; // Para confirmar que el botón se mantuvo igual dos ciclos

  always @(posedge clk) begin
    // Desplazamos el valor del botón por dos registros
    q1 <= btn_in;
    q2 <= q1;

    // Si q1 y q2 son iguales → el botón está estable
    if (q1 == q2)
      btn_out <= q1;
  end

endmodule