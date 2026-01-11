class rdTx;
	rand bit rdEn;
	     bit [`WIDTH-1:0] rdata;
	     bit empty,underflow;

	function void print(input string str="This is rdTx");
		$display("(%0t)------------%s------------",$time,str);
		$display("rdata:%0d",rdata);
		$display("rdEn:%0d",rdEn);
		$display("empty:%0d",empty);
		$display("underflow:%0d",underflow);
	endfunction

	constraint rd_c{
		//rdEn==1'b1;
		rdEn dist {1 := 70, 0 := 30};
	}
endclass

