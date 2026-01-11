class rdBfm;
	rdTx tx;
	virtual fifoInterface vif;

	task run();
		vif=tb.pif;
		forever begin
			fifoCommon::rdGen2Bfm.get(tx);
			driveTx(tx);
			//tx.print("WriteBfm Printing");
		end
	endtask

	task driveTx(rdTx tx);
		@(posedge vif.rdClk);
		vif.rdEn<=tx.rdEn;
		//wait(vif.rdata!=0);
		tx.rdata=vif.rdata;
		tx.empty=vif.empty;
		tx.underflow=vif.underflow;
		@(posedge vif.rdClk);
		vif.rdEn<=0;
	endtask
endclass

