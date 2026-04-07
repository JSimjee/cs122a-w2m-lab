`include "src/decoder.sv"
`include "src/adder.sv"

module top (
    /** Input Ports */
    input wire [3:0] val1,
    input wire [3:0] val2,
    /** Output Ports */
    output logic [7:0] seg7 // To account for overflow
);

/*
Notes
Create a wire, assign that wire with your desired boolean logic, and assign that to your output logic
*/

/** Logic */
// Call the decoder and full adder
// Input val1/2 into the adder
// Take the adder's output, make that as input for the decoder
// Take the decoder's output, make that output for 'top'
// Remember to map bits correctly (e.g. seg7 in 'decoder' maps to seg7[6:0] in 'top'
//                                      , and res[4] in 'adder' maps to seg7[7] in 'top')


wire[4:0] result;
logic[4:0] adder_output;

// Instantiate so it exists in hardware
// We're building hardware
// We're assigning wires to outputs and inputs
// We're not creating a set of sequential instructions to run in sequence
// We're describing physical hardware, with wires and gates and abstractions called modules
adder my_adder(val1, val2, adder_output);
decoder my_decoder(adder_output[3:0], seg7[6:0]);

// assign [output] = [input]
assign seg7[7] = adder_output[4];
assign decoder_input = adder_output;

endmodule

// Jameel: Note: I used this forum post for help with learning verilog syntax, https://stackoverflow.com/questions/67513625/what-is-best-way-to-call-another-module