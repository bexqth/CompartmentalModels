clc
clear

%settings
number_of_days = 100;
N = 5500000;

S = zeros(1, number_of_days);
Iasym = zeros(1, number_of_days);
Isym = zeros(1, number_of_days);
H = zeros(1, number_of_days);
R = zeros(1, number_of_days);
gammaA = 1/7;
gammaS = 1/12;
gammaH = 1/10;
d = 0.22;
p = 0.7;
r = 0.08;
beta = 0.71;
R0 = 1.5;

%data period
% zero data - 31.march
% 1.june.2020 - october 2020 
u = 3;

%init
S(1) = 5495434;
Isym(1) = 36.708;
Iasym(1) = 9.9;
R(1) = 4487.392;
D(1) = 28;
H(1) = 4;

fprintf('Day: %d \n', 1);

    fprintf('Number of susceptible %2.0f \n', S(1));
    fprintf('Number of infected symptotic %2.0f \n', Isym(1));
    fprintf('Number of infected asymptotic %2.0f \n', Iasym(1));
    fprintf('Number of recovered %2.0f \n', R(1));
    fprintf('Number of hospitalized %2.0f \n', H(1));
    fprintf('Number of dead %2.0f \n', D(1));
    fprintf('----------------------------- \n');

for t = 1:number_of_days - 1
    
    S(t + 1) = S(t) - beta * S(t) * ( (Iasym(t)) / (S(t) + R(t) + Iasym(t)) );
    Iasym(t + 1) = Iasym(t) + beta * S(t) * (1-p) * ((Iasym(t)) / (S(t) + R(t) + Iasym(t))) - gammaA * Iasym(t);
    Isym(t + 1) = Isym(t) + beta * S(t) * p * (1-r) * ((Iasym(t)) / (S(t) + R(t) + Iasym(t))) - gammaS * Isym(t);
    H(t + 1) = H(t) + beta * S(t) * p * r * ((Iasym(t)) / (S(t) + R(t) + Iasym(t))) - gammaH * H(t);
    R(t + 1) = R(t) + gammaA * Iasym(t) + gammaS * Isym(t) + gammaH * (1-d) * H(t);
    D(t + 1) = D(t) + gammaH * d * H(t);

    fprintf('Day: %d \n', t + 1);

    fprintf('Number of susceptible %2.0f \n', S(t + 1));
    fprintf('Number of infected symptotic %2.0f \n', Isym(t + 1));
    fprintf('Number of infected asymptotic %2.0f \n', Iasym(t + 1));
    fprintf('Number of recovered %2.0f \n', R(t + 1));
    fprintf('Number of hospitalized %2.0f \n', H(t + 1));
    fprintf('Number of dead %2.0f \n', D(t + 1));
    fprintf('----------------------------- \n');

end

t = 1:number_of_days;

figure;
plot(t, S, 'LineWidth', 2); hold on;
plot(t, Iasym, 'LineWidth', 2);
plot(t, Isym, 'LineWidth', 2);
plot(t, H, 'LineWidth', 2);
plot(t, R, 'LineWidth', 2);
plot(t, D, 'LineWidth', 2);
grid on;
xlabel('Days');
ylabel('Number of people');
title('SIaIsHRD model for SK');
legend('S', 'I_a', 'I_s', 'H', 'R', 'D', 'Location', 'best');
