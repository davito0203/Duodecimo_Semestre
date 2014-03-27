%Inicilizacion Programa%
clc
clear all
%Parametros Anillo%
sigma=1/(2.83e-8);  % Conductividad del anillo, en Siemenz;
b=1.8e-2;           % Radio interno del anillo, en metros;
ea=33.75e-3;        % Espesor del anillo en metros;
ha=1.e-3;           % Altura del anillo en metros;
ma=714e-3;          % Masa del anillo en kilogramos masa.
%Parámetros Nucleo%
hn=0.3;             % Altura del núcleo en metros;
dn=2.56e-2;         % Diámetro interno del núcleo en metros;
Ios=10;             % Corriente a través del solenoide en ampérios;
Vos=30;             % Tension aplicado en la terminales de la bobina;
f=60;               % Frecuencia de la red en hertz.
%Parametros Bobina%
N=60*5;             % Número de espiras del solenoide en metros;
L=0.1;              % Longitud del solenoide en metros;
a=2.3e-2;           % Radio del solenoide en metros;
mur=200;            % Permeabilidad relativa del núcleo a 60 Hz;
muo=4*pi*1e-7;      % Permeabilidad del vacio en H/m.
 %Calculando Resistencia e inductancia  del anillo%
Ra=2*pi*b/(sigma*ea*ha);      % Resistencia del anillo
d=sqrt(4*ea*ha/pi);           % Diámetro equivalente del anillo
La=muo*b*(log(16*b/d)-7/4);   % Inductancia propia del anillo
%Graficacion itertiva%
w=2*pi*f;
z=L:0.005:hn;  % Rango a graficar 
P=pi*b*(Ios^2/La)*w^2*La^2/(Ra^2+w^2*La^2);
for i=1:length(z)
    Mi(i)=M(z(i),a,b,L,mur,N);   % Coeficiente de Autoinductancia
    kBr(i)=k(z(i),a,b,L,mur,N);  % Cociente entre el campo radial y Ios
end
% Fuerza media sobre el anillo
Fz=kBr.*Mi*P;
h=figure('Color','w','Units','centimeters','Position',[5 5 15 10]);
xlabel('x [m]')
ylabel('F [N]')
title('F_z media para 0.1\leq x\leq 0.3')
xlim([0.1,0.3]);
hold on
grid on
box on
plot(z,Fz)
saveas(h,'Fz','fig')
saveas(h,'Fz','eps')
saveas(h,'Fz','png')
% Corriente Inducida en el Anillo%
Va=w*Ios*abs(Mi)/Vos;
Ia=w*abs(Mi)/sqrt(Ra^2+w^2*La^2);
h=figure('Color','w','Units','centimeters','Position',[5 5 15 10]);
xlabel('x [m]')
ylabel('Ia/Ios')
title('Magnitud de Ia/Ios para 0.1\leq x\leq 0.3')
xlim([0.1,0.3]);
hold on
grid on
box on
plot(z,Ia)
saveas(h,'Ia','fig')
saveas(h,'Ia','eps')
saveas(h,'Ia','png')
% Voltaje inducido en el anillo%
h=figure('Color','w','Units','centimeters','Position',[5 5 15 10]);
xlabel('x [m]')
ylabel('Va/Vos')
title('Magnitud de Va/Vos para 0.1\leq x\leq 0.3')
xlim([0.1,0.3]);
hold on
grid on
box on
plot(z,Va)
saveas(h,'Va','fig')
saveas(h,'Va','eps')
saveas(h,'Va','png')
%Coeficiente de inducción mutua%
h=figure('Color','w','Units','centimeters','Position',[5 5 15 10]);
xlabel('x [m]')
ylabel('M [H]')
title('M para 0.1\leq x\leq 0.3')
xlim([0.1,0.3]);
hold on
grid on
box on
plot(z,abs(Mi))
saveas(h,'M','fig')
saveas(h,'M','eps')
saveas(h,'M','png')
%Cociente entre el campo radial y Ios%
h=figure('Color','w','Units','centimeters','Position',[5 5 15 10]);
xlabel('x [m]')
ylabel('k [T/A]')
title('k para 0.1\leq x\leq 0.3')
xlim([0.1,0.3]);
hold on
grid on
box on
plot(z,abs(kBr))
saveas(h,'k','fig')
saveas(h,'k','eps')
saveas(h,'k','png')