function [xm, yy] = fun_PointOnCurve(C, dx, dy, x0, y0, xi, yy)

xxh = (C(:, 1)-1)*dx+x0;
yyh = (C(:, 2)-1)*dy+y0;

xm = mean(xxh);

n1 = ceil((min(xxh)-x0)/dx);
n2 = floor((max(xxh)-x0)/dx);

for n = n1:n2
    x1 = [xi(n) xi(n)];
    y1 = [1 1e4];
    [~, yc] = polyxpoly(x1, y1, xxh, yyh);
    if length(yc)>1
        yy(n) = max(yc);
    elseif length(yc)==1
        yy(n) = yc;
    end
end