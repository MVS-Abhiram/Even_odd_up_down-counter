`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2024 09:13:37
// Design Name: 
// Module Name: even_odd_up_down_counter_tb
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


module even_odd_up_down_counter_tb;

    // Testbench signals
    reg clk, rst, load, mode;
    reg [3:0] data_in;
    wire [3:0] data_out;

    // Instantiate the Device Under Test (DUT)
    even_odd_up_down_counter DUT (
        .clk(clk),
        .rst(rst),
        .load(load),
        .mode(mode),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk; // 100MHz clock

    // Task for applying reset
    task apply_reset;
        begin
            rst = 1;
            #10; // Wait for reset to propagate
            rst = 0;
        end
    endtask

    // Task for loading a value
    task load_value(input [3:0] value);
        begin
            load = 1;
            data_in = value;
            #10; // Apply load for a short period
            load = 0;
        end
    endtask

    // Task for changing mode
    task change_mode(input new_mode);
        begin
            mode = new_mode;
            #10; // Allow some time for mode to take effect
        end
    endtask

    // Initial block to run the test sequences
    initial begin
        // Initialize
        clk = 0;
        rst = 0;
        load = 0;
        mode = 0; // Start with down count mode
        data_in = 0;

        // Apply reset
        apply_reset();

        // Load initial value and test up count
        load_value(4'b0011); // Load 3, which is odd
        change_mode(1); // Change to up count mode
        #100; // Wait for some clock cycles

        // Change to down count mode and observe
        change_mode(0); // Change to down count mode
        #100; // Wait for some clock cycles

        // Reset and check behavior from a known state
        apply_reset();
        load_value(4'b0100); // Load 4, which is even
        #100; // Observe up count mode for a while

        // Complete the simulation
        $finish;
    end

    // Optional: Monitor for changes in output
    initial begin
        $monitor("Time = %t, mode = %b, data_out = %b", $time, mode, data_out);
    end

endmodule
