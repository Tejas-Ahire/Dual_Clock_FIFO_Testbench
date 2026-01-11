class rdGen;
	rdTx tx;

	task run();
		case(fifoCommon::testName)
			"FULL":begin
		    	wait(tb.pif.full == 1);	
			end
			"EMPTY":begin
				wait(fifoCommon::wrGenCount==fifoCommon::wrBfmCount);
				reads(`FIFO_SIZE);
			end
			"OVERFLOW":begin
				
			end
			"UNDERFLOW":begin
				wait(fifoCommon::wrGenCount==fifoCommon::wrBfmCount);
				reads(`FIFO_SIZE);
			end
			"CONCURRENT":begin
				repeat(5)@(tb.pif.rdClk);
				reads(`FIFO_SIZE);
			end
			"TOGGLE":begin
				wait(fifoCommon::wrGenCount==fifoCommon::wrBfmCount);
				reads(`FIFO_SIZE *3);
			end
			"MISMATCH":begin
				wait(fifoCommon::wrGenCount==fifoCommon::wrBfmCount);
				reads(`FIFO_SIZE);
			end
			default:$display("Invalid case...");
		endcase
	endtask

	task reads(input int N);
		repeat(N)begin
			tx=new();
			tx.randomize() with {rdEn==1;};
			fifoCommon::rdGen2Bfm.put(tx);
			//tx.print("ReadGen Printing");
		end
	endtask
endclass

