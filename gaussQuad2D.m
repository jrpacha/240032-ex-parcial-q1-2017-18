function intGaussQuad2D = gaussQuad2D(f,vertexs,n)
if size(vertexs,1) ~= 4
    error('Please, give the vertex of a quadrilateral\n')
end

Psi = @(xi, eta) [1-xi-eta+xi.*eta,...
    1+xi-eta-xi.*eta,...
    1+xi+eta+xi.*eta,...
    1-xi+eta-xi.*eta]/4;

DPsi = @(xi, eta) [-1+eta, 1-eta, 1+eta, -1-eta; ...
   -1+xi, -1-xi, 1+xi, 1-xi]/4;

[W,pt2D]=gaussValues2DQuad(n); numGaussPt = length(W);

x = vertexs(:,1); y = vertexs(:,2);         %x and y coordinates of que quadrilateral's vertexs
xiG = pt2D(:,1); etaG = pt2D(:,2);          %Gauss points at standard quadrilateral R = [-1,1]x[-1,1]
xG = Psi(xiG,etaG)*x; yG = Psi(xiG,etaG)*y; %Gauss points at the quadrilateral

intGaussQuad2D = 0.0;                       %Initial value of the quadrature

for i = 1:numGaussPt
    absDetJ = abs(det(DPsi(xiG(i), etaG(i))*vertexs));
    intGaussQuad2D = intGaussQuad2D + W(i)*f(xG(i),yG(i))*absDetJ;
end

end
    








