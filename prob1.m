clearvars
close all

f = @(x,y) 20*(x.^2 + y.^2)./sqrt(x.^2 + y.^2 + 0.01);
p = [-0.6, 0.6];
nodHint = 37;

eval('Circlemesh02')

numNodes = size(nodes, 1);
numElem = size(elem, 1);


xNods = nodes(:,1); yNods = nodes(:,2); ff = f(xNods, yNods);

%Part (a)

for e = 1:numElem
    nods = elem(e,:);
    vertexs = nodes(nods,:);
    [alphas, isInside] = baryCoord(vertexs, p);
    if isInside >= 1
        numTriang = e;
        interpF = alphas*ff(nods);
        break;
    end
end

fp = f(p(1,1),p(1,2));
relErr = abs(interpF - fp)/abs(fp);
sz = [1, 3];
tablePartA = table('size', sz, 'VariableTypes',...
    {'int16', 'double', 'double'},...
    'VariableNames',...
    {'numTriang', 'T(p)', 'RelError'});
tablePartA(1,:) = {numTriang, interpF, relErr};

fprintf('\t\tPart (a)\n\n')
disp(tablePartA)

%Part (b)

tempElem = zeros(numElem, 1);
for e = 1:numElem
    nods = elem(e,:);
    vertexs = nodes(nods,:);
    xx = vertexs(:,1); yy = vertexs(:,2);
    xB = sum(xx)/3; yB = sum(yy)/3;
    tempElem(e) = f(xB, yB);
end

[maxTemp, numNodMax] = max(tempElem);
sz = [1, 2];
tablePartB = table('size', sz, 'VariableTypes',...
    {'int16', 'double'},...
    'VariableNames',...
    {'numTriang', 'Temp'});
tablePartB(1,:) = {numNodMax, maxTemp};

fprintf('\n\t\tPart (b)\n\n')
disp(tablePartB)

fprintf('\nHint. For element %d the temperature is %.4e\n',...
    numNodMax,tempElem(nodHint))





