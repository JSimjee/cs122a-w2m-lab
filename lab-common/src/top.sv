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


input wire result[4:0];
output logic new_seg7[7:0];
always_comb begin
    // Instantiate adder
    adder(val1, val2, result);
    decoder(result[3:0], new_seg7);
end

endmodule