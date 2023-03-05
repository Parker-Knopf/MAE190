function se = enduranceLim(sut, d)

    a = 2.00;
    b = -0.217;
    ka = a * sut^b;

    kb = 0.91*d^-.157;

    kc = 1;

    kd = 1;

    ke = 0.753;

    se = ka * kb * kc *kd * ke * (sut/2);
end