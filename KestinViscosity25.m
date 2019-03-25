%Declaração de variaveis%
clear all
close all
clc
a=importdata('salinity25.txt');
b=importdata('salinity25_2.txt');
P25=[a b]';
%Script to test an algorythim that calculates Viscosity using Kestin Model%
T25=[19 25 30.5 41 60 80 101 121 136 151]; %T em C%
S25=2.5514; % Solubilida em mol/kg%
%Pressão em Mpa%
%% Parte 1 da equação
A = Am(S25);
B = Bm(S25);
C = Cm(T25);
M = C+log10(1002); % visco em Pa^-6
M0 = A + B.*C;
Milog=M0+M;
Mi = 10.^(Milog);
%% Parte 2 da equação
bw = Bw(T25);
bs = Bs(T25,bw);
Ms = ms(T25);
bp = Bp(S25,Ms);
Beta = bw+bp.*bs;
Visc25 = Viscosity2(P25,Mi,Beta);
%% Análise do erro
mat = importdata('salinity25_3.txt');
Real_Visc25 = mat';
error25 = (abs(Visc25 - Real_Visc25))*100./Real_Visc25;
figure
%% Analise grafica
for i=1:8
plot(P25(i,:),Visc25(i,:),'r-')
hold on
end
title('Pressure vs Viscosity')
xlabel('Pressure in Mpa');
ylabel('Viscosity in MicroPa.S')
legend('Calculated in red','Measured in blue')
for i=1:8
plot(P25(i,:),Real_Visc25(i,:),'b-')
hold on
end
%%Análise estatistica
for i=1:10
    %Consertar medidas com NAN
    variance25(i)=var(error25(i,:));
    media25(i)=mean(error25(i,:));
end
%%
T25=T25';
T25=repmat(T25,1,10);
figure
surf(Real_Visc25,P25,T25,'FaceColor','g', 'FaceAlpha',0.5, 'EdgeColor','none')
hold on
surf(Visc25,P25,T25,'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none')
xlabel('Viscosity in Micro Pa.s')
ylabel('Pressure in Mpa')
zlabel('Temperature in Celsius')
legend('Calculated Viscosity','Measured Viscosity')
hold off
%% Plot do erro
hold off
figure
surf(error25,P25,T25,'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none')
xlabel('Viscosity error in Micro Pa.s')
ylabel('Pressure in Mpa')
zlabel('Temperature in Celsius')
legend('Viscosity error')
hold off
figure
plot(P25(1,:),error25(1,:),'b-')
hold on
plot(P25(2,:),error25(2,:),'k-')
plot(P25(3,:),error25(3,:),'g-')
plot(P25(4,:),error25(4,:),'o-')
plot(P25(5,:),error25(5,:),'r-')
plot(P25(6,:),error25(6,:),'c-')
plot(P25(7,:),error25(7,:),'m-')
plot(P25(8,:),error25(8,:),'y-')
plot(P25(9,:),error25(9,:),'b-')
plot(P25(10,:),error25(10,:),'k-')
title('Pressure vs Viscosity error')
xlabel('Pressure in Mpa');
ylabel('Viscosity error in MicroPa.S')
save all