module TFI(
  input CLK,
  input BTN1,
  input BTN2,
  output wire LED3,
  output wire LED2,
  output wire LED1,
  output wire LED0
);

wire clk_div;
wire BTN1_debounced;
wire BTN2_debounced;

divisor_1khz div(
  .clk_12mhz(CLK),
  .clk_1khz(clk_div)
);

debounce debounce1(
  .clk(clk_div),
  .btn_in(BTN1),
  .btn_out(BTN1_debounced)
);

debounce debounce2(
  .clk(clk_div),
  .btn_in(BTN2),
  .btn_out(BTN2_debounced)
);

wire s;
wire r;

FSM_3FFD_IOCars fsm(
  .clk(clk),
  .a(BTN1_debounced),
  .b(BTN2_debounced),
  .S(s),
  .R(r)
);

wire leds[3:0];

contador_ascendente_descendente contador(
  .clk(clk),
  .r(r),
  .s(s),
  .leds(leds)
);

assign LED3 = leds[3];
assign LED2 = leds[2];
assign LED1 = leds[1];
assign LED0 = leds[0];


endmodule