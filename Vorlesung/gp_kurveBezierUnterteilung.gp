set terminal cairolatex pdf color dashed linewidth 8 size 18cm, 12cm
set output 'gp_kurveBezierUnterteilung.tex'
set xrange [ 2 : 26 ]
set yrange [ 2 : 18 ]
set border 0
#set xlabel '$x$'
#set ylabel '$y$' norotate
set notics
#set grid
set nokey
set label '[l]{$P₁ = P⁰₁ = \textcolorrgbif{1,0,0}{Pᴸ₁}$}' at 4.5 , 4
set label '{$P₂ = P⁰₂$}' at 4 , 17
set label '{$P₃ = P⁰₃$}' at 20 , 17
set label '[l]{$P₄ = P⁰₄ = \textcolorrgbif{0,0,1}{Pᴿ₄}$}' at 24.5 , 8
set label '[r]{$P¹₁ = \textcolorrgbif{1,0,0}{Pᴸ₂}$}' at 3.5 , 10
set label '{$P¹₂$}' at 12 , 17
set label '[l]{$P¹₃ = \textcolorrgbif{0,0,1}{Pᴿ₃}$}' at 22.5 , 12
set label '[r]{$P²₁ = \textcolorrgbif{1,0,0}{Pᴸ₃}$}' at 7.5 , 13
set label '[l]{$P²₂ = \textcolorrgbif{0,0,1}{Pᴿ₂}$}' at 17.2 , 14.5
set label '{$Q\fk{\frac12} = P³₁ = \textcolorrgbif{1,0,0}{Pᴸ₄} = \textcolorrgbif{0,0,1}{Pᴿ₁}$}' at 13 , 12
plot '-' with lines lt 1 lc rgb "#ff0000" smooth bezier, \
     '-' with lines lt 1 lc rgb "#0000ff" smooth bezier, \
     '-' with lines lt 7 lc rgb "#000000", \
     '-' with lines lt 7 lc rgb "#000000", \
     '-' with lines lt 7 lc rgb "#000000", \
     '-' with points pt 7 ps 0.7 lc rgb "#00cc00"
4 4
4 10
8 13
12.5 13.5
e
12.5 13.5
17 14
22 12
24 8
e
4 4
4 16
20 16
24 8
e
4 10
12 16
22 12
e
8 13
17 14
e
4 4
4 16
20 16
24 8
4 10
12 16
22 12
8 13
17 14
12.5 13.5
e
set output
