function k = stressCon_Torsional(d, D, r)

    t = (D - d) / 2;

    c1 = 0.905 + 0.783 * sqrt(t/r) - 0.075 * t / r;
    c2 = -0.437 - 1.969 * sqrt(t/r) + 0.553 * t / r;
    c3 = 1.557 + 1.073 * sqrt(t/r) - 0.578 * t / r;
    c4 = -1.061+ 0.171 * sqrt(t/r) + 0.086 * t / r;

    k = c1 + c2*(2*t/D) + c3*(2*t/D)^2 + c4*(2*t/D)^3;
end