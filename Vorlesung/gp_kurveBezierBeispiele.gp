set terminal cairolatex pdf color dashed linewidth 8 size 13cm, 5cm
set output 'gp_kurveBezierBeispiele.tex'
set xrange [ 0 : 13 ]
set yrange [ 0 : 5 ]
set border 3
set xlabel '$x$'
set ylabel '$y$\quad' norotate
set notics
#set grid
set nokey
set label '{\textcolorrgbif{1,0,0}{$P₁$}}' at 0.5, 1
set label '{\textcolorrgbif{1,0,0}{$P₂$}}' at 1.5, 4
set label '{\textcolorrgbif{1,0,0}{$P₃$}}' at 3.5, 4
set label '{\textcolorrgbif{1,0,0}{$P₄$}}' at 6.5, 2
set label '{\textcolorrgbif{0,0,1}{$P₁$}}' at 8.5, 2
set label '{\textcolorrgbif{0,0,1}{$P₂$}}' at 10.5, 4
set label '{\textcolorrgbif{0,0,1}{$P₃$}}' at 12.5, 1
set label '{\textcolorrgbif{0,0,1}{$P₄$}}' at 12.5, 4
plot '-' with lines lt 1 lc rgb "#ff0000" smooth bezier, \
     '-' with points pt 7 ps 0.5 lc rgb "#ff0000", \
     '-' with lines lt 1 lc rgb "#0000ff" smooth bezier, \
     '-' with points pt 7 ps 0.5 lc rgb "#0000ff"
     1 1
     2 4
     3 4
     6 2
     e
     1 1
     2 4
     3 4
     6 2
     e
     9 2
     11 4
     12 1
     12 4
     e
     9 2
     11 4
     12 1
     12 4
     e
     set output
