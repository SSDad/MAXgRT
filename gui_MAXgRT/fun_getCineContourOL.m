function I = fun_getCineContourOL(cont, M, N, DA)

if strcmp(DA, 'A')
    [M, N] = deal(N, M);
end

m = 0;
for iSlice = 1:length(cont)
    pt = cont{iSlice};
    if strcmp(DA, 'A')
        pt = flip(pt, 2);
    end
    if ~isempty(pt)
        m = m+1;
        xmin(m) = min(pt(:, 1));
        xmax(m) = max(pt(:, 1));
        ymin(m) = min(pt(:, 2));
        ymax(m) = max(pt(:, 2));

        xx{m} = pt(:, 1);
        yy{m} = pt(:, 2);

    end
end

x1 = max(xmin);
x2 = min(xmax);
xp = ceil(x1):floor(x2);

for m = 1:length(xx)
    [xu, ia, ~] = unique(xx{m});
    yu = yy{m}(ia);
    yp(m, :) = interp1(xu, yu, xp);
end

I = zeros(M, N);

nn = 0;
for c = xp(1):xp(end)
    nn = nn+1;
    yc = yp(:, nn);
    r1 = ceil(min(yc));
    r2 = floor(max(yc));
    for r = r1:r2
        I(r, c) = sum(yc >= r);
    end
end

if strcmp(DA, 'A')
    I = I';
end