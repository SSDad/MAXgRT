function  ovAll = fun_getCineTumorOL(cineData)

for n = 1:length(cineData)
    M = cineData(n).mImg;
    N = cineData(n).nImg;
    s = cineData(n).Tumor.Snakes;
    ov = zeros(M, N);

    for m = 1:length(s)
        c = s{m};
        if ~isempty(c)
%             xx = c(:, 1) - LimN(1) +1;
%             yy = c(:, 2) - LimM(1) +1;
            ov = ov + poly2mask(c(:, 1), c(:, 2), M, N);
        end
    end

    ovAll{n} = ov;
end