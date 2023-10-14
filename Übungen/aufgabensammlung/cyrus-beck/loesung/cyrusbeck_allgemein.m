#!/usr/bin/octave -q

## Datei:  cyrusbeck.m
## Autor:  Holger Arndt
## Datum:  13.11.2006
## modifiziert: 10.11.2008 Sebastian Birk
## Loesung zur Blatt 04, Aufgabe 07

ecken = [5 10 1; 2 7 7];   # die drei Eckpunkte als Spaltenvektoren

n = size(ecken, 2);
ecken = [ecken ecken(:, 1)];  # (n+1)-ste Ecke = 1. Ecke

kanten = ecken(:, 2 : n + 1) - ecken(:, 1 : n);

normalen = [kanten(2, :); -kanten(1, :)];
for i = 1 : n
  normalen(:, i) = normalen(:, i) ./ norm(normalen(:, i));
endfor

linien = [ 1  2  6  6;         # zeilenweise p0.x,p0.y,p1.x,p1.y
           3  2  9  2;
           10 8 12  1;
           6  1  6  8;
           3  6  7  5];
linien = linien';
m = size(linien, 2);

for j = 1 : m                 # alle Linien
  p0 = linien(1 : 2, j);
  p1 = linien(3 : 4, j);
  d = p1 - p0;
  if all(p1 == p0)
    printf("entartete Linie (Punkt)\n");
  else
    tE = 0;
    tL = 1;
    for i = 1 : n             # alle Kappungskanten
      ni = normalen(:, i);
      nid = ni' * d;
      if nid != 0
        t = -(ni' * (p0 - ecken(:, i))) / (ni' * d);
        if (nid < 0)
          tE = max(tE, t);
        else
          tL = min(tL, t);
        endif
      endif
    endfor
    if tE > tL
      printf("kein Schnittpunkt\n");
    else
      ptE = p0 + tE * d;
      ptL = p0 + tL * d;
      printf("Linie [(%g,%g)-(%g,%g)] wird gekappt zu: [(%g,%g)-(%g,%g)]\n",
             p0, p1, ptE, ptL);
    endif
  endif
endfor
