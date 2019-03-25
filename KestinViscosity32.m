%Declaração de variaveis%
clear all
close all
clc
a=importdata('salinity32.txt');
P32=a'
%Script to test an algorythim that calculates Viscosity using Kestin Model%
T32=[19.5 25 31 40 55 70 84 98.5 113 131.5 154]; %T em C%
S32=3.2672; % Solubilida em mol/kg%
%Pressão em Mpa%
%% Parte 1 da equação
A = Am(S32);
B = Bm(S32);
C = Cm(T32);
M = C+log10(1002); % visco em Pa^-6
M0 = A + B.*C;
Milog=M0+M;
Mi = 10.^(Milog);
%% Parte 2 da equação
bw = Bw(T32);
bs = Bs(T32,bw);
Ms = ms(T32);
bp = Bp(S32,Ms);
Beta = bw+bp.*bs;
Visc32 = Viscosity2(P32,Mi,Beta);
%% Análise do erro
mat = importdata('salinity32_2.txt');
Real_Visc32 = mat';
error32 = (abs(Visc32 - Real_Visc32))*100./Real_Visc32;
figure
%% Analise grafica
for i=1:8
plot(P32(i,:),Visc32(i,:),'r-')
hold on
end

for i=1:8
plot(P32(i,:),Real_Visc32(i,:),'b-')
hold on
end
title('Pressure vs Viscosity')
xlabel('Pressure in Mpa');
ylabel('Viscosity in MicroPa.S')
legend('Calculated in red','Measured in blue')
%%Análise estatistica
for i=1:11
    %Consertar medidas com NAN
    variance32(i)=var(error32(i,:));
    media32(i)=mean(error32(i,:));
end
%%
T32=T32';
T32=repmat(T32,1,12);
figure
surf(Real_Visc32,P32,T32,'FaceColor','g', 'FaceAlpha',0.5, 'EdgeColor','none')
hold on
surf(Visc32,P32,T32,'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none')
xlabel('Viscosity in Micro Pa.s')
ylabel('Pressure in Mpa')
zlabel('Temperature in Celsius')
legend('Calculated Viscosity','Measured Viscosity')
hold off
%% Plot do erro
hold off
figure
surf(error32,P32,T32,'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none')
xlabel('Viscosity error in Micro Pa.s')
ylabel('Pressure in Mpa')
zlabel('Temperature in Celsius')
legend('Viscosity error')
hold off
figure
plot(P32(1,:),error32(1,:),'b-')
hold on
plot(P32(2,:),error32(2,:),'k-')
plot(P32(3,:),error32(3,:),'g-')
plot(P32(4,:),error32(4,:),'o-')
plot(P32(5,:),error32(5,:),'r-')
plot(P32(6,:),error32(6,:),'c-')
plot(P32(7,:),error32(7,:),'m-')
plot(P32(8,:),error32(8,:),'y-')
plot(P32(9,:),error32(9,:),'b-')
plot(P32(10,:),error32(10,:),'k-')
plot(P32(11,:),error32(11,:),'g-')
title('Pressure vs Viscosity error')
xlabel('Pressure in Mpa');
ylabel('Viscosity error in MicroPa.S')
save all