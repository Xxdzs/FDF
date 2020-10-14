set terminal png size 1920,1080
set output 'graph.png'

set title 'Comparing transform algorithms'
set xlabel 'Iteration'
set ylabel 'Average delay to transform 1 point (ns)'

plot [:300][:150] "mars0.out" using (column(2)/column(1)) with lines title 'Transform matrix',\
			"mars2.out" u (column(2)/column(1)) w l t 'Transform matrix, compiler optimised',\
			"mars2-DSIMPLISTIC_TRANSFORM.out" u (column(2)/column(1)) w l t 'Simple, compiler optimised',\
			"mars0-DSIMPLISTIC_TRANSFORM.out" u (column(2)/column(1)) w l t 'Simple'