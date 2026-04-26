clc
clear
%setting
N = 4000;
days_of_recovery = 5;
R0 = 4;
gammaD = 0.015;
number_of_days = 90;

gammaR = 1 / days_of_recovery;
beta = R0 * gammaR;

%to do
% - prec
% - graph
% - peak of epidemic

%simulation

[S, I, R, D] = runSimulation(beta, number_of_days, gammaR, gammaD, N, N - 2, 2, 0, 0, R0);

vaccinated = 0.7; %%
R0_vac = N * vaccinated;
I0_vac = 2;
S0_vac = N - R0_vac - I0_vac;
[S_vac, I_vac, R_vac, D_vac] = runSimulation(beta, number_of_days, gammaR, gammaD, N, S0_vac, I0_vac, R0_vac, 0, R0);


[max_infected_amount, max_infected_day] = max(I);
fprintf("Peak of infected was in: %d day with amount %2.0f \n", max_infected_day , max_infected_amount);

[max_infected_amount_vac, max_infected_day_vac] = max(I_vac);
fprintf("Peak of infected was in: %d day with amount %2.0f \n", max_infected_day_vac , max_infected_amount_vac);

percent_change = (max_infected_amount - max_infected_amount_vac) /  max_infected_amount * 100;
fprintf("Percent change with vaccination is %2.3f %% \n", percent_change);

t = 1 : number_of_days;

figure;
title('model SIRD');
plot(t, S, 'LineWidth', 2);
hold on;
plot(t, I, 'LineWidth', 2);
plot(t, R, 'LineWidth', 2);
plot(t, D, 'LineWidth', 2);
grid on;
legend('S', 'I', 'R', 'D');

figure;
title('Comparison with vaccinated');
plot(t, I, 'LineWidth', 2);
hold on;
plot(t, I_vac, 'LineWidth', 2);
grid on;
legend('I', 'I vaccinated');

function [R, I, S, D] = runSimulation(beta, number_of_days, gammaR, gammaD, N, S1, I1, R1, D1, R0)
    S = zeros(1, number_of_days);
    I = zeros(1, number_of_days);
    R = zeros(1, number_of_days);
    D = zeros(1, number_of_days);
    
    S(1) = S1;
    I(1) = I1;
    R(1) = R1;
    D(1) = D1;

    for t = 1:number_of_days - 1
        %prec
        if t == 10
            beta = beta * 0.4;
        end
    
        if t == 40
            beta = R0 * gammaR;
        end
    
        if t == 60
            beta = beta / 2;
        end
    
        if t == 80
            beta = R0 * gammaR;
        end
    
        S(t + 1) = S(t) - beta * S(t) * (I(t) / N);
        I(t + 1) = I(t) + beta * S(t) * (I(t) / N) - gammaR * I(t) - gammaD * I(t);
        R(t + 1) = R(t) + gammaR * I(t);
        D(t + 1) = D(t) + gammaD * I(t);

        fprintf("Day: %d \n", t+1);
        fprintf("number of S: %2.0f \n", S(t + 1));
        fprintf("number of I: %2.0f \n", I(t + 1));
        fprintf("number of R: %2.0f \n", R(t + 1));
        fprintf("number of D: %2.0f \n", D(t + 1));
    end

end