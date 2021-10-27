function  [ov, ovSum, tCent, tLim] = fun_getCineTumorOL(cineData)

    M = cineData.mImg;
    N = cineData.nImg;
    s = cineData.Tumor.Snakes;
    nS = length(s);

    ov = false(M, N, nS);

    cent = nan(nS, 2);
    xymin = [inf inf];
    xymax = [-inf -inf];
    
    for m = 1:nS
        c = s{m};
        if ~isempty(c)
            cent(m, :) = mean(c);
            xymin = min([xymin; min(c)]);
            xymax = max([xymax; max(c)]);

            xx = (c(:, 1) - cineData.x0)/cineData.dx +1;
            yy = (c(:, 2) -cineData.y0)/cineData.dy +1;
            ov(:, :, m) =poly2mask(xx, yy, M, N);
        end
    end

    ovSum = sum(ov, 3);
    
    tLim = [xymin; xymax];
    tCent = cent;
    
