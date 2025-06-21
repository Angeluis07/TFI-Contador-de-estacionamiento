`timescale 1ns/1ps

module TFI_tb();

  // Entradas
  reg clk = 0; // Reloj de la edu-ciaa-fpga
  reg a = 0; // Entrada que representa al par de sensores 'a' del estacionamiento
  reg b = 0; // Entrada que representa al par de sensores 'b' del estacionamiento

  // Salidas
  wire LED_3; // LED que indica el estado del estacionamiento (siempre apagado)
  wire LED_2; // LED que indica el estado del estacionamiento
  wire LED_1; // LED que indica el estado del estacionamiento
  wire LED_0; // LED que indica el estado del estacionamiento

  TFI UUT(
    .CLK(clk), // Conexión del reloj
    .BTN1(a), // Conexión del primer botón (sensor 'a')
    .BTN4(b), // Conexión del segundo botón (sensor 'b')
    .LED3(LED_3), // Conexión del LED 3
    .LED2(LED_2), // Conexión del LED 2
    .LED1(LED_1), // Conexión del LED 1
    .LED0(LED_0)  // Conexión del LED 0
  );

  always #1 clk = ~clk;

  initial begin
    $dumpfile("TFI_tb.vcd");
    $dumpvars(0, TFI_tb);
    #10; // Espera 10 unidades de tiempo para iniciar la simulación
    // Simulación de la entrada de autos al estacionamiento
    a = 1; // Simula la activación del sensor 'a'
    b = 0; // Sensor 'b' inactivo
    #10; // Espera 10 unidades de tiempo
    a = 1; // Mantiene el sensor 'a' activo
    b = 1; // Activa el sensor 'b'
    #10; // Espera 10 unidades de tiempo
    a = 0; // Desactiva el sensor 'a'
    b = 1; // Mantiene el sensor 'b' activo
    #10; // Espera 10 unidades de tiempo
    a = 0; // Desactiva el sensor 'a'
    b = 0; // Desactiva el sensor 'b'
    #10; // Espera 10 unidades de tiempo

    $finish;
  end

endmodule