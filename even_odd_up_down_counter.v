`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2024 08:15:44
// Design Name: 
// Module Name: even_odd_up_down_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module even_odd_up_down_counter(clk,rst,mode,load,data_in,data_out);
input clk,rst,load,mode;
input [3:0]data_in;
output reg [3:0]data_out;
always @(posedge clk) begin
    if (rst) begin
        data_out <= 4'b0000;
    end
    else if (load) begin
        // Load the input value directly to data_out when load signal is active
        data_out <= data_in;
    end
    else if (mode) begin
        // Up count mode
        if (data_out[0] == 1'b0) // Checking LSB for even
            data_out <= data_out + 4'b0010; // Increment by 2 if even
        else
            data_out <= data_out + 4'b0001; // Make it even then increment by 2 next time
    end
    else begin
        // Down count mode
        if (data_out[0] == 1'b1) // Checking LSB for odd
            data_out <= data_out - 4'b0010; // Decrement by 2 if odd
        else if (data_out != 0) // Check to avoid underflow
            data_out <= data_out - 4'b0001; // Make it odd then decrement by 2 next time
    end
end

endmodule
