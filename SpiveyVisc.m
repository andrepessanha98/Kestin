function 	Visc = SpiveyVisc(Temp,P,Mi)
Visc =zeros(8,12);
for i=1:8
Visc(i,:) =  Mi(i,:).*exp(((0.068.*P(i,:)./100 + 0.0173).*(log(Temp(i)./125))).^2 + (0.0273.*P(i,:)./100-1.0531).*(log(Temp(i)./125)));
end

