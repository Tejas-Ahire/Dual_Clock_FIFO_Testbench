class rdAgent;
	rdGen gen;
	rdBfm bfm;
	rdMon mon;
	rdCov cov;

	task run();
		gen=new();
		bfm=new();
		mon=new();
		cov=new();

		fork
			gen.run();
			bfm.run();
			mon.run();
			cov.run();
		join
	endtask
endclass

