clc
clear

%settings
N = 500;
gamaD = 0.2;
R0 = 5;
days = 7;
number_of_days = 30;
S = zeros(1, number_of_days);
I = zeros(1, number_of_days);
R = zeros(1, number_of_days);
D = zeros(1, number_of_days);
gama = 1 / days;
beta = R0 * gama;

%init
S(1) = 499;
I(1) = 1;
R(1) = 0;
D(1) = 0;

fprintf('Day: %d \n', 1);
fprintf('Number of infected %2.0f \n', I(1));
fprintf('Number of susceptible %2.0f \n', S(1));
fprintf('Number of recovered %2.0f \n', R(1));
fprintf('Number of dead %2.0f \n', D(1));
fprintf('----------------------------- \n');

for t = 1:number_of_days - 1
    if t == 10
        beta = beta * 0.3;
    end

    S(t + 1) = S(t) - beta * S(t) * (I(t) / N);
    I(t + 1) = I(t) + beta * S(t) * (I(t) / N) - gama * I(t) - gamaD * I(t);
    R(t + 1) = R(t) + gama * I(t);
    D(t + 1) = D(t) + gamaD * I(t);

    fprintf('Day: %d \n', t+1);
    fprintf('Number of infected %2.0f \n', I(t+1));
    fprintf('Number of susceptible %2.0f \n', S(t+1));
    fprintf('Number of recovered %2.0f \n', R(t+1));
    fprintf('Number of dead %2.0f \n', D(t+1));
    fprintf('----------------------------- \n');
end
