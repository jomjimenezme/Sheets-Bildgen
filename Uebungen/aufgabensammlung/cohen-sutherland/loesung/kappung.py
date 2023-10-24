#!/usr/bin/python3
## Strecken-Clipping
## Autor: Sebastian Birk, Holger Arndt
## Datum: 16.11.2015

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.path import Path
import matplotlib.lines as mlines
import matplotlib.patches as patches

verts = [
    (2., 1.), # LU
    (8., 1.), # RU
    (8., 5.), # RO
    (2., 5.), # LO
    (0., 0.), # ignoriert
    ]

codes = [
    Path.MOVETO,
    Path.LINETO,
    Path.LINETO,
    Path.LINETO,
    Path.CLOSEPOLY,
    ]

path = Path(verts, codes)

fig = plt.figure()
ax = fig.add_subplot(111)

patch = patches.PathPatch(path, facecolor = 'orange', alpha = .6, lw = 2)
ax.add_patch(patch)

x, y = np.array([ [ 0, 12 ], [ 1, 1 ] ])
ax.add_line(mlines.Line2D(x, y, lw = 1, alpha = 0.6, color = 'black'))
x, y = np.array([ [ 0, 12 ], [ 5, 5 ] ])
ax.add_line(mlines.Line2D(x, y, lw = 1, alpha = 0.6, color = 'black'))
x, y = np.array([ [ 2, 2 ], [ -1, 7 ] ])
ax.add_line(mlines.Line2D(x, y, lw = 1, alpha = 0.6, color = 'black'))
x, y = np.array([ [ 8, 8 ], [ -1, 7 ] ])
ax.add_line(mlines.Line2D(x, y, lw = 1, alpha = 0.6, color = 'black'))
ax.text(1, 6, '0110')
ax.text(4, 6, '0100')
ax.text(10, 6, '1100')
ax.text(1, 4, '0010')
ax.text(4, 4, '0000')
ax.text(10, 3, '1000')
ax.text(1, 0, '0011')
ax.text(4, 0, '0001')
ax.text(10, 0, '1001')

#a)
x, y = np.array([ [ 1, 10 ], [ 2, 4 ] ])
line = mlines.Line2D(x, y, lw = 2, alpha = 0.8, color = 'r')
ax.add_line(line)
x, y = np.array([ [ 2, 8 ], [ 20 / 9, 32 / 9 ] ])
line = mlines.Line2D(x, y, lw = 5, alpha = 0.9, color = 'b')
ax.add_line(line)
#b)
x, y = np.array([ [ 3, 6 ], [ 3, 0 ] ])
line = mlines.Line2D(x, y, lw = 2, alpha = 0.8, color = 'r')
ax.add_line(line)
x, y = np.array([ [ 3, 5 ], [ 3, 1 ] ])
line = mlines.Line2D(x, y, lw = 5, alpha = 0.9, color = 'b')
ax.add_line(line)
#c)
x, y = np.array([ [ 7, 10 ], [ 0, 2 ] ])
line = mlines.Line2D(x, y, lw = 2, alpha = 0.8, color = 'r')
ax.add_line(line)
#d)
x, y = np.array([ [ 5, 11 ], [ 6, 4 ] ])
line = mlines.Line2D(x, y, lw = 2, alpha = 0.8, color = 'r')
ax.add_line(line)
x, y = np.array([ [ 7.997, 8.003 ], [ 5.001, 4.999 ] ])
line = mlines.Line2D(x, y, lw = 5, alpha = 0.9, color = 'b')
ax.add_line(line)

ax.set_xlim(0, 12)
ax.set_ylim(-1, 7)
plt.savefig('kappung.png', format = 'png')
plt.show()

