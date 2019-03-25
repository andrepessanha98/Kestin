clear all
close all
clc
%Script to test an algorythim that calculates Viscosity using Kestin Model%
T54=[27.5 44.5 60.0 80.0 94.0 101.0 131.0 148.0]; %T em C%
S54=5.4054; % Solubilida em mol/kg%
%Pressão em Mpa%
P54 = [0.93 3.48 6.95 10.65 14.11 17.60 20.96 24.61 27.82 31.09  ;  0.10 3.50 7.12 11.03 14.24 17.65 20.81 24.39 27.86 31.3  ; 0.10 3.33 7.26 10.51 13.72 17.75 21.08 23.15 27.47 31.39 ; 0.86 3.45 7.01 10.44 13.89 17.34 20.86 24.30 27.68 31.27 ; 1.02 3.47 6.82 10.39 13.76 17.25 20.92 24.29 27.96 31.28  ; 1.38 3.55 7.13 10.72 13.99 17.58 21.13 24.44 27.68 31.37 ; 1.55 3.48 6.93 10.58 13.99 17.44 20.79 24.39 27.54 31.54  ; 3.67 7.13 10.46 13.82 17.39 21.04 24.34 27.73 31.27 16.17 ];
A = Am(S54);
B = Bm(S54);
C = Cm(T54);
M = C+log10(1002); % visco em Pa^-6
M0 = A + B.*C;
Milog=M0+M;
Mi = 10.^(Milog);
%%
bw = Bw(T54);
bs = Bs(T54,bw);
Ms = ms(T54);
bp = Bp(S54,Ms);
Beta = bw+bp.*bs;
Visc54 = Viscosity2(P54,Mi,Beta);
%%
Real_Visc54 = [1525 1526 1529 1534 1535 1540 1545 1546 1551 1552  ; 1092 1094 1099 1099 1105 1107 1111 1112 1112 1115 ; 854 856 850 861 862 862 867 870 869 875  ; 654 656 656 659 664 660 665 665 667 669   ; 556 557 559 561 561 565 567 566 568 566  ; 524 523 525 527 528 527 532 534 535 536 ; 395 396 398 399 399 399 404 403 405 406 ;  347 348 350 350 352 354 355 356 355 352  ];
error54 = (abs(Visc54 - Real_Visc54))*100./Real_Visc54;
figure
%% %Analise grafica
for i=1:8
plot(P54(i,:),Visc54(i,:),'r-')
hold on
end
for i=1:8
plot(P54(i,:),Real_Visc54(i,:),'b-')
hold on
end
title('Pressure vs Viscosity')
xlabel('Pressure in Mpa');
ylabel('Viscosity in MicroPa.S')
legend('Calculated in red','Measured in blue')
%%
for i=1:8
    variance54(i)=var(error54(i,:));
    media54(i)=mean(error54(i,:));
 
end
hold off
%%
T54=T54';
T54=repmat(T54,1,10);
figure
surf(Real_Visc54,P54,T54,'FaceColor','g', 'FaceAlpha',0.5, 'EdgeColor','none')
hold on
surf(Visc54,P54,T54,'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none')
xlabel('Viscosity in Micro Pa.s')
ylabel('Pressure in Mpa')
zlabel('Temperature in Celsius')
legend('Calculated Viscosity','Measured Viscosity')
hold off
%% Plot do erro
hold off
figure
surf(error54,P54,T54,'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none')
xlabel('Viscosity error in Micro Pa.s')
ylabel('Pressure in Mpa')
zlabel('Temperature in Celsius')
legend('Viscosity error')

figure
plot(P54(1,:),error54(1,:),'b-')
hold on
plot(P54(2,:),error54(2,:),'k-')
plot(P54(3,:),error54(3,:),'g-')
plot(P54(4,:),error54(4,:),'o-')
plot(P54(5,:),error54(5,:),'r-')
plot(P54(6,:),error54(6,:),'c-')
plot(P54(7,:),error54(7,:),'m-')
plot(P54(8,:),error54(8,:),'y-')
title('Pressure vs Viscosity error')
xlabel('Pressure in Mpa');
ylabel('Viscosity error in MicroPa.S')
save all