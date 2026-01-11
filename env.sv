class fifoEnv;
	wrAgent wrA;
	rdAgent rdA;
	fifoSbd sbd;

	task run();
		//$display("ENV Running");
		wrA=new();
		rdA=new();
		sbd=new();

		fork
			wrA.run();
			rdA.run();
			sbd.run();
			sbd.run2();
		join
	endtask
endclass
