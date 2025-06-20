module antirebote_temporal (
    input clk,                 // Reloj de 12 MHz
    input entrada,             // Señal del botón (ruidosa)
    output reg pulso_valido    // Pulso limpio si se cumple el tiempo
);

    parameter DEBOUNCE_TICKS = 20'd240_000; // 20 ms para 12 MHz (cantidad de ciclos para considerar válido)

    reg entrada_ant = 0;       // Guarda el valor anterior de la entrada para detectar flancos
    reg [19:0] tiempo = 0;     // Contador para medir el tiempo entre pulsos
    reg medir = 0;             // Indica si se debe contar el tiempo

    always @(posedge clk) begin // Bloque que se ejecuta en cada flanco de subida del reloj

        // Si estamos midiendo, incrementa el contador de tiempo (hasta el máximo posible)
        if (medir) begin
            if (tiempo < 20'hFFFFF)
                tiempo <= tiempo + 1;
        end

        // Detecta un flanco de bajada (cuando la entrada pasa de 1 a 0)
        if (entrada_ant == 1 && entrada == 0) begin
            // Si ha pasado suficiente tiempo desde el último pulso, es un pulso válido
            if (tiempo > DEBOUNCE_TICKS) begin
                pulso_valido <= 1;  // Pulso limpio: no fue rebote
            end else begin
                pulso_valido <= 0;  // Ignora el pulso: fue rebote
            end
            tiempo <= 0;    // Reinicia el contador de tiempo
            medir <= 1;     // Empieza a medir el tiempo para el siguiente pulso
        end else begin
            pulso_valido <= 0;  // El pulso válido dura solo un ciclo de reloj
        end

        entrada_ant <= entrada; // Actualiza el valor anterior de la entrada
    end

endmodule