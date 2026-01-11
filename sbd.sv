class fifoSbd;
	wrTx wtx;
	rdTx rtx;
	int que[$];	
	int data;
	task run();
		//$display("SBD Running");
		forever begin
			fifoCommon::wrMon2Sbd.get(wtx);
			wtx.print("Write Sbd Printing");
			if(wtx.wrEn==1)begin
				que.push_back(wtx.wdata);
			end
			else $display("Hello!!!!");
		end
	endtask

	task run2();
		forever begin	
			fifoCommon::rdMon2Sbd.get(rtx);
			rtx.print("Read Sbd Printing");
			wait(que.size()!=0);
			if(rtx.rdEn==1)begin
				data=que.pop_front();
				if(data==rtx.rdata) fifoCommon::matching++;
				else fifoCommon::mismatching++;
			end
			else $display("Hello Again!!!!!");
		end
	endtask
endclass
