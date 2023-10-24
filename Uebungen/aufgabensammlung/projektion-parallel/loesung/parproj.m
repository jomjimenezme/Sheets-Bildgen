#!/usr/bin/octave -q

## Datei:  parproj
## Autor:  Holger Arndt
## Datum:  30.11.2006
## modifiziert: 01.12.2008 Sebastian Birk
## Loesung zur Blatt 06, Aufgabe 13

VRP = [ 3 ; 1 ; 10 ]
COP = [ 4 ; 2 ; 15 ]
VPN = [ 2 ; 3 ; 2 ]
#VPN = PRP - VRP
VUP = [ 0 ; 1 ; 0 ]
umin = 0
umax = 40
vmin = 0
vmax = 30
B = 0
F = 10
Q = [ 10 ; 10 ; -10 ]


TVRP = [ 1 0 0 -VRP(1) ; 0 1 0 -VRP(2) ; 0 0 1 -VRP(3) ; 0 0 0 1 ]
normVPN = norm(VPN)
Rz = VPN / normVPN;
VUPxRz = cross(VUP, Rz);
normVUPxRz = norm(VUPxRz);
Rx = VUPxRz / normVUPxRz;
Ry = cross(Rz, Rx);
R = [Rx' 0 ; Ry' 0 ; Rz' 0 ; 0 0 0 1 ]
CW = [ (umax + umin) / 2 ; (vmax + vmin) / 2 ; 0 ; 1 ]
PRP = R * (TVRP * [COP ; 1])
DOP = CW - PRP
SHxpar = -DOP(1) / DOP(3);
SHypar = -DOP(2) / DOP(3);
SHpar = [ 1 0 SHxpar 0 ; 0 1 SHypar 0 ; 0 0 1 0 ; 0 0 0 1 ]
Tpar = [ 1 0 0 -(umax + umin) / 2 ; 0 1 0 -(vmax + vmin) / 2 ; 0 0 1 -F ; 0 0 0 1 ]
Spar = [ 2 / (umax - umin) 0 0 0 ; 0 2 / (vmax - vmin) 0 0 ; 0 0 1 / (F - B) 0 ; 0 0 0 1]

T = Spar*Tpar*SHpar*R*TVRP

Q1 = TVRP * [ Q ; 1 ]
Q2 = R * Q1;
Q3 = SHpar * Q2;
Q4 = Tpar * Q3;
Qproj = Spar * Q4

