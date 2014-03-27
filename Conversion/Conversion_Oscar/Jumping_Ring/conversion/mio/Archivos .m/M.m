% Programa auxiliar 2: C�lculo del coeficiente de inducci�n mutua entre el
% anillo y la bobina.

%%% Datos de entrada:
% a: radio del solenoide,
% b: radio interno del n�cleo,
% L: longitud del solenoide,
% N: n�mero de espiras del solenoide,
% mur: permeabilidad relativa del n�cleo,
% z: altura del centro geom�trico del anillo.
function w=M(z,a,b,L,mur,N)
muo=4*pi*1e-7;
K=muo*mur*N*a/2;
F=@(r,z1,t1)F2(r,a,z,z1,t1);
w=K*triplequad(F,0,b,0,L,0,2*pi);