module decoder(instr, clk, rest, op, rs, rt, rd, shamt, funct, imm, target, RegA, RegB, Imm,RegDst, RegWrite,Target);

	input clk;
	input rest;
	input [31:0] instr;

	output [5:0] op;
	output [4:0] rs;
	output [4:0] rt;
	output [4:0] rd;
	output [4:0] shamt;
	output [5:0] funct;
	output [15:0] imm;
	output [25:0] target;
	output [4:0] RegA, RegB;
	output [15:0] Imm;
	output [25:0] Target;
	output RegDst, RegWrite;

	reg [5:0] op;
	reg [4:0] rs;
	reg [4:0] rt;
	reg [4:0] rd;
	reg [4:0] shamt;
	reg [5:0] funct;
	reg [15:0] imm;
	reg [25:0] target;

	reg RegDst, RegWrite;
	reg [4:0] RegA, RegB;
	reg [15:0] Imm;
	reg [25:0] Target;

	always @ (instr)
	begin
		op = instr[31:26];
		rs = instr[25:21];
		rt = instr[20:16];
		rd = instr[15:11];
		shamt = instr[10:6];
		funct = instr[5:0];
		imm = instr[15:0];
		target = instr[25:0];

		case(op)
		// R
			6'b000000:
				begin
				rs = instr[25:21];
				rt = instr[20:16];
				rd = instr[15:11];
				shamt = instr[10:6];
				funct = instr[5:0];

				if (funct == 6'b100001) //add
					RegA = rs; RegB = rt; RegDst = 1; RegWrite = 1;
				if (funct == 6'b100000) // add.d
					RegA = rs; RegB = rt; RegDst = 1; RegWrite = 1;
				if (funct == 6'b100100) // and
					RegA = rs; RegB = rt; RegWrite = 1; RegDst = 1;
				if (funct == 6'b001101) // break
					RegA = 5'b00000; RegB = 5'b00000;
				if (funct == 6'b011010) // div
					RegA = rs; RegB = rt; RegWrite = 1; RegDst = 1;
				if (funct == 6'b011011) // divu
					RegA = rs; RegB = rt; RegWrite = 1; RegDst = 1;
				if (funct == 6'b001001) // jalr
					RegA = rs; RegB = 5'b00000; RegWrite = 1; RegDst = 1;
				if (funct == 6'b001000) // jr
					RegA = rs; RegB = 5'b00000; RegWrite = 1; RegDst = 1;
				if (funct == 6'b010000) // mfhi
					RegA = 5'b00000; RegB = 5'b00000; RegWrite = 1; RegDst = 1;
				if (funct == 6'b010010) // mflo
					RegA = 5'b00000; RegB = 5'b00000; RegWrite = 1; RegDst = 1;
				if (funct == 6'b010001) // mthi
					RegA = rs; RegB = 5'b00000; RegWrite = 1; RegDst = 1;
				if (funct == 6'b010011) // mtlo
					RegA = rs; RegB = 5'b00000; RegWrite = 1; RegDst = 1;
				if (funct == 6'b011000) // mult
					RegA = rs; RegB = rt; RegWrite = 1; RegDst = 1;
				if (funct == 6'b011000) // multu
					RegA = rs; RegB = rt; RegWrite = 1; RegDst = 1;
				if (funct == 6'b100111) // nor
					RegA = rs; RegB = rt; RegWrite = 1; RegDst = 1;
				if (funct == 6'b100101) // or
					RegA = rs; RegB = rt; RegWrite = 1; RegDst = 1;
				if (funct == 6'b000000) // sll
					RegA = 5'b00000; RegB = rt; RegWrite = 1; RegDst = 1;
				if (funct == 6'b000100) // sllv
					RegA = rt; RegB = rs; RegWrite = 1; RegDst = 1;
				if (funct == 6'b101010) // slt
					RegA = rs; RegB = rt; RegWrite = 1; RegDst = 1;
				if (funct == 6'b101011) // sltu
					RegA = rs; RegB = rt; RegWrite = 1; RegDst = 1;
				if (funct == 6'b000011) // sra
					RegA = 5'b00000; RegB = rt; RegWrite = 1; RegDst = 1;
				if (funct == 6'b000111) // srav
					RegA = rs; RegB = rt; RegWrite = 1; RegDst = 1;
				if (funct == 6'b000010) // srl
					RegA = 5'b00000; RegB = rt; RegWrite = 1; RegDst = 1;
				if (funct == 6'b000110) // srlv
					RegA = rt; RegB = rs; RegWrite = 1; RegDst = 1;
				if (funct == 6'b100010) // sub
					RegA = rs; RegB = rt; RegWrite = 1; RegDst = 1;
				if (funct == 6'b100011) // subu
					RegA = rs; RegB = rt; RegWrite = 1; RegDst = 1;
				if (funct == 6'b001100) // syscall
					RegA = 5'b00000; RegB = 5'b00000; RegWrite = 1; RegDst = 1;
				if (funct == 6'b100110) // xor
					RegA = rs; RegB = rt; RegWrite = 1; RegDst = 1;
			end
		//I
			6'b001000:  begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// addi
			6'b001001:  begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// addiu
			6'b001100:  begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// andi
			6'b000100:  begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 0; Imm = imm; end// beq

			6'b000001: begin RegA = rs; RegB = 5'b00001; RegDst = 0; RegWrite = 1; Imm = imm; end// bgez
			6'b000111: begin RegA = rs; RegB = 5'b00000; RegDst = 0; RegWrite = 1; Imm = imm; end // bgtz
			6'b000110: begin RegA = rs; RegB = 5'b00000; RegDst = 0; RegWrite = 1; Imm = imm; end// blez
			6'b000001: begin RegA = rs; RegB = 5'b00000; RegDst = 0; RegWrite = 1; Imm = imm; end// bltz

			6'b000101: begin RegA = rt; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// bne
			6'b100000: begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// lb
			6'b100100: begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// lbu
			6'b100001: begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// lh
			6'b100101: begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// lhu
			6'b001111: begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// lui
			6'b100011: begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// lw
			6'b110001: begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// lwcl
			6'b001101: begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// ori
			6'b101000: begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// sb
			6'b001010: begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// slti
			6'b001011: begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// sltiu
			6'b101001: begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// sh
			6'b101011: begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 0; Imm = imm; end// sw
			6'b111001: begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// swcl
			6'b001110: begin RegA = rs; RegB = rt; RegDst = 0; RegWrite = 1; Imm = imm; end// xori

		//J
			6'b000010: begin Target = target; RegDst = 0; RegWrite = 1; end// j
			6'b000011: begin Target = target; RegDst = 0; RegWrite = 1; end// jal

			default: begin RegA = 5'b00000; RegB = 5'b00000; Imm = 16'b0000000000000000; Target = 26'b00000000000000000000000000; end
		endcase
	end
endmodule
