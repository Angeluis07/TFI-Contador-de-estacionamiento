module TFI(
  input CLK,
  input BTN1, //Sensor a
  input BTN4, //Sensor b
  output wire LED3,
  output wire LED2,
  output wire LED1,
  output wire LED0
);

wire clk_div;

divisor_1khz div(
  .clk_12mhz(CLK),
  .clk_1khz(clk_div)
);

wire BTN1_debounced;

debounce debounce1(
  .clk(clk_div),
  .btn_in(BTN1),
  .btn_out(BTN1_debounced)
);

wire BTN4_debounced;

debounce debounce2(
  .clk(clk_div),
  .btn_in(BTN4),
  .btn_out(BTN4_debounced)
);

wire s;
wire r;

FSM_3FFD_IOCars fsm(
  .clk(CLK),
  .a(BTN1_debounced),
  .b(BTN4_debounced),
  .S(s),
  .R(r)
);

wire [2:0] leds;

contador_ascendente_descendente contador(
  .clk(CLK),
  .r(r),
  .s(s),
  .leds(leds)
);

assign LED3 = 1'b0; // LED3 siempre apagado
assign LED2 = leds[2];
assign LED1 = leds[1];
assign LED0 = leds[0];


endmodule