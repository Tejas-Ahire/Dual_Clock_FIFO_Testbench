class wrGen;
	wrTx tx;

	task run();
		case(fifoCommon::testName)
			"FULL":begin
				fifoCommon::wrGenCount=`FIFO_SIZE;
				writes2(`FIFO_SIZE);
			end
			"EMPTY":begin
				writes(`FIFO_SIZE);
				fifoCommon::wrGenCount=`FIFO_SIZE;
			end
			"OVERFLOW":begin
				writes2(`FIFO_SIZE+1);
				fifoCommon::wrGenCount=`FIFO_SIZE+1;	
			end
			"UNDERFLOW":begin
				writes(`FIFO_SIZE-1);
				fifoCommon::wrGenCount=`FIFO_SIZE-1;
			end
			"CONCURRENT":begin
				writes(`FIFO_SIZE);
				fifoCommon::wrGenCount=`FIFO_SIZE;
			end
			"TOGGLE":begin
				fifoCommon::wrGenCount=`FIFO_SIZE *3;
				writes2(`FIFO_SIZE * 3);
			end
			"MISMATCH":begin
				writes(`FIFO_SIZE);
				fifoCommon::wrGenCount = `FIFO_SIZE; 
                for(int i = 0; i < `FIFO_SIZE; i++) begin
                    tx = new();
                    tx.randomize();
                    if(i > 0) begin
                        tx.wdata = tx.wdata + 1; 
                    end
                    fifoCommon::wrGen2Bfm.put(tx);
                end
			end
			default:$display("Invalid case...");
		endcase
	endtask

	task writes(input int N);
		repeat(N)begin
			tx=new();
			tx.randomize();
			fifoCommon::wrGen2Bfm.put(tx);
			//tx.print("WriteGen Printing");
		end
	endtask
	task writes2(input int N);
		repeat(N)begin
			tx=new();
			tx.randomize() with {wrEn==1;};
			fifoCommon::wrGen2Bfm.put(tx);
			//tx.print("WriteGen Printing");
		end
	endtask
endclass
