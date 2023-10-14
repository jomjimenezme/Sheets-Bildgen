set terminal cairolatex pdf color dashed linewidth 8 size 18cm, 7cm
set output 'gp_kurveBSpline.tex'
set xrange [ 6 : 78 ]
set yrange [ -4 : 24 ]
set border 0
#set xlabel '$x$'
#set ylabel '$y$' norotate
set notics
#set grid
set nokey
set label '{\textcolorrgbif{0,0,1}{$t₃$}}' at 24, 15
set label '{\textcolorrgbif{0,0,1}{$t₄$}}' at 33, 10
set label '{\textcolorrgbif{0,0,1}{$t₅$}}' at 39, 3
set label '{\textcolorrgbif{0,0,1}{$t₆$}}' at 48, 4
set label '{\textcolorrgbif{0,0,1}{$t₇$}}' at 58, 10
set label '{\textcolorrgbif{0,0,1}{$t₈$}}' at 62, 4
set label '{\textcolorrgbif{0,0,1}{$t₉$}}' at 68, 18
set label '{\textcolorrgbif{0,0,1}{$t₁₀$}}' at 70, 12
set label '{\textcolorrgbif{1,0,0}{$P₀$}}' at 12, 15
set label '{\textcolorrgbif{1,0,0}{$P₁$}}' at 22, 18
set label '{\textcolorrgbif{1,0,0}{$P₂$}}' at 38, 12
set label '{\textcolorrgbif{1,0,0}{$P₃$}}' at 34, 0
set label '{\textcolorrgbif{1,0,0}{$P₄$}}' at 50, 0
set label '{\textcolorrgbif{1,0,0}{$P₅$}}' at 58, 12
set label '{\textcolorrgbif{1,0,0}{$P₆$}}' at 62, 0
set label '{\textcolorrgbif{1,0,0}{$P₇$}}' at 70, 24
set label '{\textcolorrgbif{1,0,0}{$P₈$}}' at 74, 12
set label '{\textcolorrgbif{1,0,0}{$P₉$}}' at 68, 8
plot '-' with lines lt 1 lc rgb "#00ff00" smooth bezier, \
     '-' with lines lt 1 lc rgb "#00ff00" smooth bezier, \
     '-' with lines lt 1 lc rgb "#00ff00" smooth bezier, \
     '-' with lines lt 1 lc rgb "#00ff00" smooth bezier, \
     '-' with lines lt 1 lc rgb "#00ff00" smooth bezier, \
     '-' with lines lt 1 lc rgb "#00ff00" smooth bezier, \
     '-' with lines lt 1 lc rgb "#00ff00" smooth bezier, \
     '-' with points pt 7 ps 1 lc rgb "#ff0000", \
     '-' with points pt 7 ps 0.5 lc rgb "#0000ff"
24 17
28 16
32 14
34 11
e
34 11
36 8
36 4
38 2
e
38 2
40 0
44 0
48 2
e
48 2
52 4
56 8
58 8
e
58 8
60 8
60 4
62 6
e
62 6
64 8
68 16
70 18
e
70 18
72 20
72 16
71 13
e
12 18
24 18
36 12
36 0
48 0
60 12
60 0
72 24
72 12
66 6
e
24 17
34 11
38 2
48 2
58 8
62 6
70 18
71 13
e
set output
