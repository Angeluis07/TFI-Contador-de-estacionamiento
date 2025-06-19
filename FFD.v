//caso FF tipo D sin set ni reset
module FF_D(
    input wire D,
    input wire clk,
    output reg Q = 0,
    output wire Qn
);
    always @(posedge clk) begin
        Q <= D;
    end
    assign Qn = ~Q;
endmodule