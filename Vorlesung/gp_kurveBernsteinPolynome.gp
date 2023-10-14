set terminal cairolatex pdf color dashed linewidth 8 size 8cm, 6cm
set output 'gp_kurveBernsteinPolynome.tex'
set xrange [ 0 : 1 ]
set yrange [ -0.2 : 1 ]
set border 3
set xzeroaxis
set xlabel '$t$'
set xtics nomirror 0, 1, 1
set ytics nomirror 0, 1, 1
set key outside spacing 2
plot (1 - x) ** 3 with lines lt 1 lc rgb "#ff0000" title '$B₀$', \
     3 * x * (1 - x) ** 2 with lines lt 1 lc rgb "#aa0055" title '$B₁$', \
     3 * x ** 2 * (1 - x) with lines lt 1 lc rgb "#5500aa" title '$B₂$', \
     x ** 3 with lines lt 1 lc rgb "#0000ff" title '$B₃$'
     set output
