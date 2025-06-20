
module TFI_m(
  input CLK,
  input BTN1,
  input BTN2,
  output wire LED3,
  output wire LED2,
  output wire LED1,
  output wire LED0
);

  // Señales antirrebote para los botones
  wire sensor_a, sensor_b;

  antirebote_temporal debounce_a (
    .clk(CLK),
    .entrada(BTN1),
    .pulso_valido(sensor_a)
  );

  antirebote_temporal debounce_b (
    .clk(CLK),
    .entrada(BTN2),
    .pulso_valido(sensor_b)
  );

  // Señales de control de la FSM de sensores
  wire S, R;

  FSM_3FFD_IOCars fsm_sensores (
    .clk(CLK),
    .a(sensor_a),
    .b(sensor_b),
    .S(S),
    .R(R)
  );

  // Contador ascendente/descendente
  wire [2:0] cuenta_autos;

  contador_ascendente_descendente contador (
    .clk(CLK),
    .r(R),
    .s(S),
    .leds(cuenta_autos)
  );

  // Mostrar el valor del contador en los LEDs
  assign {LED3, LED2, LED1, LED0} = {1'b0, cuenta_autos};

endmodule