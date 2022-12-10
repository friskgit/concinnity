lilysrc := chords.ly
grep := /usr/bin/grep
tr := /usr/bin/tr
pl := /usr/bin/perl
regexp := '[0-9]\+\/[0-9]\+'
ratios := ratios.txt
ratiosc := ratios_sc.txt
script := ./make_scarray.pl

ratios :
	$(grep) $(regexp) $(lilysrc) >> $(ratios)
	$(tr) -d " " < $(ratios) >> $(ratiosc)
	$(pl) $(script)
