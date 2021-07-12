function [mask] = getTumorMask(C, LimM, LimN)

M = diff(LimM)+1;
N = diff(LimN)+1;
nC = length(C);
mask = false(M, N, nC);

for iC = 1:nC
    if ~isempty(C{iC})
        xx = C{iC}(:, 1) - LimN(1) +1;
        yy = C{iC}(:, 2) - LimM(1) +1;
        mask(:,:,iC) = poly2mask(xx, yy, M, N);
    end
end
    