module adder (
  /** Input Ports */
  input wire [3:0] val1,
  input wire [3:0] val2,
  /** Output Ports */
  output logic [4:0] res // Five bits in case there's overflow (16-29), turn on decimal
);

/** Logic */
// Outside of an always block to repeatedly run, 
assign res = val1 + val2; // Thanks Hooman for telling me I can just use addition, instead of bit-wise addition and manually handling the carry bits and so on

endmodule