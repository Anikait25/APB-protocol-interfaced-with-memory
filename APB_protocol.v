module APB_protocol #(
parameter ADDR_width = 4, 
parameter DATA_width = 8
)(
	input P_clk,
	input P_reset_n,
	input start_transfer,
	input rw,
	input [ADDR_width-1:0]addr,
	input [DATA_width-1:0]wdata,
	output [DATA_width-1:0]rdata,
	output busy,
	output valid,
	output P_sel,
	output P_enable,
	output wire P_ready
);


wire P_write;
wire [ADDR_width-1:0]P_addr;
wire [DATA_width-1:0]P_wdata;
wire [DATA_width-1:0]P_rdata;
wire P_slverr;
wire P_wakeup;

APB_master #(.ADDR_width(ADDR_width),.DATA_width(DATA_width)) master (
	.P_clk(P_clk),
	.P_reset_n(P_reset_n),
	.P_sel(P_sel),
	.P_enable(P_enable),
	.P_write(P_write),
	.P_addr(P_addr),
	.P_wdata(P_wdata),
	.P_rdata(P_rdata),
	.rw(rw),
	.addr(addr),
	.wdata(wdata),
	.rdata(rdata),
	.P_ready(P_ready),
	.start_transfer(start_transfer),
	.P_slverr(P_slverr),
	.P_wakeup(P_wakeup),
	.P_busy(busy),
	.P_valid(valid)
);

APB_slave #(.ADDR_width(ADDR_width),.DATA_width(DATA_width)) slave(
	.P_clk(P_clk),
	.P_reset_n(P_reset_n),
	.P_sel(P_sel),
	.P_enable(P_enable),
	.P_write(P_write),
	.P_addr(P_addr),
	.P_wdata(P_wdata),
	.P_rdata(P_rdata),
	.P_ready(P_ready),
	.P_slverr(P_slverr)
);

endmodule