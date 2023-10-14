set terminal cairolatex pdf color dashed linewidth 8 size 5cm, 5cm
set output 'gp_kurveZusammengesetzt.tex'
set xrange [ 0 : 10 ]
set yrange [ 0 : 10 ]
set border 3
set xlabel '$x$'
set ylabel '$y$\quad' norotate
set notics
#set grid
set nokey
set label '\textcolorrgbif{1,0,0}{$Q₁$}' at 1.5, 4.5
set label '\textcolorrgbif{0,0,1}{$Q₂$}' at 5.5, 3.5
plot '-' with lines lt 1 lc rgb "#ff0000" smooth bezier, \
     '-' with lines lt 2 lc rgb "#0000ff" smooth bezier
     1 1
     1 4
     2 4
     4 2
     e
     4 2
     5 1
     9 1
     9 9
     e
     set output
