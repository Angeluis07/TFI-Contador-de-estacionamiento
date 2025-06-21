// Contador ascendente y descendente de 3 bits con flip-flops tipo D
module contador_ascendente_descendente(
    input wire clk, // Reloj
    input wire r, // Entrada que representa la salida de un auto del estacionamiento
    input wire s, // Entrada que representa el ingreso de un auto al estacionamiento
    output wire [2:0] leds // Salida de 3 bits que indica el estado del contador
);

    // Entradas para los flip-flops tipo D
    wire D2, D1, D0;

    // Salidas de los flip-flops tipo D
    wire Q2, Q1, Q0;

    // Implementación de la lógica combinacional para las entradas D de los flip-flops
    assign D2 = (~r & Q2) | (~s & Q2 & Q0) | (~s & Q2 & Q1) | (s & ~r & Q1 & Q0);
    assign D1 = (~r & Q1 & ~Q0) | (~s & Q1 & Q0) | (~s & r & Q2 & ~Q1 & ~Q0) | 
                (s & ~r & ~Q1 & Q0) | (s & ~r & Q2 & Q0);
    assign D0 = (~s & ~r & Q0) | (~s & r & Q1 & ~Q0) | (~s & r & Q2 & ~Q0) | 
                (s & ~r & Q2 & Q1) | (s & ~r & ~Q0);

    // Instanciación de los flip-flops tipo D
    FF_D ffd_2(.D(D2), .clk(clk), .Q(Q2), .Qn());
    FF_D ffd_1(.D(D1), .clk(clk), .Q(Q1), .Qn());
    FF_D ffd_0(.D(D0), .clk(clk), .Q(Q0), .Qn());     

    // Asignación de las salidas del contador a el registro que representa los LEDs
    // que indican el estado del estacionamiento
    assign leds = {Q2, Q1, Q0};

endmodule