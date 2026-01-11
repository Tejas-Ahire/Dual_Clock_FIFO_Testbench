class wrCov;
	wrTx tx;

	covergroup wcg;
		coverpoint tx.wrEn{
			bins WRITES={1'b1};
		}
	endgroup
	
	function new();
		wcg=new();
	endfunction

	task run();
		forever begin
			fifoCommon::wrMon2Cov.get(tx);
			wcg.sample();
			tx.print("Write Coverage Printing");
		end
	endtask
endclass
