module debouncer( 
  input wire BTN,
  input wire clk,
  output wire BTN_estable
);

// Registros para almacenar los valores intermedios
reg btn_aux1 = 1'b0; 
reg btn_aux2 = 1'b0;

reg [16:0] contador = 0; // Contador para el tiempo de estabilización


always @(posedge clk) begin 

  if (btn_aux1 ^ BTN == 1'b1) 
    begin
      // Si hay un cambio en el botón, reiniciar el contador
      contador <= 0;
      btn_aux1 <= BTN; // Actualizar el primer registro auxiliar
    end
  else if (contador[16] == 1'b0)
    contador <= contador + 1; // Incrementar el contador si no hay cambio
  else
    btn_aux2 <= btn_aux1; // Si el contador ha llegado al final, actualizar la salida estable
end

assign BTN_estable = btn_aux2; // Asignar el valor del segundo registro auxiliar a la salida estable


endmodule