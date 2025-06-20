module contador_ascendente_descendente(
    input wire clk,
    input wire r,
    input wire s,
    output wire [2:0] leds
);

wire D2, D1, D0;
wire Q2, Q1, Q0;

// Lógica para las entradas D de los flip-flops tipo D
assign D2 = (~r & Q2) | (~s & Q2 & Q0) | (~s & Q2 & Q1) | (s & ~r & Q1 & Q0);
assign D1 = (~r & Q1 & ~Q0) | (~s & Q1 & Q0) | (~s & r & Q2 & ~Q1 & ~Q0) | 
            (s & ~r & ~Q1 & Q0) | (s & ~r & Q2 & Q0);
assign D0 = (~s & ~r & Q0) | (~s & r & Q1 & ~Q0) | (~s & r & Q2 & ~Q0) | 
            (s & ~r & Q2 & Q1) | (s & ~r & ~Q0);

FF_D ffd_2(.D(D2), .clk(clk), .Q(Q2), .Qn());
FF_D ffd_1(.D(D1), .clk(clk), .Q(Q1), .Qn());
FF_D ffd_0(.D(D0), .clk(clk), .Q(Q0), .Qn());     

assign leds = {Q2, Q1, Q0};


endmodule