clear all; close all; clc;
%% Parameters

Ma = 2100;
Mm = 2900;
Ta = 1000;
Tm = 1000;
material = 'Steel_1045_CD';
dtoD = 1.2;
dtor = 0.1;
n = 1.5;

materialBank

state = title;

while (state ~= -1)
    if (state == 0)
        clc;
        state = options(Ma, Mm, Ta, Tm, material, n);
    elseif (state == 1)
        line()
        Ma = input("Ma: ");
        Mm = input("Mm: ");
        state = 0;
    elseif (state == 2)
        line()
        Ta = input("Ta: ");
        Tm = input("Tm: ");
        state = 0;
    elseif (state == 3)
        clc;
        line()
        disp("List of Materials:")
        for i = materials
            disp(i.name)
        end
        line()
        material = input("Desiered Material: [""Material""] ");
        state = 0;
    elseif (state == 4)
        dtoD = input("Factor of diameter d to D:");
        state = 0;
    elseif (state == 5)
        dtor = input("Factor of diameter d to fillet r:");
        state = 0;
    elseif (state == 6)
        n = input("Factor of Saftey (n):");
        state = 0;
    elseif (state == 7)
        clc;
        line()
        title();
        d = model(Tm,Ta, Mm, Ma, material, n, dtoD, dtor);
        fprintf("Minimum Diameter: %.2f\n", d);
        line()
        input("Enter to continue")
        state = 0;
        else
        state = options(Ma, Mm, Ta, Tm, material, n);
    end
end

clc;

function state = options(Ma, Mm, Ta, Tm, mat, n)
    line()
    params(Ma, Mm, Ta, Tm, mat, n)
    disp("Choose from the following options below to change model parameters:")
    line()
    disp("Enter Bending Forces: (Ma, Mm): [1]")
    disp("Enter Torsional Forces: (Ta, Tm): [2]")
    disp("Enter Material: [3]")
    disp("Enter Dtod: [4]")
    disp("Enter dtor: [5]")
    disp("Enter FOS: [6]")
    disp("Run Sim: [7]")
    disp("Exit: [-1]")
    line()
    state = input("Enter your option: ");
end

function state = title()
    line()
    disp(' ____  _   _    _    _____ _____   ____  _____ ____ ___ ____ _   _ ');
    disp('/ ___|| | | |  / \  |  ___|_   _| |  _ \| ____/ ___|_ _/ ___| \ | |');
    disp('\___ \| |_| | / _ \ | |_    | |   | | | |  _| \___ \| | |  _|  \| |');
    disp(' ___) |  _  |/ ___ \|  _|   | |   | |_| | |___ ___) | | |_| | |\  |');
    disp('|____/|_| |_/_/   \_\_|     |_|   |____/|_____|____/___\____|_| \_|');
    line()
    disp("Shaft design for dynamic moment and bending forces")
    line()
    state = 0;
end

function params = params(Ma, Mm, Ta, Tm, mat, n)
    disp("Current Parameters:");
    fprintf("Bending Moment: Ma=[%d], Mm=[%d]\n", Ma, Mm);
    fprintf("Torsional Force: Ta=[%d], Tm=[%d]\n", Ta, Tm);
    fprintf("Material: %s\n", mat)
    fprintf("Factor of Saftey: %.1f\n", n)
    line()
end

function l = line()
    disp('-----------------------------------------------------------------------');
end