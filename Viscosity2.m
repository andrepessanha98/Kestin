function V = Viscosity2(P,Mi,Beta)
x=size(P);
for i=1:x(1)
V(i,:) = Mi(i).*(1+(Beta(i).*P(i,:)./1000));
end
end


