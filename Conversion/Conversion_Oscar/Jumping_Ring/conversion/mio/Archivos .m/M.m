% Programa auxiliar 2: Cálculo del coeficiente de inducción mutua entre el
% anillo y la bobina.

%%% Datos de entrada:
% a: radio del solenoide,
% b: radio interno del núcleo,
% L: longitud del solenoide,
% N: número de espiras del solenoide,
% mur: permeabilidad relativa del núcleo,
% z: altura del centro geométrico del anillo.
function w=M(z,a,b,L,mur,N)
muo=4*pi*1e-7;
K=muo*mur*N*a/2;
F=@(r,z1,t1)F2(r,a,z,z1,t1);
w=K*triplequad(F,0,b,0,L,0,2*pi);