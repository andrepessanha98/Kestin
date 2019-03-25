%Declaração de variaveis%
clear all
close all
clc
a=importdata('salinity14.txt');
b=importdata('salinity14_2.txt');
P14=[a b]';
%Script to test an algorythim that calculates Viscosity using Kestin Model%
T14=[19 25 30 40.5 54 70 78.5 95 120 135.5 152]; %T em C%
S14=1.4713; % Solubilida em mol/kg%
%Pressão em Mpa%
%% Parte 1 da equação
A = Am(S14);
B = Bm(S14);
C = Cm(T14);
M = C+log10(1002); % visco em Pa^-6
M0 = A + B.*C;
Milog=M0+M;
Mi = 10.^(Milog);
%% Parte 2 da equação
bw = Bw(T14);
bs = Bs(T14,bw);
Ms = ms(T14);
bp = Bp(S14,Ms);
Beta = bw+bp.*bs;
Visc14 = Viscosity2(P14,Mi,Beta);
%% Análise do erro
mat = importdata('salinity14_3.txt');
Real_Visc14 = mat';
error14 = (abs(Visc14 - Real_Visc14))*100./Real_Visc14;
figure
%% Analise grafica
for i=1:8
plot(P14(i,:),Visc14(i,:),'r-')
hold on
end
for i=1:8
plot(P14(i,:),Real_Visc14(i,:),'b-')
hold on
end
title('Pressure vs Viscosity')
xlabel('Pressure in Mpa');
ylabel('Viscosity in MicroPa.S')
legend('Calculated in red','Measured in blue')
%%Análise estatistica
for i=1:11
    %Consertar medidas com NAN
    variance14(i)=var(error14(i,:));
    media14(i)=mean(error14(i,:));
end
%%
T14=T14';
T14=repmat(T14,1,10);
figure
surf(Real_Visc14,P14,T14,'FaceColor','g', 'FaceAlpha',0.5, 'EdgeColor','none')
hold on
surf(Visc14,P14,T14,'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none')
xlabel('Viscosity in Micro Pa.s')
ylabel('Pressure in Mpa')
zlabel('Temperature in Celsius')
legend('Calculated Viscosity','Measured Viscosity')
hold off
%% Plot do erro
hold off
figure
surf(error14,P14,T14,'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none')
xlabel('Viscosity error in Micro Pa.s')
ylabel('Pressure in Mpa')
zlabel('Temperature in Celsius')
legend('Viscosity error')
hold off
figure
plot(P14(1,:),error14(1,:),'b-')
hold on
plot(P14(2,:),error14(2,:),'k-')
plot(P14(3,:),error14(3,:),'g-')
plot(P14(4,:),error14(4,:),'o-')
plot(P14(5,:),error14(5,:),'r-')
plot(P14(6,:),error14(6,:),'c-')
plot(P14(7,:),error14(7,:),'m-')
plot(P14(8,:),error14(8,:),'y-')
plot(P14(9,:),error14(9,:),'b-')
plot(P14(10,:),error14(10,:),'k-')
plot(P14(11,:),error14(11,:),'g-')
title('Pressure vs Viscosity error')
xlabel('Pressure in Mpa');
ylabel('Viscosity error in MicroPa.S')
save all