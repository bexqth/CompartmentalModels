clc
clear

%settings
N = 300;
number_of_days = 14;
R0 = 15;
days_of_recovery = 8;

gamaR = 1 / days_of_recovery;
beta = R0 * gamaR;
vaccinated1 = 0;
vaccinated2 = 0.5;
vaccinated3 = 0.93;

%simulation
[S1, I1, R1] = run_simulation(N, beta, gamaR, 0, number_of_days);
[S2, I2, R2] = run_simulation(N, beta, gamaR, 0.5, number_of_days);
[S3, I3, R3] = run_simulation(N, beta, gamaR, 0.93, number_of_days);

%graph
t = 1 : number_of_days;
figure;
plot(t, I1, "LineWidth", 2);
hold on;
plot(t, I2, "LineWidth", 2);
plot(t, I3, "LineWidth", 2);

xlabel("Days");
ylabel("Number of infected");
legend('0% vaccinated', '50% vaccinated', '93% vaccinated');

%f
function[S, I, R] = run_simulation (N, beta, gamaR, vaccinated, number_of_days)
    S = zeros(1, number_of_days);
    I = zeros(1, number_of_days);
    R = zeros(1, number_of_days);
    
    R(1) = N * vaccinated;
    I(1) = 1;
    S(1) = N - R(1) - I(1);

    for t = 1:number_of_days - 1          
        S(t + 1) = S(t) - beta*S(t) * I(t) / N;
        I(t + 1) = I(t) + beta*S(t) * I(t) / N - gamaR * I(t);
        R(t + 1) = R(t) + gamaR * I(t); 
    end
end