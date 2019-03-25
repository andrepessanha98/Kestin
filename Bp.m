function bp = Bp(S,ms)
R = S./ms;
bp = 2.5.*R-2.*R.^2+0.5.*R.^3;
end

