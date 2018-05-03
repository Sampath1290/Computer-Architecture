
module multiplexer(
  input1,
  input2,
  select,
  out
  );

  input [4:0] input1, input2;
  input select;
  output [4:0] out;

  always @ ( input1 or input2 or select ) begin
      out = select ? input2 or input1;
  end

endmodule
