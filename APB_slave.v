module APB_slave #(parameter ADDR_width = 4, parameter DATA_width = 8)(
	input P_clk,
	input P_reset_n,
	input P_sel,
	input P_enable,
	input P_write,
	input [ADDR_width-1:0] P_addr,
	input [DATA_width-1:0] P_wdata,
	output reg [DATA_width-1:0] P_rdata,
	output reg P_ready,
	output reg P_slverr
);

reg [DATA_width-1:0] MEMORY [0:255];


always@(posedge P_clk)
begin
	if(!P_reset_n)
	begin
		P_ready <= 0;
		P_slverr <= 0;
	end 
	else begin
		P_slverr <= 0;
		if(P_sel && P_enable) begin
			P_ready <= 1;
			if(P_write) begin
				MEMORY[P_addr] <= P_wdata;
				//$display("data=%b",MEMORY[P_addr]);
			end
			else begin
				P_rdata <= MEMORY[P_addr];
				//$display("data transmitted address = %d, rx_data=%b",P_addr,P_rdata);
			end
		end
	end
end
endmodule