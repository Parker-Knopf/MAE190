function d = model(Tm, Ta, Mm, Ma, mat, n, dtoD, dtor)
    
    materialBank
    % Check if material exists in material bank
    exists = false;
    for i = materials
        if strcmp(mat, i.name)
            exists = true;
            mat = i;
            break
        end
    end
    if (~exists)
        disp("Desiered Material is not included in the material bank. Try another material. \n")
        d = Nan;
        return
    end

    % Inital Guess
    d = 2 * ((1/2/(pi*mat.sy/n)^2 * (32*(Mm+Ma/2)^2 + 24*(Tm+Ta/2)^2)))^(1/6);
    Se = enduranceLim(mat.sut, d);
    Sy = mat.sy;
    D = d*dtoD;

    error = 0.01;
    e = Inf;
    while e > error
        r = d * dtor;
        kf = stressCon(mat.sut, d, D, r, 'b');
        kfs = stressCon(mat.sut, d, D, r, 't');
        d_new = (16*n/pi * (4*(kf*Ma/Se)^2 + 3*(kfs*Ta/Se)^2 + 4*(kf*Mm/Sy)^2 + 4*(kf*Mm/Sy)^2 + 3*(kfs*Tm/Sy)^2 )^(1/2) )^(1/3);
        e = abs(d - d_new) / d;
        Se = enduranceLim(mat.sut, d);
        d = d_new;
        D = d*dtoD;
    end

    d = d*dtoD; % Return outer larger Diameter
end