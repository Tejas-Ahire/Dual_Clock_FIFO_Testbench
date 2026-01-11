`include "list.svh"
module tb;
	reg rdClk,wrClk,reset;
	fifoEnv env;
	fifoInterface pif(wrClk,rdClk,reset);
	


	asyfifo dut(.wr_clk(pif.wrClk),
				.rd_clk(pif.rdClk),
				.wdata_i(pif.wdata),
				.rdata_o(pif.rdata),
				.full_o(pif.full),
				.overflw_o(pif.overflow),
				.empty_o(pif.empty),
				.underflw_o(pif.underflow),
				.wrEn_i(pif.wrEn),
				.rdEn_i(pif.rdEn),
				.rst(pif.reset)
	);

	always #5 wrClk=~wrClk;
	always #7 rdClk=~rdClk;

	initial begin
		$value$plusargs("testName=%s",fifoCommon::testName);
		wrClk=0;
		rdClk=0;
		reset=1;
		repeat(2)@(posedge wrClk);
		reset=0;
		env=new();
		env.run();

	end
		
	initial begin
		#800;
		if(fifoCommon::matching!=0 && fifoCommon::mismatching==0)begin
			$display("Test passed");
			$display("Matchings:%0d  || Mismatchings:%0d",fifoCommon::matching,fifoCommon::mismatching);
		end
		else begin	
			$display("Test failed");
			$display("Matchings:%0d  || Mismatchings:%0d",fifoCommon::matching,fifoCommon::mismatching);
		end
		$finish;
	end

endmodule
