module APB_master #(parameter ADDR_width = 4, parameter DATA_width = 8)(
	input P_clk,
	input P_reset_n,
	output reg P_sel,
	output reg P_enable,
	output reg P_write,
	output reg [ADDR_width-1:0] P_addr,
	output reg [DATA_width-1:0] P_wdata,
	input [DATA_width-1:0] P_rdata,
	output reg P_wakeup,
	input P_ready,
	input start_transfer,
	input P_slverr,
	output reg P_busy,
	output reg P_valid,
	
	input rw,
	input [ADDR_width-1:0] addr,
	input [DATA_width-1:0] wdata,
	output reg [DATA_width-1:0] rdata
);

localparam IDLE = 0;
localparam SETUP = 1;
localparam ACCESS = 2;
reg [1:0]state;

always@(posedge P_clk)
begin
	if(!P_reset_n)
	begin
		state <= IDLE;
		P_sel <= 0;
		P_enable <= 0;
		P_busy <= 0;
		P_valid <= 0;
	end
	else begin
		case(state)
			IDLE:
				begin
					P_sel <= 0;
					P_enable <= 0;
					P_wakeup <= 0;
					if(start_transfer) begin 
						 P_wakeup <= 1;
						 P_busy <= 1;
						 state <= SETUP;
					end
					else state <= IDLE;
				end
			SETUP:
				begin
					P_sel <= 1;
					P_enable <= 1;
					P_addr <= addr;
					P_write <= rw;
					//$display("address=%d",P_addr);
					if(rw) begin
						P_wdata <= wdata;
					end
					else
					   state <= ACCESS;
				end
			ACCESS:
				begin
					P_sel <= 1;
					P_enable <= 1;
					if(P_ready) begin	
						if(!rw) begin 
							rdata <= P_rdata;
						end
					end
					else begin
					state <= ACCESS;
					end
					P_wakeup <= 0;
					P_busy <= 0;
					P_valid <= 1;
					if(!P_ready) state <= IDLE;
					state <= SETUP;
				end
			default : state <= IDLE;
		endcase
		//$display("state=%d",state);
	end
end

endmodule