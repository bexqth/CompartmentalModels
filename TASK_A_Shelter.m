clc
clear
%settings

N = 800;
recoveryDays = 6;
number_of_days = 60;
S = zeros(1, number_of_days);
I = zeros(1, number_of_days);
R = zeros(1, number_of_days);
R0 = 9.3;

%init
S(1) = N - 3;
I(1) = 3;
R(1) = 0;

gamaR = 1/recoveryDays;
beta = R0 * gamaR;

    
fprintf("Day: %d \n", 1);
fprintf("number of S: %2.0f \n", S(1));
fprintf("number of I: %2.0f \n", I(1));
fprintf("number of R: %2.0f \n", R(1));

%simulation

for t = 1:number_of_days - 1
    
    S(t + 1) = S(t) - beta * S(t) * (I(t) / N);
    I(t + 1) = I(t) + beta * S(t) * (I(t) / N) - gamaR * I(t);
    R(t + 1) = R(t) + gamaR * I(t);
    
    fprintf("Day: %d \n", t+1);
    fprintf("number of S: %2.0f \n", S(t + 1));
    fprintf("number of I: %2.0f \n", I(t + 1));
    fprintf("number of R: %2.0f \n", R(t + 1));
end

[max_infected, day_max_infected] = max(I);
fprintf("Max infected was in day: %d, with amount of %2.0f people \n", day_max_infected, max_infected);

t = 1:number_of_days;
figure;
plot(t, S, 'LineWidth', 2);
hold on;
plot(t, I, 'LineWidth', 2);
plot(t, R, 'LineWidth', 2);
grid on;
xlabel('Days');
ylabel('Number of poeple');
legend('S','I', 'R');
