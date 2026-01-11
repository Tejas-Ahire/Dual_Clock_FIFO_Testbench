class wrTx;
	rand bit [`WIDTH-1:0] wdata;
	rand bit wrEn;
	     bit full,overflow;

	function void print(input string str="This is wrTx");
		$display("(%0t)-----------%s-------------",$time,str);
		$display("wdata:%0d",wdata);
		$display("wrEn:%0d",wrEn);
		$display("full:%0d",full);
		$display("overflow:%0d",overflow);
	endfunction

	constraint wr_c{
		wrEn dist {1 := 70, 0 := 30};
		//wrEn==1'b1;
	}
endclass
