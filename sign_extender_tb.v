

module test_sign_extend;

  reg [15:0] in;
  wire [31:0] out;

  sign_extender DUT(in, out);

  initial begin
    #1 in = 16'h 7fff;
    #1 in = 16'h 8fff;
    #1 in = 16'h 7001;
    #1 in = 16'h 7121;
    #1 in = 16'h 800f;
  end

  initial $monitor($time, " in=%h in=%b out=%b",
    in, in, out);
  initial #20 $stop;

endmodule
