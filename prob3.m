clearvars
close all


%Rectangle R
v1 = [-1,-1]; v2 = [1,-1]; v3 = [1,1]; v4 = [-1,1];
p = [1/2, -1/4]; %p \in R
fp = [-1; 2; 3; 4];

Psi1 = @(xi,eta) (1-xi).*(1-eta)/4;
Psi2 = @(xi,eta) (1+xi).*(1-eta)/4;
Psi3 = @(xi,eta) (1+xi).*(1+eta)/4;
Psi4 = @(xi,eta) (1-xi).*(1+eta)/4;

%Part (a)
alphas = [Psi1(p(1,1),p(1,2)),...
    Psi2(p(1,1),p(1,2)),...
    Psi3(p(1,1),p(1,2)),...
    Psi4(p(1,1),p(1,2))];

clc
fprintf('Problem 3\n')
fprintf('(a) Psi1(%s, %s) = %s\n',...
    strtrim(rats(p(1,1))), strtrim(rats(p(1,2))), strtrim(rats(alphas(1))))

%Part (b)
interpF = alphas*fp;

fprintf('(b) f(%s, %s) = %s\n',...
    strtrim(rats(p(1,1))), strtrim(rats(p(1,2))), strtrim(rats(interpF)))