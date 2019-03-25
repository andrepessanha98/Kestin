function V = Viscosity(P,Mi,Beta)
V = zeros(8,12);
for i=1:8
V(i,:) = Mi(i).*(1+(Beta(i).*P(i,:)./1000));
end
end

