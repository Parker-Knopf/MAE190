%% Materials

steel1010CD.sy = 44 * 1000; % psi
steel1010CD.sut = 53 * 1000; % psi
steel1010CD.name = 'Steel_1010_CD';

steel1020CD.sy = 57 * 1000; % psi
steel1020CD.sut = 68 * 1000; % psi
steel1020CD.name = 'Steel_1020_CD';

steel1035CD.sy = 67 * 1000; % psi
steel1035CD.sut = 80 * 1000; % psi
steel1035CD.name = 'Steel_1035_CD';

steel1045CD.sy = 77 * 1000; % psi
steel1045CD.sut = 91 * 1000; % psi
steel1045CD.name = 'Steel_1045_CD';

steel1050CD.sy = 84 * 1000; % psi
steel1050CD.sut = 100 * 1000; % psi
steel1050CD.name = 'Steel_1050_CD';

a36.sy = 250 * 1000; % psi
a36.sut = 400 * 1000; % psi
a36.name = "a36";

%% Bank

materials = [steel1010CD, steel1020CD, steel1035CD, steel1045CD, steel1050CD, a36];