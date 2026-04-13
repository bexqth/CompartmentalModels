clc
clear
%settings

N = 500;
D = 4;
R0 = 3;
number_of_days = 30;
S = zeros(1, number_of_days);
I = zeros(1, number_of_days);
R = zeros(1, number_of_days);

%init
gama = 1 / D;
beta = R0 * gama;
gama
beta

S(1) = N -1;
I(1) = 1;
R(1) = 0;

%basic model

fprintf("Day: %d \n", 1);
fprintf("number of infected: %2.0f \n", I(1));
fprintf("number of susceptible: %2.0f \n", S(1));
fprintf("number of recovered: %2.0f \n", R(1));
fprintf('----------------------------- \n');

for t = 1:number_of_days - 1
    if t == 5
        beta = beta / 3;
        beta
    end

    if t == 10
        D = 2;
        gama = 1 / D;
        gama
        beta = beta / 4;
        beta
    end

    S(t + 1) = S(t) - beta * S(t) * (I(t) / N);
    I(t + 1) = I(t) + beta * S(t) * (I(t) / N) - gama * I(t);
    R(t + 1) = R(t) + gama * I(t);

    fprintf("Day: %d \n", t + 1);
    fprintf("number of infected: %2.0f \n", I(t + 1));
    fprintf("number of susceptible: %2.0f \n", S(t + 1));
    fprintf("number of recovered: %2.0f \n", R(t + 1));
    fprintf('----------------------------- \n');
    
end

[amount_max_infected, day_max_infected] = max(I);

fprintf('Max infected was in day %d with amount %2.0f \n', day_max_infected, amount_max_infected);