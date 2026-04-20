clc
clear

%settings
N = 1200;
D = 4;
R0 = 5.5;
number_of_days = 90;

S = zeros(1, number_of_days);
I = zeros(1, number_of_days);

%init
S(1) = N - 1;
I(1) = 1;
gama = 1/D;
beta = R0 * gama;

fprintf('Day: %d \n', 1);
fprintf('Number of infected %2.0f \n', I(1));
fprintf('Number of susceptible %2.0f \n', S(1));
fprintf('----------------------------- \n');

for t = 1:number_of_days - 1
    
    if t == 7
        beta = beta * 0.7;
    end

    S(t + 1) = S(t) - beta * S(t) * (I(t) / N) + gama * I(t);
    I(t + 1) = I(t) + beta * S(t) * (I(t) / N) - gama * I(t);

    fprintf('Day: %d \n', t + 1);
    fprintf('Number of infected %2.0f \n', I(t + 1));
    fprintf('Number of susceptible %2.0f \n', S(t + 1));
    fprintf('----------------------------- \n');
end
