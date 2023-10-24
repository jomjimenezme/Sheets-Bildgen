set terminal cairolatex pdf color dashed linewidth 8 size 8cm, 8cm
set output 'hermiteTypen.tex'
set xrange [ -1 : 5 ]
set yrange [ -1 : 5 ]
set border 0
set notics
#set grid
set nokey
plot '-' with lines lt 1 lc rgb "#ff0000" smooth bezier, \
     '-' with lines lt 1 lc rgb "#00ff00" smooth bezier, \
     '-' with lines lt 1 lc rgb "#0000ff" smooth bezier
0 0
1 1
3 1
4 0
e
0 0
4 4
0 4
4 0
e
0 0
6 6
-2 6
4 0
e
set output
