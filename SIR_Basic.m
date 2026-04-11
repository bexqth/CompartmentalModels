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

for t = 1:59
    S(t + 1) = S(t) - beta * S(t) * (I(t) / N);
    I(t + 1) = I(t) + beta * S(t) * (I(t) / N) - gama * I(t);
    R(t + 1) = R(t) + gama * I(t);

    fprintf('Day: %d \n', t);
    fprintf('Number of infected %2.0f \n', I(t));
    fprintf('Number of susceptible %2.0f \n', S(t));
    fprintf('Number of recovered %2.0f \n', R(t));
    fprintf('----------------------------- \n', t);
end

days = 1:t + 1;
plot(days, S, 'b', days, I, 'r', days, R, 'g', 'LineWidth', 1.5);
grid on;