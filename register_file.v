// This module implements the register file


module register_file(
  clk,
  r1_addr,
  r1_data,
  r2_addr,
  r2_data,
  wr_addr,
  wr_data,
  reg_write
  );

  input clk;                            // input clock
  input [4:0]  r1_addr;                 // input read register A address
  input [4:0]  r2_addr;                 // input read register B address
  input [4:0]  wr_addr;                 // input write register address
  input [31:0] wr_data;                 // input write data
  input reg_write;                      // input RegWrite signal

  output [31:0] r1_data;                // output read register A data
  output [31:0] r2_data;                // output read register B data

  reg [31:0] reg_file [31:0];       // declaring 32 registers with size 32 bits

  assign r1_data = reg_file[r1_addr];   // assign data in A's address of
                                        // reg_file to output read register A
  assign r2_data = reg_file[r2_addr];   // assign data in B's address of
                                        // reg_file to output read register B

  integer i;

  initial begin    // begin initial block to initialise the registers to 0
    for(i = 0; i < 32; i = i+1) begin
      reg_file[i] = 0;
    end
  end

  // sets the write data whenever there is rising edge on clock and when
  // RegWrite signal is set
  always @(posedge clk) begin
    if (reg_write) begin
      reg_file[wr_addr] <= wr_data;
    end
  end

endmodule
