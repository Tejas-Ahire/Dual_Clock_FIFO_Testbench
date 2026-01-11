interface fifoInterface(input reg wrClk,rdClk,reset);
	bit wrEn,rdEn;
	bit [`WIDTH-1:0] wdata,rdata;
	bit full,overflow,underflow,empty;

	clocking wrBfmCb @(posedge wrClk);
		default input #0 output #1;
		input full,overflow;
		output wrEn,wdata;
	endclocking


	clocking rdBfmCb @(posedge rdClk);
		default input #0 output #1;
		input rdata,empty,underflow;
		output rdEn;
	endclocking


	clocking wrMonCb @(posedge wrClk);
		default input #1;
		input #0 full,overflow;
		input wrEn,wdata;
	endclocking


	clocking rdMonCb @(posedge rdClk);
		default input #1;
		input rdEn,underflow;
		input #0 empty,rdata;
	endclocking
endinterface
