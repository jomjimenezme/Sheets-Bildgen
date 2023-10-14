set terminal cairolatex pdf color dashed linewidth 8 size 8cm, 6cm
set output 'gp_kurveBSplineBasisPolynome.tex'
set xrange [ 0 : 1 ]
set yrange [ -0.2 : 1 ]
set border 3
set xzeroaxis
set xlabel '$t$'
set xtics nomirror 0, 1, 1
set ytics nomirror 0, 1, 1
set key outside spacing 2
plot 1.0 / 6 * (1 - x) ** 3 with lines lt 1 lc rgb "#ff0000" \
     title '$\mathtxtit{BS}₋₃$', \
     1.0 / 6 * (3 * x ** 3 - 6 * x ** 2 + 4) with lines lt 1 lc rgb "#aa0055" \
     title '$\mathtxtit{BS}₋₂$', \
     1.0 / 6 * (-3 * x ** 3 + 3 * x ** 2 + 3 * x + 1) with lines lt 1 lc \
     rgb "#5500aa" title '$\mathtxtit{BS}₋₁$', \
     1.0 / 6 * x ** 3 with lines lt 1 lc rgb "#0000ff" title '$\mathtxtit{BS}₀$'
set output
