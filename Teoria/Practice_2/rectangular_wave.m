%--------------------------------------------------------------------------
clear all;
format long eng;
%--------------------------------------------------------------------------
a=5;
f=500e3;
omega=2*pi*f;
t=-2*1/f:1/(600*f):2*1/f;
k=3;   %Harmonics to graph
%--------------------------------------------------------------------------
%Three armonics principals
figure
plot(t,a/2)
grid on;

for m=1:2:2*k
    gt= 2*a/pi.*( 1/m * sin(m*pi/2).*cos(m*omega.*t));
    if (k<4)
        figure
        plot(t,gt)
        grid on;
    end
    max(gt)
    if (max(abs(gt)) ~= 0)
        maxi(1)=max(a/2);
        maxi((m+1)/2+1)= max(abs(gt));
        fid=fopen('maximos.txt','w');
        fprintf(fid,'%f \n',maxi); 
    end
end
sum=0;
for n=1:2:2*k
    sum = sum + 2*a/pi.*( 1/n * sin(n*pi/2).*cos(n*omega.*t));
    ft= a/2 + sum;
end
figure
plot(t,ft);
grid on;