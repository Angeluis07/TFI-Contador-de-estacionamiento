/* 
 Modulo TFI (Trabajo Final Integrador)
 Descripcion: Este modulo implementa un sistema de control de estacionamiento
 utilizando una maquina de estados finitos (FSM) que controla la entrada y salida de autos,
 un contador ascendente/descendente para llevar el registro de autos en el estacionamiento,
 y un debouncer para estabilizar las entradas de los sensores.

 Universidad Nacional del Litoral
 Facultad de Ingenieria y Ciencias Hídricas
 -Materia: Electronica Digital
 -Profesores: Padula Eugenio, Quiroga Alejandro, Sanchez Guido
 -Autores: Godoy Matias, Palacios Angel
 -Fecha: 2025-06-23
*/

module TFI(
  input CLK, // Reloj de la edu-ciaa-fpga
  input BTN1, // Entrada que repesenta al par de sensores 'a' del estacionamiento
  input BTN4, // Entrada que repreesnta al par de sensores 'b' del estacionamiento
  // Salidas para los LEDs que indican el estado del estacionamiento
  output wire LED3,
  output wire LED2,
  output wire LED1,
  output wire LED0
);

  reg clk_led3 = 0; // Reloj de la edu-ciaa-fpga

  wire BTN1_estable; // Botón 1 estabilizado (sensor a)
  // Instanciación del módulo debouncer para estabilizar la señal del botón 1
  antirebote antirebote_boton1(
    .BTN(~BTN1),
    .clk(CLK),
    .BTN_estable(BTN1_estable)
  );

  wire BTN4_estable; // Botón 4 estabilizado (sensor b)
  // Instanciación del módulo debouncer para estabilizar la señal del botón 4
  antirebote antirebote_boton4(
    .BTN(~BTN4),
    .clk(CLK),
    .BTN_estable(BTN4_estable)
  );

  wire s; // Señal de entrada para el contador ascendente/descendente (ingreso de auto)
  wire r; // Señal de salida para el contador ascendente/descendente (salida de auto)

  // Instanciación de la máquina de estados finitos (FSM) que controla la entrada y salida de autos
  FSM_control_estacionamiento fsm(
    .clk(CLK),
    .a(BTN1_estable),
    .b(BTN4_estable),
    .S(s),
    .R(r)
  );

  wire [2:0] leds; // Salidas del contador ascendente/descendente que indican el estado del estacionamiento

  // Instanciación del contador ascendente/descendente que lleva el registro de autos en el estacionamiento
  contador_ascendente_descendente contador(
    .clk(CLK),
    .r(r),
    .s(s),
    .leds(leds)
  );
  

  assign LED2 = leds[2];
  assign LED1 = leds[1];
  assign LED0 = leds[0];

  // Parámetros para calcular el número de ciclos de 2 segundos
  parameter CLK_FREQ = 12000000; // 12MHz, son 12.000.000 ciclos por segundo
  parameter dos_segundos = CLK_FREQ * 2; // 2 segundos en ciclos de reloj

  // Registro para controlar el parpadeo del LED3
  // Con 25 bits puedo contar hasta 33,554,432 ciclos
  reg [25:0] contador2 = 0; //Utilizado para contar los ciclos de reloj
  reg parpadeo = 0;

  always @(posedge CLK) begin
    if (leds == 3'b111) begin
      if (contador2 >= dos_segundos - 1) begin
        contador2 <= 0;
        parpadeo <= ~parpadeo;
      end else begin
        contador2 <= contador2 + 1;
      end
    end else begin // Nos aseguramos que el LED3 se apague y se reinicie el contador2
      contador2 <= 0;
      parpadeo <= 0;
    end
  end

  // LED3 titila solo cuando leds == 3'b111
  assign LED3 = (leds == 3'b111) ? parpadeo : 1'b0;

endmodule