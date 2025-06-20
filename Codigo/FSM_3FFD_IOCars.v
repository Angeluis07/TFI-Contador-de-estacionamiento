
module FSM_3FFD_IOCars(
    input wire clk,
    input wire a, // Representa al primer par de sensores con respecto al ingreso del estacionamiento
    input wire b, // Representa al segundo par de sensores que se situarán despues de los A.
    output wire S, 
    output wire R, // Representa a la operacion de suma o resta.Si un auto entra se le da la orden para sumarlo, si un auto sale se lo resta.
    output wire Q2, // Salida del tercer flip-flop
    output wire Q1, // Salida del segundo flip-flop
    output wire Q0  // Salida del primer flip-flop
);
    wire D2, D1, D0; // Son las entradas a los 3 ff tipo D
  


    assign D2 = (b & Q2 & ~Q1) | (~a & b & ~Q1 & ~Q0) |
                (a & Q2 & Q1 & ~Q0) | (a & Q2 & ~Q1 & Q0);

    assign D1 = (b & ~Q2 & Q1) | (a & b & ~Q2 & Q0) |
                (a & ~b & Q2 & ~Q1 & Q0) | (a & ~b & Q2 & Q1 & ~Q0);

    assign D0 = (~a & b & ~Q2 & Q1) | (a & ~b & ~Q2 & ~Q1) | 
                (a & b & Q2 & ~Q1) | (a & ~b & ~Q2 & ~Q0) |
                (a & b & Q2 & ~Q0);
 
    /*
    assign D2 = (b & ~Q1 & (Q2 | (~a & Q0)))
                | (a & Q2 & (Q1 ^ Q0));

    assign D1 = (b & ~Q2 & (Q1 | (a & Q0)))
                | (a & ~b & Q2 & (Q1 ^ Q0));

    assign D0 = (~a & b & ~Q2 & Q1)
                | ((a & (~Q1 | ~Q0)) & (b ~^ Q2));
    */
    // Flip Flops tipo D
    FF_D ff2 (.D(D2), .clk(clk), .Q(Q2), .Qn());
    FF_D ff1 (.D(D1), .clk(clk), .Q(Q1), .Qn());
    FF_D ff0 (.D(D0), .clk(clk), .Q(Q0), .Qn());

    // Salidas de la FSM
    assign S = ~a & ~b & ~Q2 & Q1 & Q0;
    assign R = ~a & ~b & Q2 & Q1 & ~Q0;

endmodule