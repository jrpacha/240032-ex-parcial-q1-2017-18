clearvars
close all

%Required Functions:
%gaussQuad2D
%gaussValues1D %file gaussValues1D.m at folder additionalFiles.zip
%



%Data
f = @(x,y) x.^2 + 5*y.^2;
numGaussPoints1D = 2;
intExact = 90*pi;
alpha = pi/4;
r = 2.0; R = 4.0;

%Positon of the nodes
cosAlpha = cos(alpha); sinAlpha = sin(alpha);

nodes =[2, 0;
    4, 0;
    r*cosAlpha, r*sinAlpha;
    4*cosAlpha, 4*sinAlpha;
    0, 2;
    0, 4
    ];

%Connectivity matrix
elem = [1, 2, 4, 3;
    3, 4, 6, 5];

numNodes = size(nodes,1);
numElem = size(elem, 1);

theta = linspace(0, pi/2, 201);

xr = r*cos(theta); yr = r*sin(theta);
Xr = R*cos(theta); Yr = R*sin(theta);

plotElementsOld(nodes, elem, 1);
hold on
plot(xr, yr, '--r', Xr, Yr, 'r--')
hold off

%Part (a)
%Compute the area of quadrilaterals

%a.1-By decomposition in triangles
approxArea = 0.0;
columnOnes = ones(3,1);

for e = 1:numElem
    vertexs = nodes(elem(e,[1,2,3]),:);
    approxArea = approxArea + det([columnOnes, vertexs]);
    vertexs = nodes(elem(e,[3,4,1]),:);
    approxArea = approxArea + det([columnOnes, vertexs]);
end

approxArea = 0.5*approxArea;
realArea = (R^2 - r^2)*alpha;
relErrArea = abs(realArea-approxArea)/realArea;

format short e
format compact
fprintf('Problem 2\n\n\t\tPart (a)\n\n')
fprintf('(a.1) By decomposition in triangles\n\n')
tablePartA1 = table(approxArea, relErrArea, 'VariableNames',...
    {'AreaApprox', 'RelError'});
disp(tablePartA1);

%a.2-Using functions 'polyshape' and 'area'
approxArea = 0.0;
for e = 1:numElem
    quad = polyshape(nodes(elem(e,:),1),nodes(elem(e,:),2));
    approxArea = approxArea + area(quad);
end

relErrArea = abs(realArea-approxArea)/realArea;
fprintf('\n(a.2) By using functions ''polyshape'' and ''area''\n\n')
TablePartA2 = table(approxArea, relErrArea, 'VariableNames',...
    {'AreaApprox', 'RelError'});
disp(TablePartA2);

%a.3-By gussian quadrature
g = @(x,y) 1+x-x; %We integrate the constant functon g = 1
quadElem = zeros(numElem,1);
for e = 1:numElem
    vertexs = nodes(elem(e,:),:);
    quadElem(e) = gaussQuad2D(g, vertexs, numGaussPoints1D);
end
approxArea = sum(quadElem);

relErrArea = abs(realArea-approxArea)/realArea;
fprintf('\n(a.2) By Gaussian quadrature\n\n')
TablePartA3 = table(approxArea, relErrArea, 'VariableNames',...
    {'AreaApprox', 'RelError'});
disp(TablePartA3);

%Part (b) 
%Compute gauss quadrature of the elements and sum over the elements
%quadElem = zeros(numElem,1);
for e = 1:numElem
    vertexs = nodes(elem(e,:),:);
    quadElem(e) = gaussQuad2D(f, vertexs, numGaussPoints1D);
end
intApprox = sum(quadElem);
relErrInt = abs(intApprox-intExact)/intExact;

fprintf('\n\t\tPart(b)\n\n')
tablePartB = table(intApprox, relErrInt, 'VariableNames',...
    {'AreaApprox', 'RelError'});
disp(tablePartB);
fprintf(['\nHint. The value of the integral for f(x,y) at\n',...
    'the first element is: %.4e\n'], quadElem(1))



