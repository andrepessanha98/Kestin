%Declaração de variaveis%
clear all
close all
clc
%Script to test an algorythim that calculates Viscosity using Kestin Model%
T04=[18 23.5 28 40.5 54 69 84 96 108.5 126 148]; %T em C%
S04=0.4755; % Solubilida em mol/kg%
%Pressão em Mpa%
P04 = [0.1 3.62 7.07 10.48 13.99 17.51 20.61 23.99 26.44 30.27 ;  0.10 3.46 7.03 10.34 13.98 17.42 20.46 24.03 27.44 30.75  ; 0.10 3.58 7.10 10.55 14.06 17.51 20.99 24.41 27.54 31.16 ; 0.10 3.57 7.08 10.51 14.06 17.34 20.72 24.23 27.61 31.13 ; 0.1 3.57 7.01 10.46 14.10 17.48 20.79 24.13 27.51 31.04 ; 0.10 3.62 7.10 10.48 13.98 17.51 20.79 24.10 27.32 30.97 ; 0.10 3.69 10.55 17.41 24.01 30.89 nan nan nan nan;0.72 3.38 10.31 17.34 24.06 30.54 nan nan nan nan; 1.07 3.65 10.25 23.75 30.70 nan nan nan nan nan;0.93 3.51 8.72 13.55 18.51 25.20 30.96 nan nan nan; 1 5.10 10.38 15.34 20.65 25.16 30.51 nan nan nan ];
%% Parte 1 da equação
A = Am(S04);
B = Bm(S04);
C = Cm(T04);
M = C+log10(1002); % visco em Pa^-6
M0 = A + B.*C;
Milog=M0+M;
Mi = 10.^(Milog);
%% Parte 2 da equação
bw = Bw(T04);
bs = Bs(T04,bw);
Ms = ms(T04);
bp = Bp(S04,Ms);
Beta = bw+bp.*bs;
Visc04 = Viscosity2(P04,Mi,Beta);
%% Análise do erro
Real_Visc04 = [1089 1087 1086 1087 1084 1083 1081 1084 1085 1082 ; 958 957 959 959 957 957 956 956 956 956 ; 868 871 870 868 868 868 869 868 870 868 ; 679 679 679 680 679 681 681 686 680 683  ; 548 549 544 543 542 544 542 544 547 549; 430 434 432 433 436 439 434 439 438 441  ; 356 358 359 360 363 365 nan nan nan nan ;  311 312 314 315 317 318 nan nan nan nan;274 275 276 280 282  nan nan nan nan nan; 234 234 237 237 238 241 242 nan nan nan;198 201 200 202 203 204 205 nan nan nan];
error04 = (abs(Visc04 - Real_Visc04))*100./Real_Visc04;
figure
%% Analise grafica
for i=1:8
plot(P04(i,:),Visc04(i,:),'r-')
hold on
end
for i=1:8
plot(P04(i,:),Real_Visc04(i,:),'b-')
hold on
end
title('Pressure vs Viscosity')
xlabel('Pressure in Mpa');
ylabel('Viscosity in MicroPa.S')
legend('Calculated in red','Measured in blue')
%%Análise estatistica
for i=1:11
    %Consertar medidas com NAN
    variance04(i)=var(error04(i,:));
    media04(i)=mean(error04(i,:));
    
end
%%
T04=T04';
T04=repmat(T04,1,10);
figure
surf(Real_Visc04,P04,T04,'FaceColor','g', 'FaceAlpha',0.5, 'EdgeColor','none')
hold on
surf(Visc04,P04,T04,'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none')
xlabel('Viscosity in Micro Pa.s')
ylabel('Pressure in Mpa')
zlabel('Temperature in Celsius')
legend('Calculated Viscosity','Measured Viscosity')
hold off
%% Plot do erro
hold off
figure
surf(error04,P04,T04,'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none')
xlabel('Viscosity error in Micro Pa.s')
ylabel('Pressure in Mpa')
zlabel('Temperature in Celsius')
legend('Viscosity error')
figure
plot(P04(1,:),error04(1,:),'b-')
hold on
plot(P04(2,:),error04(2,:),'k-')
plot(P04(3,:),error04(3,:),'g-')
plot(P04(4,:),error04(4,:),'o-')
plot(P04(5,:),error04(5,:),'r-')
plot(P04(6,:),error04(6,:),'c-')
plot(P04(7,:),error04(7,:),'m-')
plot(P04(8,:),error04(8,:),'y-')
plot(P04(9,:),error04(9,:),'b-')
plot(P04(10,:),error04(10,:),'k-')
plot(P04(11,:),error04(11,:),'g-')
title('Pressure vs Viscosity error')
xlabel('Pressure in Mpa');
ylabel('Viscosity erro in MicroPa.S')
save all