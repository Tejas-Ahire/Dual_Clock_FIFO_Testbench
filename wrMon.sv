class wrMon;
	wrTx tx;
	virtual fifoInterface vif;

	task run();
		vif=tb.pif;
		forever begin
			@(vif.wrMonCb);
			//if(vif.wrMonCb.wrEn==1)begin
				tx=new();
				tx.wrEn=vif.wrMonCb.wrEn;
				tx.wdata=vif.wrMonCb.wdata;
				tx.full=vif.wrMonCb.full;
				tx.overflow=vif.wrMonCb.overflow;
				//if(tx.wrEn==1) 
				fifoCommon::wrMon2Sbd.put(tx);
				fifoCommon::wrMon2Cov.put(tx);
				tx.print("Write Monitor Printing");
			//end
		end
	endtask
endclass
