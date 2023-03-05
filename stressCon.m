function k = stressCon(sut, d, D, r, m)

    modes = ['b', 'a', 't'];

    if ~ismember(m, modes)
        k = NaN;
        return
    end

    if (m=='b' || m=='a')
        a = 0.246 - 3.08*(10^-3)*sut + 1.51*(10^-5)*sut^2 - 2.67*(10^-8)*sut^3;
        k = 1 + (stressCon_Bend(d, D, r) - 1) / (1 + a / sqrt(d/2));
    elseif (m=='t')
        a = 0.190 - 2.51*(10^-3)*sut + 1.35*(10^-5)*sut - 2.67*(10^-8)*sut^3;
        k = 1 + (stressCon_Torsional(d, D, r) - 1) / (1 + a / sqrt(d/2));
    end

end