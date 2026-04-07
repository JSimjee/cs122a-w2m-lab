`timescale 1ns / 1ps
// I guess this isn't necessary?

`include "src/top.sv"
`default_nettype none

module top_tb; // No port list required because we're not synthesizing a testbench to actual hardware

/*
Notes after talking with Marios
1. You don't need to specify input and output for intermediate wires (like the output from the adder to the input of the decoder, "How can you specify input or output when it's both?" - Marios)
2. You can have two separate "initial begin" statements as long as they don't conflict with each other
*/

// Registers as input
logic[3:0] NUM1;
logic[3:0] NUM2;
// Wires as output
wire[7:0] SEG7;
top UUT (.val1(NUM1), .val2(NUM2), .seg7(SEG7));

// Keep track of if all tests pass
// boolean passed_all_tests;
integer tests_passed;

localparam CLK_PERIOD = 1;
// always #(CLK_PERIOD/2) clk=~clk;

// Note: Marios says 
initial begin
    $dumpfile("build/top.vcd"); // Output to vcd file for GTKWave
    $dumpvars(0, top_tb); // Meant to be opened in vvp to run testbench after compiling with iverilog
end

// 1D7S is ABCDEFGdp
// Test cases
task test00();
    begin
        NUM1 = 4'd0;
        NUM2 = 4'd0;
        #5; // Wait for 5 time units
        tests_passed += (SEG7 == 8'b01111110);
    end
endtask

task test01();
    begin
        NUM1 = 4'd15;
        NUM2 = 4'd15;
        #5; // Wait for 5 time units
        tests_passed += (SEG7 == 8'b11110011);
    end
endtask

task test02();
    begin
        NUM1 = 4'd15;
        NUM2 = 4'd0;
        #5; // Wait for 5 time units
        tests_passed += (SEG7 == 8'b11100010);
    end
endtask

task test03();
    begin
        NUM1 = 4'd13;
        NUM2 = 4'd7;
        #5; // Wait for 5 time units
        tests_passed += (SEG7 == 8'b11001101);
    end
endtask


initial begin
    // // clk<=1'b1;
    // // #(CLK_PERIOD*3);
    // // testbench logic goes below
    // test00(); #(CLK_PERIOD*3);
    
    // Initialize variable
    NUM1 = 4'b0000;
    NUM2 = 4'b0000;
    tests_passed = 0;

    test00(); #(CLK_PERIOD*3);
    test01(); #(CLK_PERIOD*3);
    test02(); #(CLK_PERIOD*3);
    test03(); #(CLK_PERIOD*3);
    
    $display("Passed: ", tests_passed);

    $finish;
end

endmodule
// `default_nettype wire