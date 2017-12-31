//
// RiSC-16 skeleton
//

`define ADD	3'd0
`define ADDI	3'd1
`define NAND	3'd2
`define LUI	3'd3
`define SW	3'd4
`define LW	3'd5
`define BNE	3'd6
`define JALR	3'd7
`define EXTEND	3'd7

`define INSTRUCTION_OP	15:13	// opcode
`define INSTRUCTION_RA	12:10	// rA
`define INSTRUCTION_RB	9:7	// rB
`define INSTRUCTION_RC	2:0	// rC
`define INSTRUCTION_IM	6:0	// immediate (7-bit)
`define INSTRUCTION_LI	9:0	// large unsigned immediate (10-bit, 0-extended)
`define INSTRUCTION_SB	6	// immediate's sign bit

`define ZERO		16'd0

`define HALTINSTRUCTION	{ `EXTEND, 3'd0, 3'd0, 3'd7, 4'd1 }


module not_equivalent (alu1, alu2, out);
	input	[15:0]	alu1;
	input	[15:0]	alu2;
	output		out;

	assign	out = (((((alu1[0] ^ alu2[0]) |
			(alu1[1] ^ alu2[1])) |
			((alu1[2] ^ alu2[2]) |
			(alu1[3] ^ alu2[3]))) |
			(((alu1[4] ^ alu2[4]) |
			(alu1[5] ^ alu2[5])) |
			((alu1[6] ^ alu2[6]) |
			(alu1[7] ^ alu2[7])))) |
			((((alu1[8] ^ alu2[8]) |
			(alu1[9] ^ alu2[9])) |
			((alu1[10] ^ alu2[10]) |
			(alu1[11] ^ alu2[11]))) |
			(((alu1[12] ^ alu2[12]) |
			(alu1[13] ^ alu2[13])) |
			((alu1[14] ^ alu2[14]) |
			(alu1[15] ^ alu2[15])))));
endmodule

module arithmetic_logic_unit (op, alu1, alu2, bus);
	input	[2:0]	op;
	input	[15:0]	alu1;
	input	[15:0]	alu2;
	output	[15:0]	bus;

	assign bus =	(op == `ADD) ? alu1 + alu2 :
			(op == `NAND) ? ~(alu1 & alu2) :
			alu2;
endmodule




module IFID	(clk, reset, IFID_we, IFID_instr__in, IFID_pc__in,
		IFID_instr__out, IFID_pc__out);

	input		clk, reset, IFID_we;
	input	[15:0]	IFID_instr__in, IFID_pc__in;
	output	[15:0]	IFID_instr__out, IFID_pc__out;

	wire	clk_A, clk_B, clk_C, clk_D, clk_E, clk_F, clk_G, clk_H,
		res_A, res_B, res_C, res_D, res_E, res_F, res_G, res_H;

	buf	cA(clk_A, clk), cB(clk_B, clk), cC(clk_C, clk), cD(clk_D, clk),
		cE(clk_E, clk), cF(clk_F, clk), cG(clk_G, clk), cH(clk_H, clk),
		rA(res_A, reset), rB(res_B, reset), rC(res_C, reset), rD(res_D, reset),
		rE(res_E, reset), rF(res_F, reset), rG(res_G, reset), rH(res_H, reset);

	registerX #(16)		IFID_instr (.reset(res_A), .clk(clk_A), .out(IFID_instr__out), .in(IFID_instr__in), .we(IFID_we));
	registerX #(16)		IFID_pc (.reset(res_B), .clk(clk_B), .out(IFID_pc__out), .in(IFID_pc__in), .we(IFID_we));

endmodule


module IDEX	(clk, reset, IDEX_op0__in, IDEX_op1__in, IDEX_op2__in, IDEX_op__in, IDEX_rT__in, IDEX_x__in, IDEX_pc__in,
		IDEX_op0__out, IDEX_op1__out, IDEX_op2__out, IDEX_op__out, IDEX_rT__out, IDEX_x__out, IDEX_pc__out);

	input		clk, reset;
	input	[15:0]	IDEX_op0__in, IDEX_op1__in, IDEX_op2__in;
	input	[2:0]	IDEX_op__in;
	input	[2:0]	IDEX_rT__in;
	output	[15:0]	IDEX_op0__out, IDEX_op1__out, IDEX_op2__out;
	output	[2:0]	IDEX_op__out;
	input	[2:0]	IDEX_rT__out;
	input	[15:0]	IDEX_pc__in;
	input		IDEX_x__in;
	output	[15:0]	IDEX_pc__out;
	output		IDEX_x__out;

	wire	clk_A, clk_B, clk_C, clk_D, clk_E, clk_F, clk_G, clk_H,
		res_A, res_B, res_C, res_D, res_E, res_F, res_G, res_H;

	buf	cA(clk_A, clk), cB(clk_B, clk), cC(clk_C, clk), cD(clk_D, clk),
		cE(clk_E, clk), cF(clk_F, clk), cG(clk_G, clk), cH(clk_H, clk),
		rA(res_A, reset), rB(res_B, reset), rC(res_C, reset), rD(res_D, reset),
		rE(res_E, reset), rF(res_F, reset), rG(res_G, reset), rH(res_H, reset);

	registerX #(16)		IDEX_op0 (.reset(res_A), .clk(clk_A), .out(IDEX_op0__out), .in(IDEX_op0__in), .we(1'd1));
	registerX #(16)		IDEX_op1 (.reset(res_B), .clk(clk_B), .out(IDEX_op1__out), .in(IDEX_op1__in), .we(1'd1));
	registerX #(16)		IDEX_op2 (.reset(res_C), .clk(clk_C), .out(IDEX_op2__out), .in(IDEX_op2__in), .we(1'd1));
	registerX #(3)		IDEX_op (.reset(res_D), .clk(clk_D), .out(IDEX_op__out), .in(IDEX_op__in), .we(1'd1));
	registerX #(3)		IDEX_rT (.reset(res_E), .clk(clk_E), .out(IDEX_rT__out), .in(IDEX_rT__in), .we(1'd1));
	registerX #(1)		IDEX_x (.reset(res_F), .clk(clk_F), .out(IDEX_x__out), .in(IDEX_x__in), .we(1'd1));
	registerX #(16)		IDEX_pc (.reset(res_G), .clk(clk_G), .out(IDEX_pc__out), .in(IDEX_pc__in), .we(1'd1));

endmodule


module EXMEM	(clk, reset, EXMEM_stdata__in, EXMEM_ALUout__in, EXMEM_op__in, EXMEM_rT__in, EXMEM_x__in, EXMEM_pc__in,
		EXMEM_stdata__out, EXMEM_ALUout__out, EXMEM_op__out, EXMEM_rT__out, EXMEM_x__out, EXMEM_pc__out);

	input		clk, reset;
	input	[15:0]	EXMEM_stdata__in, EXMEM_ALUout__in;
	input	[2:0]	EXMEM_op__in;
	input	[2:0]	EXMEM_rT__in;
	output	[15:0]	EXMEM_stdata__out, EXMEM_ALUout__out;
	output	[2:0]	EXMEM_op__out;
	input	[2:0]	EXMEM_rT__out;
	input	[15:0]	EXMEM_pc__in;
	input		EXMEM_x__in;
	output	[15:0]	EXMEM_pc__out;
	output		EXMEM_x__out;

	wire	clk_A, clk_B, clk_C, clk_D, clk_E, clk_F, clk_G, clk_H,
		res_A, res_B, res_C, res_D, res_E, res_F, res_G, res_H;

	buf	cA(clk_A, clk), cB(clk_B, clk), cC(clk_C, clk), cD(clk_D, clk),
		cE(clk_E, clk), cF(clk_F, clk), cG(clk_G, clk), cH(clk_H, clk),
		rA(res_A, reset), rB(res_B, reset), rC(res_C, reset), rD(res_D, reset),
		rE(res_E, reset), rF(res_F, reset), rG(res_G, reset), rH(res_H, reset);

	registerX #(16)		EXMEM_stdata (.reset(res_A), .clk(clk_A), .out(EXMEM_stdata__out), .in(EXMEM_stdata__in), .we(1'd1));
	registerX #(16)		EXMEM_ALUout (.reset(res_B), .clk(clk_B), .out(EXMEM_ALUout__out), .in(EXMEM_ALUout__in), .we(1'd1));
	registerX #(3)		EXMEM_op (.reset(res_C), .clk(clk_C), .out(EXMEM_op__out), .in(EXMEM_op__in), .we(1'd1));
	registerX #(3)		EXMEM_rT (.reset(res_D), .clk(clk_D), .out(EXMEM_rT__out), .in(EXMEM_rT__in), .we(1'd1));
	registerX #(1)		EXMEM_x (.reset(res_E), .clk(clk_E), .out(EXMEM_x__out), .in(EXMEM_x__in), .we(1'd1));
	registerX #(16)		EXMEM_pc (.reset(res_F), .clk(clk_F), .out(EXMEM_pc__out), .in(EXMEM_pc__in), .we(1'd1));

endmodule


module MEMWB	(clk, reset, MEMWB_rfdata__in, MEMWB_rT__in, MEMWB_x__in, MEMWB_pc__in,
		MEMWB_rfdata__out, MEMWB_rT__out, MEMWB_x__out, MEMWB_pc__out);

	input		clk, reset;
	input	[15:0]	MEMWB_rfdata__in;
	input	[2:0]	MEMWB_rT__in;
	output	[15:0]	MEMWB_rfdata__out;
	output	[2:0]	MEMWB_rT__out;
	input	[15:0]	MEMWB_pc__in;
	input		MEMWB_x__in;
	output	[15:0]	MEMWB_pc__out;
	output		MEMWB_x__out;

	wire	clk_A, clk_B, clk_C, clk_D, clk_E, clk_F, clk_G, clk_H,
		res_A, res_B, res_C, res_D, res_E, res_F, res_G, res_H;

	buf	cA(clk_A, clk), cB(clk_B, clk), cC(clk_C, clk), cD(clk_D, clk),
		cE(clk_E, clk), cF(clk_F, clk), cG(clk_G, clk), cH(clk_H, clk),
		rA(res_A, reset), rB(res_B, reset), rC(res_C, reset), rD(res_D, reset),
		rE(res_E, reset), rF(res_F, reset), rG(res_G, reset), rH(res_H, reset);

	registerX #(16)		MEMWB_rfdata (.reset(res_A), .clk(clk_A), .out(MEMWB_rfdata__out), .in(MEMWB_rfdata__in), .we(1'd1));
	registerX #(3)		MEMWB_rT (.reset(res_B), .clk(clk_B), .out(MEMWB_rT__out), .in(MEMWB_rT__in), .we(1'd1));
	registerX #(1)		MEMWB_x (.reset(res_C), .clk(clk_C), .out(MEMWB_x__out), .in(MEMWB_x__in), .we(1'd1));
	registerX #(16)		MEMWB_pc (.reset(res_D), .clk(clk_D), .out(MEMWB_pc__out), .in(MEMWB_pc__in), .we(1'd1));

endmodule






module RiSC (clk, reset);
	input	clk;
	input	reset;

    // First Pipeline Wires

	// clock tree, reset tree
	wire	clk_A, clk_B, clk_C, clk_D, clk_E, clk_F, clk_G, clk_H,
		res_A, res_B, res_C, res_D, res_E, res_F, res_G, res_H;

	buf	cA(clk_A, clk), cB(clk_B, clk), cC(clk_C, clk), cD(clk_D, clk),
		cE(clk_E, clk), cF(clk_F, clk), cG(clk_G, clk), cH(clk_H, clk),
		rA(res_A, reset), rB(res_B, reset), rC(res_C, reset), rD(res_D, reset),
		rE(res_E, reset), rF(res_F, reset), rG(res_G, reset), rH(res_H, reset);



	wire	[15:0]	PC__out_0;

	wire	[15:0]	IFID_instr__out_0;
	wire	[15:0]	IFID_pc__out_0;

	wire	[15:0]	IDEX_op0__out_0;
	wire	[15:0]	IDEX_op1__out_0;
	wire	[15:0]	IDEX_op2__out_0;
	wire	[2:0]	IDEX_op__out_0;
	wire	[2:0]	IDEX_rT__out_0;
	wire		IDEX_x__out;
	wire	[15:0]	IDEX_pc__out_0;

	wire	[15:0]	EXMEM_stdata__out_0;
	wire	[15:0]	EXMEM_ALUout__out_0;
	wire	[2:0]	EXMEM_op__out_0;
	wire	[2:0]	EXMEM_rT__out_0;
	wire		EXMEM_x__out_0;
	wire	[15:0]	EXMEM_pc__out_0;

	wire	[15:0]	MEMWB_rfdata__out_0;
	wire	[2:0]	MEMWB_rT__out_0;
	wire		MEMWB_x__out_0;
	wire	[15:0]	MEMWB_pc__out_0;



	wire	[15:0]	PC__in_0;

	wire	[15:0]	IFID_instr__in_0;
	wire	[15:0]	IFID_pc__in_0;

	wire	[15:0]	IDEX_op0__in_0;
	wire	[15:0]	IDEX_op1__in_0;
	wire	[15:0]	IDEX_op2__in_0;
	wire	[2:0]	IDEX_op__in_0;
	wire	[2:0]	IDEX_rT__in_0;
	wire		IDEX_x__in_0;
	wire	[15:0]	IDEX_pc__in_0;

	wire	[15:0]	EXMEM_stdata__in_0;
	wire	[15:0]	EXMEM_ALUout__in_0;
	wire	[2:0]	EXMEM_op__in_0;
	wire	[2:0]	EXMEM_rT__in_0;
	wire		EXMEM_x__in_0;
	wire	[15:0]	EXMEM_pc__in_0;

	wire	[15:0]	MEMWB_rfdata__in_0;
	wire	[2:0]	MEMWB_rT__in_0;
	wire		MEMWB_x__in_0;
	wire	[15:0]	MEMWB_pc__in_0;




	wire	[2:0]	IFID_op_0 = IFID_instr__out_0[ `INSTRUCTION_OP ];
	wire	[2:0]	IFID_rA_0 = IFID_instr__out_0[ `INSTRUCTION_RA ];
	wire	[2:0]	IFID_rB_0 = IFID_instr__out_0[ `INSTRUCTION_RB ];
	wire	[2:0]	IFID_rC_0 = IFID_instr__out_0[ `INSTRUCTION_RC ];
	wire	[6:0]	IFID_im_0 = IFID_instr__out_0[ `INSTRUCTION_IM ];
	wire		IFID_sb_0 = IFID_instr__out_0[ `INSTRUCTION_SB ];

	wire	[15:0]	IFID_simm_0 = { {9{IFID_sb_0}}, IFID_im_0 };
	wire	[15:0]	IFID_uimm_0 = { IFID_instr__out_0[ `INSTRUCTION_LI ], 6'd0 };


	wire	[15:0]	PC__out_plus1_0 = PC__out_0+1;				// dedicated adder
	wire	[15:0]	PC__out_plus2_0 = PC__out_0+2;				// dedicated adder
	wire	[15:0]	IFID_pc_plus1_0 = IFID_pc__out_0+2;				// dedicated adder
	wire	[15:0]	IFID_pc_plus_signext_plus1_0 = IFID_pc_plus1_0+IFID_simm_0;	// dedicated adder



	wire		PC_we_0;
	wire		IFID_we_0;

	wire	[15:0]	MUXpc_out_0;
	wire	[2:0]	MUXs2_out_0;
	wire		Pstall_0;
	wire		Pstomp_0;
	wire	[15:0]	MUXimm_out_0;
	wire	[15:0]	MUXop2_out_0;
	wire	[15:0]	MUXop1_out_0;
	wire	[15:0]	MUXalu2_out_0;

	wire	[2:0]	FUNCalu_0 = ((IDEX_op__out_0 == `ADDI) || (IDEX_op__out_0 == `SW) || (IDEX_op__out_0 == `LW))
				? `ADD
				: IDEX_op__out_0;

	wire		WEdmem_0;
	wire	[15:0]	MUXout_out_0;

	wire	[15:0]	ALU_out_0;

	wire	[15:0]	RF__out1_0;
	wire	[2:0]	RF__src1_0;
	wire	[15:0]	RF__out2_0;
	wire	[2:0]	RF__src2_0;
	wire	[15:0]	RF__in_0;
	wire	[2:0]	RF__tgt_0;
	wire	[15:0]	MEM__data1_0;
	wire	[15:0]	MEM__addr1_0;
	wire	[15:0]	MEM__data2out_0;
	wire	[15:0]	MEM__addr2_0;


    // Second Pipeline Wires

    wire	[15:0]	PC__out_1;

	wire	[15:0]	IFID_instr__out_1;
	wire	[15:0]	IFID_pc__out_1;

	wire	[15:0]	IDEX_op0__out_1;
	wire	[15:0]	IDEX_op1__out_1;
	wire	[15:0]	IDEX_op2__out_1;
	wire	[2:0]	IDEX_op__out_1;
	wire	[2:0]	IDEX_rT__out_1;
	wire		IDEX_x__out_1;
	wire	[15:0]	IDEX_pc__out_1;

	wire	[15:0]	EXMEM_stdata__out_1;
	wire	[15:0]	EXMEM_ALUout__out_1;
	wire	[2:0]	EXMEM_op__out_1;
	wire	[2:0]	EXMEM_rT__out_1;
	wire		EXMEM_x__out_1;
	wire	[15:0]	EXMEM_pc__out_1;

	wire	[15:0]	MEMWB_rfdata__out_1;
	wire	[2:0]	MEMWB_rT__out_1;
	wire		MEMWB_x__out_1;
	wire	[15:0]	MEMWB_pc__out_1;



	wire	[15:0]	PC__in_1;

	wire	[15:0]	IFID_instr__in_1;
	wire	[15:0]	IFID_pc__in_1;

	wire	[15:0]	IDEX_op0__in_1;
	wire	[15:0]	IDEX_op1__in_1;
	wire	[15:0]	IDEX_op2__in_1;
	wire	[2:0]	IDEX_op__in_1;
	wire	[2:0]	IDEX_rT__in_1;
	wire		IDEX_x__in_1;
	wire	[15:0]	IDEX_pc__in_1;

	wire	[15:0]	EXMEM_stdata__in_1;
	wire	[15:0]	EXMEM_ALUout__in_1;
	wire	[2:0]	EXMEM_op__in_1;
	wire	[2:0]	EXMEM_rT__in_1;
	wire		EXMEM_x__in_1;
	wire	[15:0]	EXMEM_pc__in_1;

	wire	[15:0]	MEMWB_rfdata__in_1;
	wire	[2:0]	MEMWB_rT__in_1;
	wire		MEMWB_x__in_1;
	wire	[15:0]	MEMWB_pc__in_1;




	wire	[2:0]	IFID_op_1 = IFID_instr__out_1[ `INSTRUCTION_OP ];
	wire	[2:0]	IFID_rA_1 = IFID_instr__out_1[ `INSTRUCTION_RA ];
	wire	[2:0]	IFID_rB_1 = IFID_instr__out_1[ `INSTRUCTION_RB ];
	wire	[2:0]	IFID_rC_1 = IFID_instr__out_1[ `INSTRUCTION_RC ];
	wire	[6:0]	IFID_im_1 = IFID_instr__out_1[ `INSTRUCTION_IM ];
	wire		IFID_sb_1 = IFID_instr__out_1[ `INSTRUCTION_SB ];

	wire	[15:0]	IFID_simm_1 = { {9{IFID_sb_1}}, IFID_im_1 };
	wire	[15:0]	IFID_uimm_1 = { IFID_instr__out_1[ `INSTRUCTION_LI ], 6'd0 };


	wire	[15:0]	PC__out_plus1_1 = PC__out_1+1;				// dedicated adder
	wire	[15:0]	PC__out_plus2_1 = PC__out_1+2;				// dedicated adder
	wire	[15:0]	IFID_pc_plus1_1 = IFID_pc__out_1+2;				// dedicated adder
	wire	[15:0]	IFID_pc_plus_signext_plus1_1 = IFID_pc_plus1_1+IFID_simm_1;	// dedicated adder



	wire		PC_we_1;
	wire		IFID_we_1;

	wire	[15:0]	MUXpc_out_1;
	wire	[2:0]	MUXs2_out_1;
	wire		Pstall_1;
	wire		Pstomp_1;
	wire	[15:0]	MUXimm_out_1;
	wire	[15:0]	MUXop2_out_1;
	wire	[15:0]	MUXop1_out_1;
	wire	[15:0]	MUXalu2_out_1;

	wire	[2:0]	FUNCalu_1 = ((IDEX_op__out_1 == `ADDI) || (IDEX_op__out_1 == `SW) || (IDEX_op__out_1 == `LW))
				? `ADD
				: IDEX_op__out_1;

	wire		WEdmem_1;
	wire	[15:0]	MUXout_out_1;

	wire	[15:0]	ALU_out_1;

	wire	[15:0]	RF__out1_1;
	wire	[2:0]	RF__src1_1;
	wire	[15:0]	RF__out2_1;
	wire	[2:0]	RF__src2_1;
	wire	[15:0]	RF__in_1;
	wire	[2:0]	RF__tgt_1;
	wire	[15:0]	MEM__data1_1;
	wire	[15:0]	MEM__addr1_1;
	wire	[15:0]	MEM__data2out_1;
	wire	[15:0]	MEM__addr2_1;

    // STAGGER SIGNAL
    wire Pswitch;


	//
	// PC UPDATE 0
	//
	wire		not_equal_0;
	wire		ifid_is_bne_0 = (IFID_op_0 == `BNE);
	wire		ifid_is_jalr_0 = (IFID_op_0 == `JALR && IFID_im_0 == 7'd0);
	wire		takenBranch_0 = (ifid_is_bne_0 & not_equal_0);

	registerX #(16)		PC_0 (.reset(res_A), .clk(clk_A), .out(PC__out_0), .in(PC__in_0), .we(PC_we_0));
	not_equivalent		NEQ_0 (.alu1(MUXop1_out_0), .alu2(MUXop2_out_0), .out(not_equal_0));


	assign 	MUXpc_out_0 = PC__out_plus2_0;
	assign 	PC__in_0 = MUXpc_out_0;
	assign	PC_we_0 = ~Pstall_0 && ~Pstomp_0;

    //
    // PC UPDATE 1
    //

    wire		not_equal_1;
	wire		ifid_is_bne_1 = (IFID_op_1 == `BNE);
	wire		ifid_is_jalr_1 = (IFID_op_1 == `JALR && IFID_im_1 == 7'd0);
	wire		takenBranch_1 = (ifid_is_bne_1 & not_equal_1);

	registerY #(16)		PC_1 (.reset(res_A), .clk(clk_A), .out(PC__out_1), .in(PC__in_1), .we(PC_we_1));
	not_equivalent		NEQ_1 (.alu1(MUXop1_out_1), .alu2(MUXop2_out_1), .out(not_equal_1));


	assign 	MUXpc_out_1 = PC__out_plus2_1;
	assign 	PC__in_1 = MUXpc_out_1;
	assign	PC_we_1 = ~Pstall_1 && ~Pstomp_1;






	//
	// FETCH STAGE 0
	//

	IFID	ifid_reg_0 (.reset(res_B), .clk(clk_B), .IFID_instr__in(IFID_instr__in_0), .IFID_pc__in(IFID_pc__in_0),
			.IFID_we(IFID_we_0), .IFID_instr__out(IFID_instr__out_0), .IFID_pc__out(IFID_pc__out_0));


	assign	MEM__addr1_0 = PC__out_0;
	assign	IFID_instr__in_0 = (Pstomp_0) ? `ZERO : MEM__data1_0;
	assign	IFID_pc__in_0 = PC__out_0;
	assign	IFID_we_0 = ~Pstall_0;

    //
    // FETCH STAGE 1
    //

	IFID	ifid_reg_1 (.reset(res_B), .clk(clk_B), .IFID_instr__in(IFID_instr__in_1), .IFID_pc__in(IFID_pc__in_1),
			.IFID_we(IFID_we_1), .IFID_instr__out(IFID_instr__out_1), .IFID_pc__out(IFID_pc__out_1));


	assign	MEM__addr1_1 = PC__out_1;
	assign	IFID_instr__in_1 = (Pstomp_1) ? `ZERO : MEM__data1_1;
	assign	IFID_pc__in_1 = PC__out_1;
	assign	IFID_we_1 = ~Pstall_1;




	//
	// DECODE STAGE 0
	//
	wire		s1nonzero_0 = (RF__src1_0[2:0] != 3'd0);
	wire		s2nonzero_0 = (RF__src2_0[2:0] != 3'd0);
	wire		ifid_is_addORnand_0 = (IFID_op_0 == `ADD) | (IFID_op_0 == `NAND);
	wire		idex_is_lw_0 = (IDEX_op__out_0 == `LW);
	wire		ifid_is_lui_0 = (IFID_op_0 == `LUI);
	wire		ifid_uses_simm_0 = (IFID_op_0 == `ADDI) | (IFID_op_0 == `LW) | (IFID_op_0 == `SW);
	wire		ifid_writesRF_0 =	(~IFID_op_0[2] | IFID_op_0[0]);


        three_port_aregfile     RF (.on(res_C), .clk(clk_C), .abus1_0(RF__src1_0), .abus1_1(RF__src1_1), .dbus1_0(RF__out1_0), .dbus1_1(RF__out1_1), .abus2_0(RF__src2_0), .abus2_1(RF__src2_1), .dbus2_0(RF__out2_0), .dbus2_1(RF__out2_1), .abus3_0(RF__tgt_0), .abus3_1(RF__tgt_1), .dbus3_0(RF__in_0), .dbus3_1(RF__in_1));

	IDEX	idex_reg_0(.reset(res_D), .clk(clk_D), .IDEX_op0__in(IDEX_op0__in_0), .IDEX_op1__in(IDEX_op1__in_0),
			.IDEX_op2__in(IDEX_op2__in_0), .IDEX_op__in(IDEX_op__in_0), .IDEX_rT__in(IDEX_rT__in_0),
			.IDEX_pc__in(IDEX_pc__in_0), .IDEX_x__in(IDEX_x__in_0),
			.IDEX_pc__out(IDEX_pc__out_0), .IDEX_x__out(IDEX_x__out_0),
			.IDEX_op0__out(IDEX_op0__out_0), .IDEX_op1__out(IDEX_op1__out_0), .IDEX_op2__out(IDEX_op2__out_0),
			.IDEX_op__out(IDEX_op__out_0), .IDEX_rT__out(IDEX_rT__out_0));


	wire	[15:0]	idex_targets_src1_0 = ALU_out_0;
	wire	[15:0]	idex_targets_src2_0 = ALU_out_0;
	wire	[15:0]	exmem_targets_src1_0 = MUXout_out_0;
	wire	[15:0]	exmem_targets_src2_0 = MUXout_out_0;
	wire	[15:0]	memwb_targets_src1_0 = MEMWB_rfdata__out_0;
	wire	[15:0]	memwb_targets_src2_0 = MEMWB_rfdata__out_0;
	wire		s1nonzero_1 = (RF__src1_1[2:0] != 3'd0);
	wire		s2nonzero_1 = (RF__src2_1[2:0] != 3'd0);
	wire		ifid_is_addORnand_1 = (IFID_op_1 == `ADD) | (IFID_op_1 == `NAND);
	wire		idex_is_lw_1 = (IDEX_op__out_1 == `LW);
	wire		ifid_is_lui_1 = (IFID_op_1 == `LUI);
	wire		ifid_uses_simm_1 = (IFID_op_1 == `ADDI) | (IFID_op_1 == `LW) | (IFID_op_1 == `SW);
	wire		ifid_writesRF_1 =	(~IFID_op_1[2] | IFID_op_1[0]);
	wire	[15:0]	idex_targets_src1_1 = ALU_out_1;
	wire	[15:0]	idex_targets_src2_1 = ALU_out_1;
	wire	[15:0]	exmem_targets_src1_1 = MUXout_out_1;
	wire	[15:0]	exmem_targets_src2_1 = MUXout_out_1;
	wire	[15:0]	memwb_targets_src1_1 = MEMWB_rfdata__out_1;
	wire	[15:0]	memwb_targets_src2_1 = MEMWB_rfdata__out_1;

	wire	[2:0]	CTL6_out_op_0 = ((IDEX_op__out_0 == `LW) &&
								  ((IFID_op_0 == `ADD) || (IFID_op_0 == `NAND)) &&
								  ((IDEX_rT__out_0 == IFID_rB_0) || (IDEX_rT__out_0 == IFID_rC_0))) ? 3'd0 :
								  ((IDEX_op__out_0 == `LW) &&
								  ((IFID_op_0 == `ADDI) || (IFID_op_0 == `LW) || (IFID_op_0 == `JALR)) &&
								  (IDEX_rT__out_0 == IFID_rB_0)) ? 3'd0 :
								  ((IDEX_op__out_0 == `LW) &&
								  ((IFID_op_0 == `BNE) || (IFID_op_0 == `SW)) &&
								  ((IDEX_rT__out_0 == IFID_rA_0) || (IDEX_rT__out_0 == IFID_rB_0))) ? 3'd0 :
                                  (Pstall_0) ? 3'd0 : IFID_op_0;
	wire	[2:0]	CTL6_out_rT_0 = ((IFID_op_0 == `SW) || (IFID_op_0 == `BNE)) ? 3'd0 :
								  ((IDEX_op__out_0 == `LW) &&
								  ((IFID_op_0 == `ADD) || (IFID_op_0 == `NAND)) &&
								  ((IDEX_rT__out_0 == IFID_rB_0) || (IDEX_rT__out_0 == IFID_rC_0))) ? 3'd0 :
								  ((IDEX_op__out_0 == `LW) &&
								  ((IFID_op_0 == `ADDI) || (IFID_op_0 == `LW) || (IFID_op_0 == `JALR)) &&
								  (IDEX_rT__out_0 == IFID_rB_0)) ? 3'd0 :
								  ((IDEX_op__out_0 == `LW) &&
								  (IFID_op_0 == `BNE) &&
								  ((IDEX_rT__out_0 == IFID_rA_0) || (IDEX_rT__out_0 == IFID_rB_0))) ? 3'd0 :
                                  (Pstall_0) ? 3'd0 : IFID_rA_0;

	assign	Pstall_0 = (IDEX_op__out_0 == `LW &&
					 (IFID_op_0 == `ADD || IFID_op_0 == `NAND) &&
					 (IDEX_rT__out_0 == IFID_rB_0 || IDEX_rT__out_0 == IFID_rC_0)) ? 1'd1 :
					 (IDEX_op__out_0 == `LW &&
					 (IFID_op_0 == `ADDI || IFID_op_0 == `LW || IFID_op_0 == `JALR) &&
					 (IDEX_rT__out_0 == IFID_rB_0)) ? 1'd1 :
					 (IDEX_op__out_0 == `LW &&
					 (IFID_op_0 == `BNE || IFID_op_0 == `SW) &&
					 (IDEX_rT__out_0 == IFID_rA_0 || IDEX_rT__out_0 == IFID_rB_0)) ? 1'd1 :
                        (IDEX_op__out_1 == `LW &&
					 (IFID_op_0 == `ADD || IFID_op_0 == `NAND) &&
					 (IDEX_rT__out_1 == IFID_rB_0 || IDEX_rT__out_1 == IFID_rC_0)) ? 1'd1 :
					 (IDEX_op__out_1 == `LW &&
					 (IFID_op_0 == `ADDI || IFID_op_0 == `LW || IFID_op_0 == `JALR) &&
					 (IDEX_rT__out_1 == IFID_rB_0)) ? 1'd1 :
					 (IDEX_op__out_1 == `LW &&
					 (IFID_op_0 == `BNE || IFID_op_0 == `SW) &&
					 (IDEX_rT__out_1 == IFID_rA_0 || IDEX_rT__out_1 == IFID_rB_0)) ? 1'd1 :
                     (IFID_instr__out_0 != 0 && IFID_instr__out_1 != 0 && (IFID_rA_1 == IFID_rB_0 || IFID_rA_1 == IFID_rC_0) && IFID_pc__out_0 > IFID_pc__out_1) ? 1'd1 :
                     ((IFID_rA_0 == IFID_rA_1) && (IFID_pc__out_1 < IFID_pc__out_0)) ? 1'd1 :
                     (((IFID_op_0 == `SW && IFID_op_1 == `LW) || (IFID_op_0 == `LW && IFID_op_1 == `SW)) && (IFID_pc__out_1 < IFID_pc__out_0)) ? 1'd1 : 1'd0;


	assign	Pstomp_0 = ((CTL6_out_op_0 == `BNE) && not_equal_0 ) ? 1'd1 :
	 				 ((CTL6_out_op_0 == `JALR) && (MUXimm_out_0 == `ZERO)) ? 1'd1 :
                     (Pstall_1 && IDEX_op__out_0 == `LW) ? 1'd1 : 1'd0;
/*
                     (IFID_instr__out_0 != 0 && IFID_instr__out_1 != 0 && (IFID_rA_0 == IFID_rB_1 || IFID_rA_0 == IFID_rC_1) && IFID_pc__out_0 < IFID_pc__out_1) ? 1'd1 :
                        (IDEX_op__out_0 == `LW &&
					 (IFID_op_1 == `ADD || IFID_op_1 == `NAND) &&
					 (IDEX_rT__out_0 == IFID_rB_1 || IDEX_rT__out_0 == IFID_rC_1)) ? 1'd1 :
					 (IDEX_op__out_0 == `LW &&
					 (IFID_op_1 == `ADDI || IFID_op_1 == `LW || IFID_op_1 == `JALR) &&
					 (IDEX_rT__out_0 == IFID_rB_1)) ? 1'd1 :
					 (IDEX_op__out_0 == `LW &&
					 (IFID_op_1 == `BNE || IFID_op_1 == `SW) &&
					 (IDEX_rT__out_0 == IFID_rA_1 || IDEX_rT__out_0 == IFID_rB_1)) ? 1'd1 :
 1'd0; */
	assign	RF__src1_0 = IFID_rB_0;
	assign	RF__src2_0 = MUXs2_out_0;
    assign	MUXs2_out_0 = (IFID_op_0 == `ADD) ? IFID_rC_0 :
						(IFID_op_0 == `ADDI) ? IFID_rA_0 :
						(IFID_op_0 == `NAND) ? IFID_rC_0 :
						(IFID_op_0 == `LUI) ? IFID_rC_0 :
						(IFID_op_0 == `SW) ? IFID_rA_0 :
						(IFID_op_0 == `LW) ? IFID_rA_0 :
						(IFID_op_0 == `BNE) ? IFID_rA_0 : IFID_rA_0;
	assign	MUXimm_out_0 = (IFID_op_0 == `ADDI) ? IFID_simm_0 :
						 (IFID_op_0 == `LUI) ? IFID_uimm_0 :
						 (IFID_op_0 == `SW) ? IFID_simm_0 :
						 (IFID_op_0 == `LW) ? IFID_simm_0 :
						 (IFID_op_0 == `BNE) ? IFID_simm_0 :
						 (IFID_op_0 == `JALR) ? IFID_simm_0 : IFID_pc_plus1_0;
	assign	MUXop1_out_0 = ((IFID_rB_0 == IDEX_rT__out_1) && s1nonzero_0 && ~(IFID_rB_0 == IDEX_rT__out_0) && (IDEX_pc__out_1 < IFID_pc__out_0)) ? idex_targets_src1_1 :
                           (~(IFID_rB_0 == IDEX_rT__out_1) && s1nonzero_0 && (IFID_rB_0 == IDEX_rT__out_0) && (IDEX_pc__out_0 < IFID_pc__out_0)) ? idex_targets_src1_0 :
                           ((IFID_rB_0 == IDEX_rT__out_1) && s1nonzero_0 && (IFID_rB_0 == IDEX_rT__out_0) && (IDEX_pc__out_1 > IDEX_pc__out_0) && (IDEX_pc__out_1 < IFID_pc__out_0)) ? idex_targets_src1_1 :
                           ((IFID_rB_0 == IDEX_rT__out_1) && s1nonzero_0 && (IFID_rB_0 == IDEX_rT__out_0) && (IDEX_pc__out_1 < IDEX_pc__out_0) && (IDEX_pc__out_0 < IFID_pc__out_0)) ? idex_targets_src1_0 :


                           ((IFID_rB_0 == EXMEM_rT__out_1) && s1nonzero_0 && ~(IFID_rB_0 == EXMEM_rT__out_0) && (EXMEM_pc__out_1 < IFID_pc__out_0)) ? exmem_targets_src1_1 :
                           (~(IFID_rB_0 == EXMEM_rT__out_1) && s1nonzero_0 && (IFID_rB_0 == EXMEM_rT__out_0) && (EXMEM_pc__out_0 < IFID_pc__out_0)) ? exmem_targets_src1_0 :
                           ((IFID_rB_0 == EXMEM_rT__out_1) && s1nonzero_0 && (IFID_rB_0 == EXMEM_rT__out_0) && (EXMEM_pc__out_1 > EXMEM_pc__out_0) && (EXMEM_pc__out_1 < IFID_pc__out_0)) ? exmem_targets_src1_1 :
                           ((IFID_rB_0 == EXMEM_rT__out_1) && s1nonzero_0 && (IFID_rB_0 == EXMEM_rT__out_0) && (EXMEM_pc__out_1 < EXMEM_pc__out_0) && (EXMEM_pc__out_0 < IFID_pc__out_0)) ? exmem_targets_src1_0 :
						 

                           ((IFID_rB_0 == MEMWB_rT__out_1) && s1nonzero_0 && ~(IFID_rB_0 == MEMWB_rT__out_0) && (MEMWB_pc__out_1 < IFID_pc__out_0)) ? memwb_targets_src1_1 :
                           (~(IFID_rB_0 == MEMWB_rT__out_1) && s1nonzero_0 && (IFID_rB_0 == MEMWB_rT__out_0) && (MEMWB_pc__out_0 < IFID_pc__out_0)) ? memwb_targets_src1_0 :
                           ((IFID_rB_0 == MEMWB_rT__out_1) && s1nonzero_0 && (IFID_rB_0 == MEMWB_rT__out_0) && (MEMWB_pc__out_1 > MEMWB_pc__out_0) && (MEMWB_pc__out_1 < IFID_pc__out_0)) ? memwb_targets_src1_1 :
                           ((IFID_rB_0 == MEMWB_rT__out_1) && s1nonzero_0 && (IFID_rB_0 == MEMWB_rT__out_0) && (MEMWB_pc__out_1 < MEMWB_pc__out_0) && (MEMWB_pc__out_0 < IFID_pc__out_0)) ? memwb_targets_src1_0 : RF__out1_0;


	assign	MUXop2_out_0 = ((MUXs2_out_0 == IDEX_rT__out_1) && s2nonzero_0 && ~(MUXs2_out_0 == IDEX_rT__out_0) && (IDEX_pc__out_1 < IFID_pc__out_0)) ? idex_targets_src1_1 :
                           (~(MUXs2_out_0 == IDEX_rT__out_1) && s2nonzero_0 && (MUXs2_out_0 == IDEX_rT__out_0) && (IDEX_pc__out_0 < IFID_pc__out_0)) ? idex_targets_src1_0 :
                           ((MUXs2_out_0 == IDEX_rT__out_1) && s2nonzero_0 && (MUXs2_out_0 == IDEX_rT__out_0) && (IDEX_pc__out_1 > IDEX_pc__out_0) && (IDEX_pc__out_1 < IFID_pc__out_0)) ? idex_targets_src1_1 :
                           ((MUXs2_out_0 == IDEX_rT__out_1) && s2nonzero_0 && (MUXs2_out_0 == IDEX_rT__out_0) && (IDEX_pc__out_1 < IDEX_pc__out_0) && (IDEX_pc__out_0 < IFID_pc__out_0)) ? idex_targets_src1_0 :


                           ((MUXs2_out_0 == EXMEM_rT__out_1) && s2nonzero_0 && ~(MUXs2_out_0 == EXMEM_rT__out_0) && (EXMEM_pc__out_1 < IFID_pc__out_0)) ? exmem_targets_src1_1 :
                           (~(MUXs2_out_0 == EXMEM_rT__out_1) && s2nonzero_0 && (MUXs2_out_0 == EXMEM_rT__out_0) && (EXMEM_pc__out_0 < IFID_pc__out_0)) ? exmem_targets_src1_0 :
                           ((MUXs2_out_0 == EXMEM_rT__out_1) && s2nonzero_0 && (MUXs2_out_0 == EXMEM_rT__out_0) && (EXMEM_pc__out_1 > EXMEM_pc__out_0) && (EXMEM_pc__out_1 < IFID_pc__out_0)) ? exmem_targets_src1_1 :
                           ((MUXs2_out_0 == EXMEM_rT__out_1) && s2nonzero_0 && (MUXs2_out_0 == EXMEM_rT__out_0) && (EXMEM_pc__out_1 < EXMEM_pc__out_0) && (EXMEM_pc__out_0 < IFID_pc__out_0)) ? exmem_targets_src1_0 :
						 

                           ((MUXs2_out_0 == MEMWB_rT__out_1) && s2nonzero_0 && ~(MUXs2_out_0 == MEMWB_rT__out_0) && (MEMWB_pc__out_1 < IFID_pc__out_0)) ? memwb_targets_src1_1 :
                           (~(MUXs2_out_0 == MEMWB_rT__out_1) && s2nonzero_0 && (MUXs2_out_0 == MEMWB_rT__out_0) && (MEMWB_pc__out_0 < IFID_pc__out_0)) ? memwb_targets_src1_0 :
                           ((MUXs2_out_0 == MEMWB_rT__out_1) && s2nonzero_0 && (MUXs2_out_0 == MEMWB_rT__out_0) && (MEMWB_pc__out_1 > MEMWB_pc__out_0) && (MEMWB_pc__out_1 < IFID_pc__out_0)) ? memwb_targets_src1_1 :
                           ((MUXs2_out_0 == MEMWB_rT__out_1) && s2nonzero_0 && (MUXs2_out_0 == MEMWB_rT__out_0) && (MEMWB_pc__out_1 < MEMWB_pc__out_0) && (MEMWB_pc__out_0 < IFID_pc__out_0)) ? memwb_targets_src1_0 : RF__out2_0;

	assign	IDEX_op__in_0 = CTL6_out_op_0;
	assign	IDEX_rT__in_0 = CTL6_out_rT_0;
	assign	IDEX_op0__in_0 = MUXimm_out_0;
	assign	IDEX_op1__in_0 = MUXop1_out_0;
	assign	IDEX_op2__in_0 = MUXop2_out_0;
	assign	IDEX_pc__in_0 = IFID_pc__out_0;
	assign	IDEX_x__in_0 = (CTL6_out_op_0 == `JALR && MUXimm_out_0 != `ZERO) ? 1'b1 : 1'b0;

    // SWITCH PARITY OF PC'S SIGNAL
    assign Pswitch = (~(IFID_rA_0 == IFID_rB_1 || IFID_rA_0 == IFID_rC_1) && (Pstall_0 ^ Pstall_1)) ? 1'd1 : 1'd0;


    //
    // DECODE STAGE 1
    //

	IDEX	idex_reg_1(.reset(res_D), .clk(clk_D), .IDEX_op0__in(IDEX_op0__in_1), .IDEX_op1__in(IDEX_op1__in_1),
			.IDEX_op2__in(IDEX_op2__in_1), .IDEX_op__in(IDEX_op__in_1), .IDEX_rT__in(IDEX_rT__in_1),
			.IDEX_pc__in(IDEX_pc__in_1), .IDEX_x__in(IDEX_x__in_1),
			.IDEX_pc__out(IDEX_pc__out_1), .IDEX_x__out(IDEX_x__out_1),
			.IDEX_op0__out(IDEX_op0__out_1), .IDEX_op1__out(IDEX_op1__out_1), .IDEX_op2__out(IDEX_op2__out_1),
			.IDEX_op__out(IDEX_op__out_1), .IDEX_rT__out(IDEX_rT__out_1));


	wire	[2:0]	CTL6_out_op_1 = ((IDEX_op__out_1 == `LW) &&
								  ((IFID_op_1 == `ADD) || (IFID_op_1 == `NAND)) &&
								  ((IDEX_rT__out_1 == IFID_rB_1) || (IDEX_rT__out_1 == IFID_rC_1))) ? 3'd0 :
								  ((IDEX_op__out_1 == `LW) &&
								  ((IFID_op_1 == `ADDI) || (IFID_op_1 == `LW) || (IFID_op_1 == `JALR)) &&
								  (IDEX_rT__out_1 == IFID_rB_1)) ? 3'd0 :
								  ((IDEX_op__out_1 == `LW) &&
								  ((IFID_op_1 == `BNE) || (IFID_op_1 == `SW)) &&
								  ((IDEX_rT__out_1 == IFID_rA_1) || (IDEX_rT__out_1 == IFID_rB_1))) ? 3'd0 : 
                                  (Pstall_1) ? 3'd0 : IFID_op_1;
	wire	[2:0]	CTL6_out_rT_1 = ((IFID_op_1 == `SW) || (IFID_op_1 == `BNE)) ? 3'd0 :
								  ((IDEX_op__out_1 == `LW) &&
								  ((IFID_op_1 == `ADD) || (IFID_op_1 == `NAND)) &&
								  ((IDEX_rT__out_1 == IFID_rB_1) || (IDEX_rT__out_1 == IFID_rC_1))) ? 3'd0 :
								  ((IDEX_op__out_1 == `LW) &&
								  ((IFID_op_1 == `ADDI) || (IFID_op_1 == `LW) || (IFID_op_1 == `JALR)) &&
								  (IDEX_rT__out_1 == IFID_rB_1)) ? 3'd0 :
								  ((IDEX_op__out_1 == `LW) &&
								  (IFID_op_1 == `BNE) &&
								  ((IDEX_rT__out_1 == IFID_rA_1) || (IDEX_rT__out_1 == IFID_rB_1))) ? 3'd0 :
                                  (Pstall_1) ? 3'd0 : IFID_rA_1;

	assign	Pstall_1 = (IDEX_op__out_1 == `LW &&
					 (IFID_op_1 == `ADD || IFID_op_1 == `NAND) &&
					 (IDEX_rT__out_1 == IFID_rB_1 || IDEX_rT__out_1 == IFID_rC_1)) ? 1'd1 :
					 (IDEX_op__out_1 == `LW &&
					 (IFID_op_1 == `ADDI || IFID_op_1 == `LW || IFID_op_1 == `JALR) &&
					 (IDEX_rT__out_1 == IFID_rB_1)) ? 1'd1 :
					 (IDEX_op__out_1 == `LW &&
					 (IFID_op_1 == `BNE || IFID_op_1 == `SW) &&
					 (IDEX_rT__out_1 == IFID_rA_1 || IDEX_rT__out_1 == IFID_rB_1)) ? 1'd1 :
                    (IFID_instr__out_0 != 0 && IFID_instr__out_1 != 0 && (IFID_rA_0 == IFID_rB_1 || IFID_rA_0 == IFID_rC_1) && IFID_pc__out_0 < IFID_pc__out_1) ? 1'd1 :
                        (IDEX_op__out_0 == `LW &&
					 (IFID_op_1 == `ADD || IFID_op_1 == `NAND) &&
					 (IDEX_rT__out_0 == IFID_rB_1 || IDEX_rT__out_0 == IFID_rC_1)) ? 1'd1 :
					 (IDEX_op__out_0 == `LW &&
					 (IFID_op_1 == `ADDI || IFID_op_1 == `LW || IFID_op_1 == `JALR) &&
					 (IDEX_rT__out_0 == IFID_rB_1)) ? 1'd1 :
					 (IDEX_op__out_0 == `LW &&
					 (IFID_op_1 == `BNE || IFID_op_1 == `SW) &&
					 (IDEX_rT__out_0 == IFID_rA_1 || IDEX_rT__out_0 == IFID_rB_1)) ? 1'd1 :
                     ((IFID_rA_0 == IFID_rA_1) && (IFID_pc__out_1 > IFID_pc__out_0)) ? 1'd1 :
                     (((IFID_op_0 == `SW && IFID_op_1 == `LW) || (IFID_op_0 == `LW && IFID_op_1 == `SW)) && (IFID_pc__out_1 > IFID_pc__out_0)) ? 1'd1 : 1'd0;


	assign	Pstomp_1 = ((CTL6_out_op_1 == `BNE) && not_equal_1 ) ? 1'd1 :
	 				 ((CTL6_out_op_1 == `JALR) && (MUXimm_out_1 == `ZERO)) ? 1'd1 :
                     (Pstall_0 && IDEX_op__out_1 == `LW) ? 1'd1 : 1'd0;
                   //  (IFID_instr__out_0 != 0 && IFID_instr__out_1 != 0 && (IFID_rA_0 == IFID_rB_1 || IFID_rA_0 == IFID_rC_1) && IFID_pc__out_0 < IFID_pc__out_1) ? 1'd1 : 1'd0;
	assign	RF__src1_1 = IFID_rB_1;
	assign	RF__src2_1 = MUXs2_out_1;
    assign	MUXs2_out_1 = (IFID_op_1 == `ADD) ? IFID_rC_1 :
						(IFID_op_1 == `ADDI) ? IFID_rA_1 :
						(IFID_op_1 == `NAND) ? IFID_rC_1 :
						(IFID_op_1 == `LUI) ? IFID_rC_1 :
						(IFID_op_1 == `SW) ? IFID_rA_1 :
						(IFID_op_1 == `LW) ? IFID_rA_1 :
						(IFID_op_1 == `BNE) ? IFID_rA_1 : IFID_rA_1;
	assign	MUXimm_out_1 = (IFID_op_1 == `ADDI) ? IFID_simm_1 :
						 (IFID_op_1 == `LUI) ? IFID_uimm_1 :
						 (IFID_op_1 == `SW) ? IFID_simm_1 :
						 (IFID_op_1 == `LW) ? IFID_simm_1 :
						 (IFID_op_1 == `BNE) ? IFID_simm_1 :
						 (IFID_op_1 == `JALR) ? IFID_simm_1 : IFID_pc_plus1_1;
	assign	MUXop1_out_1 = ((IFID_rB_1 == IDEX_rT__out_1) && s1nonzero_1 && ~(IFID_rB_1 == IDEX_rT__out_0) && (IDEX_pc__out_1 < IFID_pc__out_1)) ? idex_targets_src1_1 :
                           (~(IFID_rB_1 == IDEX_rT__out_1) && s1nonzero_1 && (IFID_rB_1 == IDEX_rT__out_0) && (IDEX_pc__out_0 < IFID_pc__out_1)) ? idex_targets_src1_0 :
                           ((IFID_rB_1 == IDEX_rT__out_1) && s1nonzero_1 && (IFID_rB_1 == IDEX_rT__out_0) && (IDEX_pc__out_1 > IDEX_pc__out_0) && (IDEX_pc__out_1 < IFID_pc__out_1)) ? idex_targets_src1_1 :
                           ((IFID_rB_1 == IDEX_rT__out_1) && s1nonzero_1 && (IFID_rB_1 == IDEX_rT__out_0) && (IDEX_pc__out_1 < IDEX_pc__out_0) && (IDEX_pc__out_0 < IFID_pc__out_1)) ? idex_targets_src1_0 :


                           ((IFID_rB_1 == EXMEM_rT__out_1) && s1nonzero_1 && ~(IFID_rB_1 == EXMEM_rT__out_0) && (EXMEM_pc__out_1 < IFID_pc__out_1)) ? exmem_targets_src1_1 :
                           (~(IFID_rB_1 == EXMEM_rT__out_1) && s1nonzero_1 && (IFID_rB_1 == EXMEM_rT__out_0) && (EXMEM_pc__out_0 < IFID_pc__out_1)) ? exmem_targets_src1_0 :
                           ((IFID_rB_1 == EXMEM_rT__out_1) && s1nonzero_1 && (IFID_rB_1 == EXMEM_rT__out_0) && (EXMEM_pc__out_1 > EXMEM_pc__out_0) && (EXMEM_pc__out_1 < IFID_pc__out_1)) ? exmem_targets_src1_1 :
                           ((IFID_rB_1 == EXMEM_rT__out_1) && s1nonzero_1 && (IFID_rB_1 == EXMEM_rT__out_0) && (EXMEM_pc__out_1 < EXMEM_pc__out_0) && (EXMEM_pc__out_0 < IFID_pc__out_1)) ? exmem_targets_src1_0 :
						 

                           ((IFID_rB_1 == MEMWB_rT__out_1) && s1nonzero_1 && ~(IFID_rB_1 == MEMWB_rT__out_0) && (MEMWB_pc__out_1 < IFID_pc__out_1)) ? memwb_targets_src1_1 :
                           (~(IFID_rB_1 == MEMWB_rT__out_1) && s1nonzero_1 && (IFID_rB_1 == MEMWB_rT__out_0) && (MEMWB_pc__out_0 < IFID_pc__out_1)) ? memwb_targets_src1_0 :
                           ((IFID_rB_1 == MEMWB_rT__out_1) && s1nonzero_1 && (IFID_rB_1 == MEMWB_rT__out_0) && (MEMWB_pc__out_1 > MEMWB_pc__out_0) && (MEMWB_pc__out_1 < IFID_pc__out_1)) ? memwb_targets_src1_1 :
                           ((IFID_rB_1 == MEMWB_rT__out_1) && s1nonzero_1 && (IFID_rB_1 == MEMWB_rT__out_0) && (MEMWB_pc__out_1 < MEMWB_pc__out_0) && (MEMWB_pc__out_0 < IFID_pc__out_1)) ? memwb_targets_src1_0 : RF__out1_1;


	assign	MUXop2_out_1 = ((MUXs2_out_1 == IDEX_rT__out_1) && s2nonzero_1 && ~(MUXs2_out_1 == IDEX_rT__out_0) && (IDEX_pc__out_1 < IFID_pc__out_1)) ? idex_targets_src1_1 :
                           (~(MUXs2_out_1 == IDEX_rT__out_1) && s2nonzero_1 && (MUXs2_out_1 == IDEX_rT__out_0) && (IDEX_pc__out_0 < IFID_pc__out_1)) ? idex_targets_src1_0 :
                           ((MUXs2_out_1 == IDEX_rT__out_1) && s2nonzero_1 && (MUXs2_out_1 == IDEX_rT__out_0) && (IDEX_pc__out_1 > IDEX_pc__out_0) && (IDEX_pc__out_1 < IFID_pc__out_1)) ? idex_targets_src1_1 :
                           ((MUXs2_out_1 == IDEX_rT__out_1) && s2nonzero_1 && (MUXs2_out_1 == IDEX_rT__out_0) && (IDEX_pc__out_1 < IDEX_pc__out_0) && (IDEX_pc__out_0 < IFID_pc__out_1)) ? idex_targets_src1_0 :


                           ((MUXs2_out_1 == EXMEM_rT__out_1) && s2nonzero_1 && ~(MUXs2_out_1 == EXMEM_rT__out_0) && (EXMEM_pc__out_1 < IFID_pc__out_1)) ? exmem_targets_src1_1 :
                           (~(MUXs2_out_1 == EXMEM_rT__out_1) && s2nonzero_1 && (MUXs2_out_1 == EXMEM_rT__out_0) && (EXMEM_pc__out_0 < IFID_pc__out_1)) ? exmem_targets_src1_0 :
                           ((MUXs2_out_1 == EXMEM_rT__out_1) && s2nonzero_1 && (MUXs2_out_1 == EXMEM_rT__out_0) && (EXMEM_pc__out_1 > EXMEM_pc__out_0) && (EXMEM_pc__out_1 < IFID_pc__out_1)) ? exmem_targets_src1_1 :
                           ((MUXs2_out_1 == EXMEM_rT__out_1) && s2nonzero_1 && (MUXs2_out_1 == EXMEM_rT__out_0) && (EXMEM_pc__out_1 < EXMEM_pc__out_0) && (EXMEM_pc__out_0 < IFID_pc__out_1)) ? exmem_targets_src1_0 :
						 

                           ((MUXs2_out_1 == MEMWB_rT__out_1) && s2nonzero_1 && ~(MUXs2_out_1 == MEMWB_rT__out_0) && (MEMWB_pc__out_1 < IFID_pc__out_1)) ? memwb_targets_src1_1 :
                           (~(MUXs2_out_1 == MEMWB_rT__out_1) && s2nonzero_1 && (MUXs2_out_1 == MEMWB_rT__out_0) && (MEMWB_pc__out_0 < IFID_pc__out_1)) ? memwb_targets_src1_0 :
                           ((MUXs2_out_1 == MEMWB_rT__out_1) && s2nonzero_1 && (MUXs2_out_1 == MEMWB_rT__out_0) && (MEMWB_pc__out_1 > MEMWB_pc__out_0) && (MEMWB_pc__out_1 < IFID_pc__out_1)) ? memwb_targets_src1_1 :

                           ((MUXs2_out_1 == MEMWB_rT__out_1) && s2nonzero_1 && (MUXs2_out_1 == MEMWB_rT__out_0) && (MEMWB_pc__out_1 < MEMWB_pc__out_0) && (MEMWB_pc__out_0 < IFID_pc__out_1)) ? memwb_targets_src1_0 : RF__out2_1;

	assign	IDEX_op__in_1 = CTL6_out_op_1;
	assign	IDEX_rT__in_1 = CTL6_out_rT_1;
	assign	IDEX_op0__in_1 = MUXimm_out_1;
	assign	IDEX_op1__in_1 = MUXop1_out_1;
	assign	IDEX_op2__in_1 = MUXop2_out_1;
	assign	IDEX_pc__in_1 = IFID_pc__out_1;
	assign	IDEX_x__in_1 = (CTL6_out_op_1 == `JALR && MUXimm_out_1 != `ZERO) ? 1'b1 : 1'b0;


	//
	// EXECUTE STAGE 0
	//
	wire		idex_is_addORnand_0 = (IDEX_op__out_0 == `ADD) | (IDEX_op__out_0 == `NAND);
	wire		idex_is_lui_0 = (IDEX_op__out_0 == `LUI);

	arithmetic_logic_unit	ALU_0 (.op(FUNCalu_0), .alu1(IDEX_op1__out_0), .alu2(MUXalu2_out_0), .bus(ALU_out_0));

	EXMEM	exmem_reg_0(.reset(res_E), .clk(clk_E), .EXMEM_stdata__in(EXMEM_stdata__in_0), .EXMEM_ALUout__in(EXMEM_ALUout__in_0),
			.EXMEM_op__in(EXMEM_op__in_0), .EXMEM_rT__in(EXMEM_rT__in_0), .EXMEM_stdata__out(EXMEM_stdata__out_0),
			.EXMEM_pc__in(EXMEM_pc__in_0), .EXMEM_x__in(EXMEM_x__in_0),
			.EXMEM_pc__out(EXMEM_pc__out_0), .EXMEM_x__out(EXMEM_x__out_0),
			.EXMEM_ALUout__out(EXMEM_ALUout__out_0), .EXMEM_op__out(EXMEM_op__out_0), .EXMEM_rT__out(EXMEM_rT__out_0));


	assign	MUXalu2_out_0 = (IDEX_op__out_0 == `ADD) ? IDEX_op2__out_0 :
						  (IDEX_op__out_0 == `ADDI) ? IDEX_op0__out_0 :
						  (IDEX_op__out_0 == `NAND) ? IDEX_op2__out_0 :
						  (IDEX_op__out_0 == `LUI) ? IDEX_op0__out_0 :
						  (IDEX_op__out_0 == `SW) ? IDEX_op0__out_0 :
						  (IDEX_op__out_0 == `LW) ? IDEX_op0__out_0 :
						  (IDEX_op__out_0 == `BNE) ? IDEX_op2__out_0 : IDEX_op0__out_0;
	assign	EXMEM_op__in_0 = IDEX_op__out_0;
	assign	EXMEM_rT__in_0 = IDEX_rT__out_0;
	assign	EXMEM_pc__in_0 = IDEX_pc__out_0;
	assign	EXMEM_x__in_0 = IDEX_x__out_0;
	assign	EXMEM_stdata__in_0 = IDEX_op2__out_0;
	assign	EXMEM_ALUout__in_0 = ALU_out_0;


	//
	// EXECUTE STAGE 1
	//
	wire		idex_is_addORnand_1 = (IDEX_op__out_1 == `ADD) | (IDEX_op__out_1 == `NAND);
	wire		idex_is_lui_1 = (IDEX_op__out_1 == `LUI);

	arithmetic_logic_unit	ALU_1 (.op(FUNCalu_1), .alu1(IDEX_op1__out_1), .alu2(MUXalu2_out_1), .bus(ALU_out_1));

	EXMEM	exmem_reg_1(.reset(res_E), .clk(clk_E), .EXMEM_stdata__in(EXMEM_stdata__in_1), .EXMEM_ALUout__in(EXMEM_ALUout__in_1),
			.EXMEM_op__in(EXMEM_op__in_1), .EXMEM_rT__in(EXMEM_rT__in_1), .EXMEM_stdata__out(EXMEM_stdata__out_1),
			.EXMEM_pc__in(EXMEM_pc__in_1), .EXMEM_x__in(EXMEM_x__in_1),
			.EXMEM_pc__out(EXMEM_pc__out_1), .EXMEM_x__out(EXMEM_x__out_1),
			.EXMEM_ALUout__out(EXMEM_ALUout__out_1), .EXMEM_op__out(EXMEM_op__out_1), .EXMEM_rT__out(EXMEM_rT__out_1));


	assign	MUXalu2_out_1 = (IDEX_op__out_1 == `ADD) ? IDEX_op2__out_1 :
						  (IDEX_op__out_1 == `ADDI) ? IDEX_op0__out_1 :
						  (IDEX_op__out_1 == `NAND) ? IDEX_op2__out_1 :
						  (IDEX_op__out_1 == `LUI) ? IDEX_op0__out_1 :
						  (IDEX_op__out_1 == `SW) ? IDEX_op0__out_1 :
						  (IDEX_op__out_1 == `LW) ? IDEX_op0__out_1 :
						  (IDEX_op__out_1 == `BNE) ? IDEX_op2__out_1 : IDEX_op0__out_1;
	assign	EXMEM_op__in_1 = IDEX_op__out_1;
	assign	EXMEM_rT__in_1 = IDEX_rT__out_1;
	assign	EXMEM_pc__in_1 = IDEX_pc__out_1;
	assign	EXMEM_x__in_1 = IDEX_x__out_1;
	assign	EXMEM_stdata__in_1 = IDEX_op2__out_1;
	assign	EXMEM_ALUout__in_1 = ALU_out_1;


	//
	// MEMORY STAGE 0
	//
	wire		exmem_is_lw_0 = (EXMEM_op__out_0 == `LW);
	wire		exmem_is_sw_0 = (EXMEM_op__out_0 == `SW);

	wire	[15:0]	MEM__data2in_0;

	wire		exmem_is_lw_1 = (EXMEM_op__out_1 == `LW);
	wire		exmem_is_sw_1 = (EXMEM_op__out_1 == `SW);

	wire	[15:0]	MEM__data2in_1;

	three_port_aram		MEM (.clk(clk_F), .abus1_0(MEM__addr1_0), .abus1_1(MEM__addr1_1), .dbus1_0(MEM__data1_0), .dbus1_1(MEM__data1_1), .abus2_0(MEM__addr2_0), .abus2_1(MEM__addr2_1), .dbus2o_0(MEM__data2out_0), .dbus2o_1(MEM__data2out_1), .dbus2i_0(MEM__data2in_0), .dbus2i_1(MEM__data2in_1), .we_0(WEdmem_0), .we_1(WEdmem_1));

	MEMWB	memwb_reg_0(.reset(res_G), .clk(clk_G), .MEMWB_rfdata__in(MEMWB_rfdata__in_0), .MEMWB_rT__in(MEMWB_rT__in_0),
			.MEMWB_pc__in(MEMWB_pc__in_0), .MEMWB_x__in(MEMWB_x__in_0),
			.MEMWB_pc__out(MEMWB_pc__out_0), .MEMWB_x__out(MEMWB_x__out_0),
			.MEMWB_rfdata__out(MEMWB_rfdata__out_0), .MEMWB_rT__out(MEMWB_rT__out_0));


	assign	MEM__addr2_0 = EXMEM_ALUout__out_0;
	assign	MEM__data2in_0 = EXMEM_stdata__out_0;
	assign	WEdmem_0 = (EXMEM_op__out_0 == `SW) ? 1'd1 : 1'd0;
	assign	MUXout_out_0 = (EXMEM_op__out_0 == `LW) ? MEM__data2out_0 : EXMEM_ALUout__out_0;
	assign	MEMWB_rT__in_0 = EXMEM_rT__out_0;
	assign	MEMWB_pc__in_0 = EXMEM_pc__out_0;
	assign	MEMWB_x__in_0 = EXMEM_x__out_0;
	assign	MEMWB_rfdata__in_0 = MUXout_out_0;



	//
	// MEMORY STAGE 1
	//

	MEMWB	memwb_reg_1(.reset(res_G), .clk(clk_G), .MEMWB_rfdata__in(MEMWB_rfdata__in_1), .MEMWB_rT__in(MEMWB_rT__in_1),
			.MEMWB_pc__in(MEMWB_pc__in_1), .MEMWB_x__in(MEMWB_x__in_1),
			.MEMWB_pc__out(MEMWB_pc__out_1), .MEMWB_x__out(MEMWB_x__out_1),
			.MEMWB_rfdata__out(MEMWB_rfdata__out_1), .MEMWB_rT__out(MEMWB_rT__out_1));


	assign	MEM__addr2_1 = EXMEM_ALUout__out_1;
	assign	MEM__data2in_1 = EXMEM_stdata__out_1;
	assign	WEdmem_1 = (EXMEM_op__out_1 == `SW) ? 1'd1 : 1'd0;
	assign	MUXout_out_1 = (EXMEM_op__out_1 == `LW) ? MEM__data2out_1 : EXMEM_ALUout__out_1;
	assign	MEMWB_rT__in_1 = EXMEM_rT__out_1;
	assign	MEMWB_pc__in_1 = EXMEM_pc__out_1;
	assign	MEMWB_x__in_1 = EXMEM_x__out_1;
	assign	MEMWB_rfdata__in_1 = MUXout_out_1;


	//
	// WRITEBACK STAGE 0
	//
	assign	RF__tgt_0 = MEMWB_rT__out_0;
	assign	RF__in_0 = MEMWB_rfdata__out_0;


	//
	// WRITEBACK STAGE 1
	//
	assign	RF__tgt_1 = MEMWB_rT__out_1;
	assign	RF__in_1 = MEMWB_rfdata__out_1;



	always @(posedge clk) begin
                $display("------------- (time %h)", $time);
                $display("regs  %h %h %h %h %h %h %h",
                        RF.m[1], RF.m[2], RF.m[3], RF.m[4], RF.m[5], RF.m[6], RF.m[7]);
                $display("pipe  PC=%h", PC__out_0);
                $display("pipe  IFID_instr=%h (op=%h rA=%h rB=%h rC=%h imm=%d) IFID_pc=%h",
                        IFID_instr__out_0, IFID_op_0, IFID_rA_0, IFID_rB_0, IFID_rC_0, IFID_im_0, IFID_pc__out_0);
                $display("pipe  IDEX_op0=%h IDEX_op1=%h IDEX_op2=%h IDEX_op=%h IDEX_rT=%h IDEX_pc=%h IDEX_x=%h",
                        IDEX_op0__out_0, IDEX_op1__out_0, IDEX_op2__out_0, IDEX_op__out_0, IDEX_rT__out_0, IDEX_pc__out_0, IDEX_x__out_0);
                $display("pipe  EXMEM_stdata=%h EXMEM_ALUout=%h EXMEM_op=%h EXMEM_rT=%h EXMEM_pc=%h EXMEM_x=%h",
                        EXMEM_stdata__out_0, EXMEM_ALUout__out_0, EXMEM_op__out_0, EXMEM_rT__out_0, EXMEM_pc__out_0, EXMEM_x__out_0);
                $display("pipe  MEMWB_rfdata=%h MEMWB_rT=%h MEMWB_pc=%h MEMWB_x=%h",
                        MEMWB_rfdata__out_0, MEMWB_rT__out_0, MEMWB_pc__out_0, MEMWB_x__out_0);
                $display("etc.  Pstall=%h Pstomp=%h jalr=%h branch=%h simm=%d",
                        Pstall_0, Pstomp_0, ifid_is_jalr_0, takenBranch_0, IFID_simm_0);
				$display("data forward R__out1=%h ALU_out=%h MUXout=%h RFdata=%h MUXs2out=%h memdata2_out=%h memaddr=%h",
						RF__out1_0, ALU_out_0, MUXout_out_0, MEMWB_rfdata__out_0, MUXs2_out_0, MEM__data2out_0, MEM__addr2_0);
				$display("check wires idex_targets_src1=%h exmem_targets_src1=%h memwb_targets_src1=%h",
						idex_targets_src1_0, exmem_targets_src1_0, memwb_targets_src1_0);

                $display("pipe  PC=%h", PC__out_1);
                $display("pipe  IFID_instr=%h (op=%h rA=%h rB=%h rC=%h imm=%d) IFID_pc=%h",
                        IFID_instr__out_1, IFID_op_1, IFID_rA_1, IFID_rB_1, IFID_rC_1, IFID_im_1, IFID_pc__out_1);
                $display("pipe  IDEX_op0=%h IDEX_op1=%h IDEX_op2=%h IDEX_op=%h IDEX_rT=%h IDEX_pc=%h IDEX_x=%h",
                        IDEX_op0__out_1, IDEX_op1__out_1, IDEX_op2__out_1, IDEX_op__out_1, IDEX_rT__out_1, IDEX_pc__out_1, IDEX_x__out_1);
                $display("pipe  EXMEM_stdata=%h EXMEM_ALUout=%h EXMEM_op=%h EXMEM_rT=%h EXMEM_pc=%h EXMEM_x=%h",
                        EXMEM_stdata__out_1, EXMEM_ALUout__out_1, EXMEM_op__out_1, EXMEM_rT__out_1, EXMEM_pc__out_1, EXMEM_x__out_1);
                $display("pipe  MEMWB_rfdata=%h MEMWB_rT=%h MEMWB_pc=%h MEMWB_x=%h",
                        MEMWB_rfdata__out_1, MEMWB_rT__out_1, MEMWB_pc__out_1, MEMWB_x__out_1);
                $display("etc.  Pstall=%h Pstomp=%h jalr=%h branch=%h simm=%d",
                        Pstall_1, Pstomp_1, ifid_is_jalr_1, takenBranch_1, IFID_simm_1);
				$display("data forward R__out1=%h ALU_out=%h MUXout=%h RFdata=%h MUXs2out=%h",
						RF__out1_1, ALU_out_1, MUXout_out_1, MEMWB_rfdata__out_1, MUXs2_out_1);
				$display("check wires idex_targets_src1=%h exmem_targets_src1=%h memwb_targets_src1=%h MUXop1_1=%h",
						idex_targets_src1_1, exmem_targets_src1_1, memwb_targets_src1_1, MUXop1_out_1);

		if (MEMWB_x__out_0 | MEMWB_x__out_1) $finish;
	end
endmodule
