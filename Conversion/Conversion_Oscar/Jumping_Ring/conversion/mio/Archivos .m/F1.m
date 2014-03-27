%Programa auxiliar del programa auxiliar 1
function w=F1(z,z1,t1,a,b)
w=((z-z1).*cos(t1)./(((z-z1).^2+a^2+b^2-2*a*b*cos(t1)).^1.5));