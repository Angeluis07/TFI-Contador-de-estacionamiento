`timescale 1ns/1ps

module TFI_tb();

// Entradas
reg clk = 0;
reg r = 0;
reg s = 0;

// Salidas
wire [2:0] leds;

contador_ascendente_descendente UUT(
    .clk(clk),
    .r(r),
    .s(s),
    .leds(leds)
);

always #1 clk = ~clk;

initial begin
  $dumpfile("TFI_tb.vcd");
  $dumpvars(0, TFI_tb);
  // Generación del reloj
  #5;
  s = 1;
  #5;
  s = 0;
  #5;
  s = 1;
  #5;
  s = 0;
  #5;
  s = 1;
  #5;
  s = 0;
  #5;
  s = 1;
  #5;
  s = 0;
  #5;
  s = 1;
  #5;
  s = 0;
  #5;
  s = 1;
  #5;
  s = 0;
  #5;
  s = 1;
  #5;
  s = 0;
  #5;
  r = 1;
  #5;
  r = 0;
  #5;
  r = 1;
  #5;
  r = 0;
  #5;
  r = 1;
  #5;
  r = 0;
  #5;
  r = 1;
  #5;
  r = 0;
  #5;
  r = 1;
  #5;
  r = 0;
  #5;
  r = 1;
  #5;
  r = 0;
  #5;
  r = 1;
  #5;
  r = 0;
  #5;
  r = 1;
  #5;
  r = 0;
  $finish;
end

endmodule