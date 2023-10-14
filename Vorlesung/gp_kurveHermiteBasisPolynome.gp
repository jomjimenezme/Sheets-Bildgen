set terminal cairolatex pdf color dashed linewidth 8 size 8cm, 6cm
set output 'gp_kurveHermiteBasisPolynome.tex'
set xrange [ 0 : 1 ]
set yrange [ -0.2 : 1 ]
set border 3
set xzeroaxis
set xlabel '$t$'
set xtics nomirror 0, 1, 1
set ytics nomirror 0, 1, 1
set key outside spacing 2
plot 2 * x ** 3 - 3 * x ** 2 + 1 with lines lt 1 lc rgb "#ff0000" \
     title '$P₁$', \
     -2 * x ** 3 + 3 * x ** 2 with lines lt 1 lc rgb "#0000ff" title '$P₄$', \
     x ** 3 - 2 * x ** 2 + x with lines lt 1 lc rgb "#ff8888" title '$R₁$', \
     x ** 3 - x ** 2 with lines lt 1 lc rgb "#8888ff" title '$R₄$'
     set output
