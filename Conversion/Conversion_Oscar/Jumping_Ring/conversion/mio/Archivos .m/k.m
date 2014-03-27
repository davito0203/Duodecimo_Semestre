% Programa auxiliar 1: Cálculo de k(z)

%%% Datos de entrada:
% a: radio del solenoide,
% b: radio del anillo,
% L: longitud del solenoide,
% N: número de espiras del solenoide,
% mur: permeabilidad relativa del núcleo,
% z: altura del centro geométrico del anillo.
function w=k(z,a,b,L,mur,N)
muo=4*pi*1e-7;
K=muo*mur*N*a/(4*pi);
F=@(z1,t1)F1(z,z1,t1,a,b);
w=K*dblquad(F,0,L,0,2*pi);