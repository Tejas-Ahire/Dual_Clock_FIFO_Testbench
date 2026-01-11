class rdMon;
	rdTx tx;
	virtual fifoInterface vif;
	static int count=0;

	task run();
		vif=tb.pif;
		forever begin
				@(vif.rdMonCb);
			//if(vif.rdMonCb.rdEn==1)begin
				tx=new();
				tx.rdEn=vif.rdMonCb.rdEn;
				tx.empty=vif.rdMonCb.empty;
				tx.underflow=vif.rdMonCb.underflow;
				fifoCommon::rdMon2Sbd.put(tx);
				fifoCommon::rdMon2Cov.put(tx);
				//wait(vif.rdMonCb.rdata>0);
				if(vif.rdMonCb.rdEn==1)begin
					count++;
					if(fifoCommon::testName=="MISMATCH" && count>1)begin 
                		tx.rdata=~vif.rdMonCb.rdata;
					end
					else begin
						tx.rdata=vif.rdMonCb.rdata;
					end
					tx.print("Read Monitor Printing");
				end 
				else begin
					tx.rdata=0;
				end
			//end
		end
	endtask

endclass

