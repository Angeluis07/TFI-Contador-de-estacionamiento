// Descripción: Módulo para eliminar el rebote de un botón
module antirebote( 
  input wire BTN, // Entrada del botón que se desea estabilizar
  input wire clk, // Reloj del sistema
  output wire BTN_estable // Salida del botón estabilizado  
);

  // Registros para almacenar los valores intermedios
  reg btn_aux1 = 1'b0; // Guarda el valor más reciente del botón
  reg btn_aux2 = 1'b0; // Guarda el valor estabilizado del botón

  /*
  Este contador de 17 bits se utiliza para esperar cierto tiempo antes de considerar que 
  la señal del botón es estable. La idea es: si BTN no cambia durante un tiempo suficientemente 
  largo (por ejemplo, unos milisegundos), entonces se considera que el valor actual es confiable.
  */
  reg [16:0] contador = 0; // Contador para el tiempo de estabilización

  always @(posedge clk) begin 

    if (btn_aux1 ^ BTN == 1'b1) 
      begin
        // Si hay un cambio en el botón, reiniciar el contador
        contador <= 0;
        btn_aux1 <= BTN; // Actualizar al valor mas reciente del botón
      end
    else if (contador[16] == 1'b0) // Se espera que el bit más alto del contador (contador[16]) llegue a 1, lo cual indica que ha pasado suficiente tiempo sin cambios.
      contador <= contador + 1; // Incrementar el contador si no hay cambio
    else
      btn_aux2 <= btn_aux1; // Si el contador ha llegado al final, actualizar la salida estable

  end

  assign BTN_estable = btn_aux2; // Asignar el valor del segundo registro auxiliar a la salida estable

endmodule