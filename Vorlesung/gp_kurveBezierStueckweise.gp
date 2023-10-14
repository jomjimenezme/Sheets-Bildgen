set terminal cairolatex pdf color dashed linewidth 8 size 14cm, 10cm
set output 'gp_kurveBezierStueckweise.tex'
set xrange [ 0 : 14 ]
set yrange [ 0 : 10 ]
set border 0
#set xlabel '$x$'
#set ylabel '$y$' norotate
set notics
#set grid
set nokey
set label '{\textcolorrgbif{1,0,0}{$P₁ = Q₁$}}' at 3, 2.2
set label '{\textcolorrgbif{1,0,0}{$P₄ = Q₂$}}' at 6, 8.2
set label '{\textcolorrgbif{1,0,0}{$P₇ = Q₃$}}' at 12, 2.2
set label '{\textcolorrgbif{1,0,0}{$P₁₀ = Q₄$}}' at 12, 6.6
plot '-' with lines lt 1 lc rgb "#00ff00" smooth bezier, \
     '-' with lines lt 1 lc rgb "#00ff00" smooth bezier, \
     '-' with lines lt 1 lc rgb "#00ff00" smooth bezier, \
     '-' with points pt 7 ps 1 lc rgb "#ff0000", \
     '-' with points pt 7 ps 0.5 lc rgb "#0000ff"
     3 3
     3.75 6
     4.5 9
     6 9
     e
     6 9
     7.5 9
     11 3.5
     12 3
     e
     12 3
     13 2.5
     12.5 4.25
     12 6
     e
     3 3
     6 9
     12 3
     12 6
     e
     3.75 6
     4.5 9
     7.5 9
     11 3.5
     13 2.5
     12.5 4.25
     e
     set output
