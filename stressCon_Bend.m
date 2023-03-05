function k = stressCon_Bend(d, D, r)

    t = (D - d) / 2;

    if (t/r <= 2.0)
        c1 = 0.947 + 1.206 * sqrt(t/r) - 0.131 * t / r;
        c2 = 0.022 - 3.405 * sqrt(t/r) + 0.915 * t / r;
        c3 = 0.869 + 1.777 * sqrt(t/r) - 0.555 * t / r;
        c4 = -.810 + 0.422 * sqrt(t/r) - 0.260 * t / r;
    elseif (t/r >= 2.0)
        c1 = 1.232 + 0.832 * sqrt(t/r) - 0.008 * t / r;
        c2 = -3.813 + 0.968 * sqrt(t/r) - 0.260 * t / r;
        c3 = 7.423 - 4.868 * sqrt(t/r) - 0.869 * t / r;
        c4 = -3.839 + 3.070 * sqrt(t/r) - 0.600 * t / r;
    end

    k = c1 + c2*(2*t/D) + c3*(2*t/D)^2 + c4*(2*t/D)^3;
end