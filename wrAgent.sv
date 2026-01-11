class wrAgent;
	wrGen gen;
	wrBfm bfm;
	wrMon mon;
	wrCov cov;

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
