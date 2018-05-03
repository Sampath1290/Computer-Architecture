module decoder_tb;

   reg clk;
   reg reset;
   reg [31:0] instr;

   wire [5:0] op;
   wire [4:0] rs;
   wire [4:0] rt;
   wire [4:0] rd;
   wire [4:0] shamt;
   wire [5:0] funct;
   wire [15:0] imm;
   wire [25:0] target;
   wire [25:0] Target;
   wire [15:0] Imm;

   wire RegDst, RegWrite;
   wire [4:0] RegA, RegB;

   reg [31:0] TempInstr;
   reg [31:0] InstrArray [0:39];
   reg [8*7:0] NameArray [0:39];
   integer i;

   decoder u1(instr, clk, reset, op, rs, rt, rd, shamt, funct, imm, target, RegA, RegB, Imm, RegDst, RegWrite, Target);

   initial
   begin
   clk = 0;
   reset = 0;
   end

   always
   #5  clk =  ! clk;

   initial
   begin
   $display("         Step    Instr  Instr Hex               Instruction                           *********************************** Control line outputs ***********************************");

   InstrArray[0] = 32'h 3c011001; NameArray[0] = "lui";
   InstrArray[1] = 32'h 34280000; NameArray[1] = "ori";
   InstrArray[2] = 32'h 000d2820; NameArray[2] = "add";
   InstrArray[3] = 32'h 342c0040; NameArray[3] = "addu";
   InstrArray[4] = 32'h 8dad0010; NameArray[4] = "and";
   InstrArray[5] = 32'h 249a0001; NameArray[5] = "addiu";
   InstrArray[6] = 32'h 46241000; NameArray[6] = "add.d";
   InstrArray[7] = 32'h ad0a0000; NameArray[7] = "sw";
   InstrArray[8] = 32'h ad0a0004; NameArray[8] = "lw";
   InstrArray[9] = 32'h 21a9fffe; NameArray[9] = "addi";
   InstrArray[10] = 32'h 8d0b0003; NameArray[10] = "div";
   InstrArray[11] = 32'h 8d0c0004; NameArray[11] = "divu";
   InstrArray[12] = 32'h 016c5020; NameArray[12] = "add";
   InstrArray[13] = 32'h ad0a0008; NameArray[13] = "sw";
   InstrArray[14] = 32'h 21080004; NameArray[14] = "addi";
   InstrArray[15] = 32'h 2129ffff; NameArray[15] = "addi";
   InstrArray[16] = 32'h 1d20fff9; NameArray[16] = "bgtz";
   InstrArray[17] = 32'h 3c011001; NameArray[17] = "lui";
   InstrArray[18] = 32'h 34240000; NameArray[18] = "ori";
   InstrArray[19] = 32'h 3c011001; NameArray[19] = "lui";
   InstrArray[20] = 32'h 0c100010; NameArray[20] = "jal";
   InstrArray[21] = 32'h 2401000a; NameArray[21] = "addiu";
   InstrArray[22] = 32'h 0000000c; NameArray[22] = "syscall";
   InstrArray[23] = 32'h 00044020; NameArray[23] = "add";
   InstrArray[24] = 32'h 00054820; NameArray[24] = "add";
   InstrArray[25] = 32'h 3c010001; NameArray[25] = "lui";
   InstrArray[26] = 32'h 34250036; NameArray[26] = "ori";
   InstrArray[27] = 32'h 24021004; NameArray[27] = "addiu";
   InstrArray[28] = 32'h 0000000d; NameArray[28] = "syscall";
   InstrArray[29] = 32'h 8d040000; NameArray[29] = "lw";
   InstrArray[30] = 32'h 24020001; NameArray[30] = "addiu";
   InstrArray[31] = 32'h 0000000b; NameArray[31] = "syscall";
   InstrArray[32] = 32'h 3c011001; NameArray[32] = "lui";
   InstrArray[33] = 32'h 34240034; NameArray[33] = "ori";
   InstrArray[34] = 32'h 24020004; NameArray[34] = "addiu";
   InstrArray[35] = 32'h 0000000c; NameArray[35] = "syscall";
   InstrArray[36] = 32'h 21080004; NameArray[36] = "addi";
   InstrArray[37] = 32'h 2129ffff; NameArray[37] = "addi";
   InstrArray[38] = 32'h 1d20fff6; NameArray[38] = "bgtz";
   InstrArray[39] = 32'h 03e00008; NameArray[39] = "jr";
   end

   initial
   begin
   for(i=0; i<39; i=i+1) begin
   TempInstr = InstrArray[i];
   instr = TempInstr;
   #1;
   end
   end

   // initial $monitor("%d, %s:, %h, instr=%b, clk=%b, reset=%b, op=%b, rs=%b, rt=%b, rd=%b, shamt=%b, funct=%b, imm=%b, target=%b, RegA =%b, RegB=%b, Imm=%b, RegDst=%b, RegWrite=%b, Target=%b",
   // i, NameArray[i], InstrArray[i], instr, clk, reset, op, rs, rt, rd, shamt, funct, imm, target, RegA, RegB, Imm, RegDst, RegWrite, Target);

   initial $monitor("%d, %s:, %h, instr=%b, op=%b, rs=%b, rt=%b, rd=%b, shamt=%b, funct=%b, Imm=%b, RegDst=%b, RegWrite=%b, Target=%b",
   i, NameArray[i], InstrArray[i], instr, op, rs, rt, rd, shamt, funct, Imm, RegDst, RegWrite, Target);

   initial #50 $stop;

endmodule // decoder_tb
