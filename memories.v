// writable only on port 2i
module three_port_aram (clk, abus1_0, dbus1_0, abus1_1, dbus1_1, abus2_0, dbus2i_0, dbus2o_0, abus2_1, dbus2i_1, dbus2o_1, we_0, we_1);
	input		clk;

	input	[15:0]	abus1_0;
	output	[15:0]	dbus1_0;

	input	[15:0]	abus2_0;
	output	[15:0]	dbus2o_0;
	input	[15:0]	dbus2i_0;

    input	[15:0]	abus1_1;
	output	[15:0]	dbus1_1;

	input	[15:0]	abus2_1;
	output	[15:0]	dbus2o_1;
	input	[15:0]	dbus2i_1;

	input		we_0;
	input		we_1;

	reg	[15:0]	m[0:128];

	assign dbus1_0 = m[abus1_0];
	assign dbus1_1 = m[abus1_1];

	assign dbus2o_0 = m[abus2_0];
    assign dbus2o_1 = m[abus2_1];

	always @(posedge clk) begin
        $display("me=%h abus2_0=%h abus2_1=%h dbus2o_0=%h dbus2o_1=%h", m[16'd1], abus2_0, abus2_1, dbus2o_0, dbus2o_1);
		if (we_0 & we_1) begin
            m[abus2_0] <= dbus2i_0;
            m[abus2_1] <= dbus2i_1;
        end
        else if (we_0 & ~we_1) begin
            m[abus2_0] <= dbus2i_0;
        end
        else if (~we_0 & we_1) begin
            m[abus2_1] <= dbus2i_1;
        end
	end

endmodule


// writable only on port 3, r0=0
module three_port_aregfile (on, clk, abus1_0, dbus1_0, abus1_1, dbus1_1, abus2_0, dbus2_0, abus2_1, dbus2_1, abus3_0, dbus3_0, abus3_1, dbus3_1);
	input		on;
	input		clk;

	wire		iclk = on | clk;

	reg	[15:0]	m[1:7];

	input	[2:0]	abus1_0;
	output	[15:0]	dbus1_0;

	input	[2:0]	abus2_0;
	output	[15:0]	dbus2_0;

	input	[2:0]	abus3_0;
	input	[15:0]	dbus3_0;

	assign	dbus1_0 =	(abus1_0 == 3'd0) ? `ZERO : m[abus1_0];

	assign	dbus2_0 =	(abus2_0 == 3'd0) ? `ZERO : m[abus2_0];

	input	[2:0]	abus1_1;
	output	[15:0]	dbus1_1;

	input	[2:0]	abus2_1;
	output	[15:0]	dbus2_1;

	input	[2:0]	abus3_1;
	input	[15:0]	dbus3_1;

	assign	dbus1_1 =	(abus1_1 == 3'd0) ? `ZERO : m[abus1_1];

	assign	dbus2_1 =	(abus2_1 == 3'd0) ? `ZERO : m[abus2_1];

	always @(posedge iclk) begin
		if (on) begin
			m[1] <= `ZERO;
			m[2] <= `ZERO;
			m[3] <= `ZERO;
			m[4] <= `ZERO;
			m[5] <= `ZERO;
			m[6] <= `ZERO;
			m[7] <= `ZERO;
		end
		else if (abus3_0 != 3'd0 && abus3_1 != 3'd0) begin
		    m[abus3_0] <= dbus3_0;
		    m[abus3_1] <= dbus3_1;
        end
        else if (abus3_0 != 3'd0 && abus3_1 == 3'd0) begin
		    m[abus3_0] <= dbus3_0;
		end
        else if (abus3_0 == 3'd0 && abus3_1 != 3'd0) begin
		    m[abus3_1] <= dbus3_1;
        end
	end

endmodule



//
// default: 16 bits ... override parm when instantiated to get different widths
//
module registerX (reset, clk, in, out, we);

    parameter width = 16;

	input		reset;
	input		clk;
	output	[width-1:0]	out;
	input	[width-1:0]	in;
	input		we;

	reg	[width-1:0]	m;

	assign out = m;

	always @(posedge clk) begin
		m <=	(reset) ? 0 :
			(we) ? in :
			m;
	end

endmodule

module registerY (reset, clk, in, out, we);

    parameter width = 16;

	input		reset;
	input		clk;
	output	[width-1:0]	out;
	input	[width-1:0]	in;
	input		we;

	reg	[width-1:0]	m;

	assign out = m;

	always @(posedge clk) begin
		m <=	(reset) ? 16'd1 :
			(we) ? in :
			m;
	end

endmodule
