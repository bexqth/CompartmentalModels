clc
clear

%setting
N = 50000;
R0 = 3.2;
days_of_recovery = 10;
gammaD = 0.02;
number_of_days = 30 * 6;

S = zeros(1, number_of_days);
I = zeros(1, number_of_days);
R = zeros(1, number_of_days);
D = zeros(1, number_of_days);

%init
gammaR = 1 / days_of_recovery;
beta = R0 * gammaR;

I(1) = 10;
S(1) = N - I(1);
R(1) = 0;
D(1) = 0;

fprintf('Day: %d \n', 1);
fprintf('number of S: %2.0f \n', S(1));
fprintf('number of I: %2.0f \n', I(1));
fprintf('number of R: %2.0f \n', R(1));
fprintf('number of D: %2.0f \n', D(1));

%simulation

for t = 1:number_of_days - 1
    
    if t == 10 || t == 60
        beta = beta / 2;
    end

    if t == 40 || t == 90
        beta = R0 * gammaR;
    end

    S(t + 1) = S(t) - beta * S(t) * (I(t) / N);
    I(t + 1) = I(t) + beta * S(t) * (I(t) / N) - gammaR * I(t) - gammaD * I(t);
    R(t + 1) = R(t) + gammaR * I(t);
    D(t + 1) = D(t) + gammaD * I(t);

    fprintf('Day: %d \n', t + 1);
    fprintf('number of S: %2.0f \n', S(t + 1));
    fprintf('number of I: %2.0f \n', I(t + 1));
    fprintf('number of R: %2.0f \n', R(t + 1));
    fprintf('number of D: %2.0f \n', D(t + 1));
    %fprintf('number of poeple: %2.0f \n', S(t + 1) + I(t + 1) + R(t + 1) + D(t + 1));
end

[max_infected, day_max_infected] = max(I);
fprintf("Max infected was in day: %d, with amount of %2.0f people \n", day_max_infected, max_infected);

t = 1 : number_of_days;

figure;
plot(t, S, 'LineWidth', 2);
hold on;
plot(t, I, 'LineWidth', 2);
plot(t, R, 'LineWidth', 2);
plot(t, D, 'LineWidth', 2);
grid on;
xlabel('Days');
ylabel('Number of people');
legend('S', 'I', 'R', 'D');