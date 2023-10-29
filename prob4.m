clearvars
close all
clc

%Vertexs of the reference quadrilateral R
v1R = [-1,-1]; v2R = [1,-1]; v3R = [1,1]; v4R = [-1,1]; 

%Vertexs of quadrilateral K
v1K = [0,0]; v2K = [2,0]; v3K = [2,2]; v4K = [0,2]; 

%Shape functions for R

Psi1R = @(xi,eta) (1-xi).*(1-eta)/4;
Psi2R = @(xi,eta) (1+xi).*(1-eta)/4;
Psi3R = @(xi,eta) (1+xi).*(1+eta)/4;
Psi4R = @(xi,eta) (1-xi).*(1+eta)/4;

fprintf('Problem 4\n\n')

%Part (a)

pR = [1/2, 1/3]; %pR in R

pK = Psi1R(pR(1),pR(2))*v1K +...
    Psi2R(pR(1),pR(2))*v2K +...
    Psi3R(pR(1),pR(2))*v3K +...
    Psi4R(pR(1),pR(2))*v4K;

fprintf(['(a) pxK = %s\n',...
         '    pyK = %s\n\n'],...
         strtrim(rats(pK(1))), strtrim(rats(pK(2))))

%Remark: Note that we know 'a priori' that pxK and pyK will be rational
%numbers. Exercise: why?

%Plot
vertexsRPlot = [v1R; v2R; v3R; v4R; v1R]; 
vertexsKPlot = [v1K; v2K; v3K; v4K; v1K]; 

h = 0.15;
plot(vertexsRPlot(:,1), vertexsRPlot(:,2), '-', 'color', 'red')
axis([-1.1,2.1,-1.1,2.1])
axis equal
hold on
line = [pR; pK];
plot(line(:,1),line(:,2),'-','color','black','lineWidth',2)
plot(line(1,1),line(1,2),'o','MarkerFaceColor','red', 'MarkerSize',10)
plot(line(2,1),line(2,2),'o','MarkerFaceColor','blue', 'MarkerSize',10)
plot(vertexsKPlot(:,1), vertexsKPlot(:,2), '-', 'color', 'blue')
text(pR(1), pR(2)-h, '$p\in R$','interpreter', 'LaTeX',...
    'FontSize',18, 'color', 'red')
text(pK(1), pK(2)+h, '$\bar{p}\in K$','interpreter', 'LaTeX',...
    'FontSize',18, 'color', 'blue')
text(-1+h,-1+h,'$R$', 'Interpreter','LaTeX','FontSize',18, 'Color','red')
text(1.9-h, h,'$K$', 'Interpreter','LaTeX','FontSize',18, 'Color','blue')
title(['(a) $p = (', strtrim(rats(pR(1))),', ', strtrim(rats(pR(2))),...
    ')\in R\mapsto \bar{p} = (',strtrim(rats(pK(1))), ', ',...
    strtrim(rats(pK(2))), ')\in K$'],...
    'Interpreter','LaTeX','FontSize',18)
hold off

%Part (b)

%Shape functions for K

Psi1K = @(x,y) (2-x).*(2-y)/4;
Psi2K = @(x,y) x.*(2-y)/4;
Psi3K = @(x,y) x.y/4;
Psi3K = @(x,y) (2-x).*y/4;

pK = [1/2, 5/4]; %p in K
pKx = pK(1,1); pKy = pK(1,2);

fprintf('(b) PsiK1(%s, %s) = %s\n',...
         strtrim(rats(pKx)), strtrim(rats(pKy)),...
         strtrim(rats(Psi1K(pKx,pKy))))

%Remark: Note that we know 'a priori' that the answer will be a rational
%number. Exercise: why?
 







