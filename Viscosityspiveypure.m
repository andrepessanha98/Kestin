function Visc = Viscosityspiveypure(P,Mi,Beta)
Visc = zeros(size(P));
for i=1:8
    Visc(i,:) = Mi.*(1+(Beta.*P(i,:)./1000));

end

