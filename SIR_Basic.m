%SIR Model
clc
clear

N = 20000;
D = 5;
R0 = 4;
gama = 1/D;
beta = R0 * gama;

S = zeros(1, 60);
I = zeros(1, 60);
R = zeros(1, 60);

I(1) = 1;
S(1) = N - 1;
R(1) = 0;

% 10 days after poeple were loosing hair -> 13th day
% -> physical contant reduced by half
% -> beta needs to be reduced by half 


for t = 1:59
    if t == 13
        beta = beta / 2;
        %after 2 days -> eliminate contant with anyone
        beta = beta * (2/5);
    end
    S(t + 1) = S(t) - beta * S(t) * (I(t) / N);
    I(t + 1) = I(t) + beta * S(t) * (I(t) / N) - gama * I(t);
    R(t + 1) = R(t) + gama * I(t);

    fprintf('Day: %d \n', t);
    fprintf('Number of infected %2.0f \n', I(t));
    fprintf('Number of susceptible %2.0f \n', S(t));
    fprintf('Number of recovered %2.0f \n', R(t));
    fprintf('----------------------------- \n', t);
end

[amount_max_infected, day_max_infected] = max(I);

fprintf('Max infected was in day %d with amount %2.0f \n', day_max_infected, amount_max_infected);

%days = 1:t + 1;
%plot(days, S, 'b', days, I, 'r', days, R, 'g', 'LineWidth', 1.5);
%grid on;