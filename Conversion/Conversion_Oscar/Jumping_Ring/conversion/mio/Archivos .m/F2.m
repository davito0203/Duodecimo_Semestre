%Programa auxiliar del programa auxiliar 2
function w=F2(r,a,z,z1,t1)
w=(r.*(a*cos(t1)-r)./(((z-z1).^2+a^2+r.^2-2*a.*r.*cos(t1)).^1.5));