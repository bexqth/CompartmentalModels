clc
clear

%settings
N = 3000;
R0 = 7;
D = 5;
fest_duration = 3;
number_of_days = 10;
S = zeros(1, number_of_days);
I = zeros(1, number_of_days);
R = zeros(1, number_of_days);

%init
S(1) = 2950;
I(1) = 50;
R(1) = 0;
gama = 1/D;
beta = R0 * gama;
going_home_infected = 0;

fprintf('Day: %d \n', 1);
fprintf('Number of infected %2.0f \n', I(1));
fprintf('Number of susceptible %2.0f \n', S(1));
fprintf('Number of recovered %2.0f \n', R(1));
fprintf('----------------------------- \n');

for t = 1:number_of_days - 1
    if t == 3
        beta = 0;
        going_home_infected = I(t);
    end

    S(t+1) = S(t) - beta * S(t) * (I(t) / N);
    I(t+1) = I(t) + beta * S(t) * (I(t) / N) - gama * I(t);
    R(t+1) = R(t) + gama * I(t);
    
    fprintf('Day: %d \n', t + 1);
    fprintf('Number of infected %2.0f \n', I(t + 1));
    fprintf('Number of susceptible %2.0f \n', S(t + 1));
    fprintf('Number of recovered %2.0f \n', R(t + 1));
    fprintf('----------------------------- \n');
end

[max_infected, day_max_infected] = max(I);

fprintf('Max infected was in day %d with amount %2.0f \n', day_max_infected, max_infected);
fprintf('Poeple going home infected %2.0f \n', going_home_infected);