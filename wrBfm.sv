class wrBfm;
	wrTx tx;
	virtual fifoInterface vif;

	task run();
		vif=tb.pif;
		forever begin
			fifoCommon::wrGen2Bfm.get(tx);
			driveTx(tx);
			//tx.print("WriteBfm Printing");
			fifoCommon::wrBfmCount++;
			$display("WrBfmCount:%0d",fifoCommon::wrBfmCount);
		end
	endtask

	task driveTx(wrTx tx);
		@(posedge vif.wrClk);
		vif.wrEn<=tx.wrEn;
		vif.wdata<=tx.wdata;
		tx.full=vif.full;
		tx.overflow=vif.overflow;
		@(posedge vif.wrClk);
		vif.wrEn<=0;
		vif.wdata<=0;
	endtask
endclass
