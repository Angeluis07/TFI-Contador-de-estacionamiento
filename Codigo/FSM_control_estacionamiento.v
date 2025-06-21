// Módulo de una máquina de estados finitos (FSM) que controla la entrada y salida de autos en un estacionamiento.
module FSM_control_estacionamiento(
    input wire clk, // Reloj
    input wire a, // Entrada que representa al 1er sensor del estacionamiento
    input wire b, // Entrada que representa al 2do sensor del estacionamiento
    output wire S, // Salida que representa el ingreso de un auto al estacionamiento
    output wire R // Salida que represeta la salida de un auto del estacionamiento
    output wire Q2, // Salida del flip-flop tipo D 2
    output wire Q1, // Salida del flip-flop tipo D 1
    output wire Q0 // Salida del flip-flop tipo D 0
);
   
    // Entradas para los flip-flops tipo D
    wire D2, D1, D0;

     // Salidas de los flip-flops tipo D
    //wire Q2, Q1, Q0;

    // Implementación de la lógica combinacional para las entradas D de los flip-flops
    assign D2 = (b & Q2 & ~Q1) | (~a & b & ~Q1 & ~Q0) |
                (a & Q2 & Q1 & ~Q0) | (a & Q2 & ~Q1 & Q0);

    assign D1 = (b & ~Q2 & Q1) | (a & b & ~Q2 & Q0) |
                (a & ~b & Q2 & ~Q1 & Q0) | (a & ~b & Q2 & Q1 & ~Q0);

    assign D0 = (~a & b & ~Q2 & Q1) | (a & ~b & ~Q2 & ~Q1) | 
                (a & b & Q2 & ~Q1) | (a & ~b & ~Q2 & ~Q0) |
                (a & b & Q2 & ~Q0);
 
    // Instanciación de los flip-flops tipo D
    FF_D ff2 (.D(D2), .clk(clk), .Q(Q2), .Qn());
    FF_D ff1 (.D(D1), .clk(clk), .Q(Q1), .Qn());
    FF_D ff0 (.D(D0), .clk(clk), .Q(Q0), .Qn());

    // Asignación de las salidas S y R (ingreso y salida de autos)
    assign S = ~a & ~b & ~Q2 & Q1 & Q0;
    assign R = ~a & ~b & Q2 & Q1 & ~Q0;

endmodule