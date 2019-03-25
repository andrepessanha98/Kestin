%Declaração de variaveis%
clear all
close all
clc
a=importdata('salinity44.txt');
P44=a';
%Script to test an algorythim that calculates Viscosity using Kestin Model%
T44=[25.5 35 35.5 45 56 71 85 97 114 129]; %T em C%
S44=4.4289; % Solubilida em mol/kg%
%Pressão em Mpa%
%% Parte 1 da equação
A = Am(S44);
B = Bm(S44);
C = Cm(T44);
M = C+log10(1002); % visco em Pa^-6
M0 = A + B.*C;
Milog=M0+M;
Mi = 10.^(Milog);
%% Parte 2 da equação
bw = Bw(T44);
bs = Bs(T44,bw);
Ms = ms(T44);
bp = Bp(S44,Ms);
Beta = bw+bp.*bs;
Visc44 = Viscosity2(P44,Mi,Beta);
%% Análise do erro
mat = importdata('salinity44_2.txt');
Real_Visc44 = mat';
error44 = (abs(Visc44 - Real_Visc44))*100./Real_Visc44;
figure
%% Analise grafica
for i=1:8
plot(P44(i,:),Visc44(i,:),'r-')
hold on
end

for i=1:8
plot(P44(i,:),Real_Visc44(i,:),'b-')
hold on
end
title('Pressure vs Viscosity')
xlabel('Pressure in Mpa');
ylabel('Viscosity in MicroPa.S')
legend('Calculated in red','Measured in blue')
%%Análise estatistica
for i=1:10
    %Consertar medidas com NAN
    variance44(i)=var(error44(i,:));
    media44(i)=mean(error44(i,:));
end
%%
T44=T44';
T44=repmat(T44,1,10);
figure
surf(Real_Visc44,P44,T44,'FaceColor','g', 'FaceAlpha',0.5, 'EdgeColor','none')
hold on
surf(Visc44,P44,T44,'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none')
xlabel('Viscosity in Micro Pa.s')
ylabel('Pressure in Mpa')
zlabel('Temperature in Celsius')
legend('Calculated Viscosity','Measured Viscosity')
hold off
%% Plot do erro
hold off
figure
surf(error44,P44,T44,'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none')
xlabel('Viscosity error in Micro Pa.s')
ylabel('Pressure in Mpa')
zlabel('Temperature in Celsius')
legend('Viscosity error')

hold off
figure
plot(P44(1,:),error44(1,:),'b-')
hold on
plot(P44(2,:),error44(2,:),'k-')
plot(P44(3,:),error44(3,:),'g-')
plot(P44(4,:),error44(4,:),'o-')
plot(P44(5,:),error44(5,:),'r-')
plot(P44(6,:),error44(6,:),'Color',[0.44 0.342 0],'LineStyle','-')
plot(P44(7,:),error44(7,:),'m-')
plot(P44(8,:),error44(8,:),'Color',[0.6 0 .4],'LineStyle','-')
plot(P44(9,:),error44(9,:),'b-')
plot(P44(10,:),error44(10,:),'k-')
title('Pressure vs Viscosity')
xlabel('Pressure in Mpa');
ylabel('Viscosity in MicroPa.S')
save all