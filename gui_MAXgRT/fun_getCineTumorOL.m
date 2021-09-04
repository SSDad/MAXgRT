function  ovAll = fun_getCineTumorOL(cineData)

for n = 1:length(cineData)
    M = cineData(n).mImg;
    N = cineData(n).nImg;
    s = cineData(n).Tumor.Snakes;
    ov = zeros(M, N);

    for m = 1:length(s)
        c = s{m};
        if ~isempty(c)
            xx = (c(:, 1) - cineData.x0)/cineData.dx +1;
            yy = (c(:, 2) -cineData.y0)/cineData.dy +1;
            ov = ov + poly2mask(xx, yy, M, N);
        end
    end

    ovAll{n} = ov;
end