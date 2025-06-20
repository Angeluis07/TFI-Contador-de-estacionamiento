// Divide 12 MHz a 1 kHz → necesitás dividir por 12,000
module divisor_1khz (
    input wire clk_12mhz,
    output reg clk_1khz
);

  reg [13:0] contador = 0; // log2(12000) ≈ 14 bits

  always @(posedge clk_12mhz) begin
    if (contador == 11999) begin
      contador <= 0;
      clk_1khz <= ~clk_1khz; // cambia de estado → genera reloj de 1 kHz
    end else begin
      contador <= contador + 1;
    end
  end
endmodule