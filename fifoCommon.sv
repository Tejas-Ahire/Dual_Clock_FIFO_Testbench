`define WIDTH 8
`define FIFO_SIZE 16
`define PTR_WIDTH $clog2(`FIFO_SIZE)

class fifoCommon;
	static string testName;
	static mailbox wrGen2Bfm=new();
	static mailbox rdGen2Bfm=new();
	static mailbox wrMon2Cov=new();
	static mailbox wrMon2Sbd=new();
	static mailbox rdMon2Cov=new();
	static mailbox rdMon2Sbd=new();
	static int wrGenCount,wrBfmCount;
	static int matching,mismatching;
endclass

