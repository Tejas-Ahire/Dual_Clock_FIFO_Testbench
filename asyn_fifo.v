module asyfifo(rd_clk,wr_clk,rst,rdEn_i,wrEn_i,rdata_o,wdata_i,full_o,empty_o,underflw_o,overflw_o);
parameter DEPTH=16;
parameter DATA_WIDTH=8;
parameter PTR_WIDTH=$clog2(DEPTH);

//inout ports
input rd_clk,wr_clk,rst,rdEn_i,wrEn_i;
output reg full_o,empty_o,underflw_o,overflw_o;
output reg [DATA_WIDTH-1:0] rdata_o;
input [DATA_WIDTH-1:0] wdata_i;

reg [PTR_WIDTH-1:0] wr_ptr,rd_ptr,wr_ptr_rd_clk,rd_ptr_wr_clk;
reg wrTgl,rdTgl,wr_toggle_rd_clk,rd_toggle_wr_clk;
integer i;

reg [DATA_WIDTH-1:0] fifo [DEPTH-1:0];

always@(posedge wr_clk)begin
	if(rst==1)begin
			full_o=0;
			empty_o=1;
			underflw_o=0;
			overflw_o=0;
			rdata_o=0;
			wr_ptr=0;
			rd_ptr=0;
			wrTgl=0;
			rdTgl=0;
			for(i=0;i<DEPTH;i=i+1)
				fifo[i]=0;
	end else begin
		overflw_o=0;
		underflw_o=0;
		if(wrEn_i==1)begin
			if(full_o==1)begin
				overflw_o=1;
			end
			else begin
				fifo[wr_ptr]=wdata_i;
				if(wr_ptr==DEPTH-1)begin	
					wrTgl=~wrTgl;
				end
				wr_ptr=wr_ptr+1;
			end
	end
end
end
always@(posedge rd_clk)begin
	if (rst==0)begin
		if(rdEn_i==1)begin
			if(empty_o==1)begin
				underflw_o=1;
			end
			else begin
				rdata_o=fifo[rd_ptr];
				if(rd_ptr==DEPTH-1)begin
					rdTgl=~rdTgl;
				end
				rd_ptr=rd_ptr+1;
			end
		end
	end
end
always@(posedge rd_clk)begin
	wr_ptr_rd_clk=wr_ptr;
	wr_toggle_rd_clk=wrTgl;
end
always@(posedge wr_clk)begin
	rd_ptr_wr_clk=rd_ptr;
	rd_toggle_wr_clk=rdTgl;
end

always@(*)begin
	full_o=0;
	empty_o=0;
	if(wr_ptr==rd_ptr_wr_clk && wrTgl!=rd_toggle_wr_clk)begin
		full_o=1;
	end
	if(wr_ptr==rd_ptr_wr_clk && wrTgl==rd_toggle_wr_clk)begin
		empty_o=1;
	end
end
endmodule



