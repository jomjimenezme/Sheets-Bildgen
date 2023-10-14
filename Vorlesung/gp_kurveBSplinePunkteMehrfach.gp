set terminal cairolatex pdf color dashed linewidth 1 size 18cm, 6cm
set output 'gp_kurveBSplinePunkteMehrfach.tex'
set xrange [ -1 : 25 ]
set yrange [ -1 : 13 ]
set border 0
#set xlabel '$x$'
#set ylabel '$y$' norotate
set notics
#set grid
set key right bottom spacing 4
#set nokey
plot '-' with points pt 7 ps 2 lc rgb "#ffdfdf" notitle, \
     '-' with lines lt 1 lw 18 lc rgb "#00ff00" smooth bezier title 'einfach', \
     '-' with lines lt 1 lw 18 lc rgb "#00ff00" smooth bezier notitle, \
     '-' with lines lt 1 lw 12 lc rgb "#0000ff" smooth bezier title 'doppelt', \
     '-' with lines lt 1 lw 12 lc rgb "#0000ff" smooth bezier notitle, \
     '-' with lines lt 1 lw 12 lc rgb "#0000ff" smooth bezier notitle, \
     '-' with lines lt 1 lw 6 lc rgb "#ff0000" smooth bezier \
     title 'dreifach', \
     '-' with lines lt 1 lw 6 lc rgb "#ff0000" smooth bezier notitle, \
     '-' with lines lt 1 lw 6 lc rgb "#ff0000" smooth bezier notitle, \
     '-' with lines lt 1 lw 6 lc rgb "#ff0000" smooth bezier notitle, \
     '-' with points notitle
0 12
6 12
12 0
18 12
24 12
e
6 10
8 8
10 4
12 4
e
12 4
14 4
16 8
18 10
e
6 10
8 8
10 4
11 2
e
11 2
12 0
12 0
13 2
e
13 2
14 4
16 8
18 10
e
6 10
8 8
10 4
11 2
e
11 2
12 0
12 0
12 0
e
12 0
12 0
12 0
13 2
e
13 2
14 4
16 8
18 10
e
1000 1000 # dummy
e
set output
