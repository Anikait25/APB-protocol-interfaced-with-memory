module APB_protocol_tb;
reg P_clk;
reg [7:0]P_addr;
reg [7:0]P_wdata;
reg P_write;
wire P_sel;
wire P_enable;
wire [7:0]P_rdata;
wire P_ready;
reg start_transfer;
reg P_reset_n;
wire busy;
wire valid;
//wire [7:0]P_wdata;
//wire [7:0]P_addr;

APB_protocol #(.ADDR_width(4),.DATA_width(8)) protocol (
	.P_clk(P_clk),
	.P_reset_n(P_reset_n),
	.start_transfer(start_transfer),
	.rw(P_write),
	.addr(P_addr),
	.wdata(P_wdata),
	.rdata(P_rdata),
	.busy(busy),
	.valid(valid),
	.P_sel(P_sel),
	.P_enable(P_enable),
	.P_ready(P_ready)
	//.P_wdata(P_wdata),
	//.P_addr(P_addr)
);

initial
P_clk = 0;
always #5 P_clk = ~P_clk;

initial
begin
P_reset_n = 0;
start_transfer = 0;
P_write = 0;
P_addr = 0;
P_wdata = 0;
// Apply reset
#20;
P_reset_n = 1;

// --- Write transaction ---
#10;
start_transfer = 1;
P_write = 1;
P_addr = 4'hA;
P_wdata = 8'h55;
              // Write
  // Start transfer
#10;
start_transfer = 0;
#20;

start_transfer = 1;
P_write = 1;
P_addr = 4'hB;
P_wdata = 8'h56;
              // Write
  // Start transfer
#10;
start_transfer = 0;
#20;

// --- Read transaction ---

start_transfer = 1;
P_write = 0; 
P_addr = 4'hA;
             // Read
#20;
//start_transfer = 0;
//#20;

/*if (valid)
      $display("Read data from address 0xA = %h", P_rdata);
*/
start_transfer = 1;
P_write = 0; 
//P_addr = 4'hA;
             // Read
//#20;
//start_transfer = 0;
//#20;
/*if (valid)
	$display("Read data from address 0xB = %h", P_rdata);*/
start_transfer = 1;
P_write = 0; 
P_addr = 4'hB;
             // Read
#20;
//start_transfer = 0;
//#20;

/*if (valid)
      $display("Read data from address 0xA = %h", P_rdata);*/

start_transfer = 1;
P_write = 0; 
P_addr = 4'hA;
#50;
$stop;
end
endmodule