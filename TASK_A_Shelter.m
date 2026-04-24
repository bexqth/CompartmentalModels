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
S1(1) = N - 3;
I1(1) = 3;
R1(1) = 0;

gamaR = 1/recoveryDays;
beta = R0 * gamaR;

    
fprintf("Day: %d \n", 1);
fprintf("number of S: %2.0f \n", S1(1));
fprintf("number of I: %2.0f \n", I1(1));
fprintf("number of R: %2.0f \n", R1(1));

%simulation

for t = 1:number_of_days - 1
    
    S1(t + 1) = S1(t) - beta * S1(t) * (I1(t) / N);
    I1(t + 1) = I1(t) + beta * S1(t) * (I1(t) / N) - gamaR * I1(t);
    R1(t + 1) = R1(t) + gamaR * I1(t);
    
    fprintf("Day: %d \n", t+1);
    fprintf("number of S: %2.0f \n", S1(t + 1));
    fprintf("number of I: %2.0f \n", I1(t + 1));
    fprintf("number of R: %2.0f \n", R1(t + 1));
end

[max_infected, day_max_infected] = max(I1);
fprintf("Max infected was in day: %d, with amount of %2.0f people \n", day_max_infected, max_infected);

t = 1:number_of_days;
figure;
plot(t, S1, 'LineWidth', 2);
hold on;
plot(t, I1, 'LineWidth', 2);
plot(t, R1, 'LineWidth', 2);
grid on;
xlabel('Days');
ylabel('Number of poeple');
legend('S','I', 'R');


S2 = zeros(1, number_of_days);
I2 = zeros(1, number_of_days);
R2 = zeros(1, number_of_days);
S2(1) = N - 3;
I2(1) = 3;
R2(1) = 0;

fprintf("Day: %d \n", 1);
fprintf("number of S: %2.0f \n", S(1));
fprintf("number of I: %2.0f \n", I(1));
fprintf("number of R: %2.0f \n", R(1));

%simulation

for t = 1:number_of_days - 1
    
    if t == 5
        beta = beta * 0.4;
    end

    S2(t + 1) = S2(t) - beta * S2(t) * (I2(t) / N);
    I2(t + 1) = I2(t) + beta * S2(t) * (I2(t) / N) - gamaR * I2(t);
    R2(t + 1) = R2(t) + gamaR * I2(t);
    
    fprintf("Day: %d \n", t+1);
    fprintf("number of S: %2.0f \n", S2(t + 1));
    fprintf("number of I: %2.0f \n", I2(t + 1));
    fprintf("number of R: %2.0f \n", R2(t + 1));
end

recovered_without_prec = R1(end);
recovered_with_prec = R2(end);

percent_change = (recovered_without_prec - recovered_with_prec) / recovered_without_prec * 100;
fprintf("percent change with the precasion is: %2.3f %% \n", percent_change);
