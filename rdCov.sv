class rdCov;
	rdTx tx;

	
	covergroup rcg;
		coverpoint tx.rdEn{
			bins READS={1'b1};
		}
	endgroup
	
	function new();
		rcg=new();
	endfunction
	
	task run();
		forever begin
			fifoCommon::rdMon2Cov.get(tx);
			rcg.sample();
			tx.print("Read Coverage Printing");
		end
	endtask
endclass

