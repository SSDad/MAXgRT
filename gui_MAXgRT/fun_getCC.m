function [bwCAll, mask, bwSum, polyA, CC, bInd] = fun_getCC(cont, M, N)

nC = length(cont);
bwCAll = cell(nC, 1);
mask = false(M, N, nC);
bwSum = zeros(M, N);
CC = cell(nC, 1);
polyA = zeros(nC, 2);
bInd = false(nC, 1);

hWB = waitbar(0, 'Processing RGB tumor contours...');

for iC = 1:nC
    C = cont{iC};
    if ~isempty(C)
        bInd(iC) = true;
        
        bwC = false(N, M);  % original orientation
        for n = 1:size(C, 1)
            bwC(C(n, 2), C(n, 1)) = 1;
        end
        
        bwC = rot90(bwC, 3);  % rotate cw 90
        
        bwCAll{iC} = bwC;

        B = bwboundaries(bwC);
        pA = zeros(1, length(B));
        for n = 1:length(B)
            pA(n) = polyarea(B{n}(:, 1), B{n}(:, 2));
        end

        [polyA(iC, 1), idx] = max(pA);
        polyA(iC, 2) = length(B);
        
        CC{iC} = fliplr(B{idx});

        mask(:,:,iC) = poly2mask(CC{iC}(:, 1), CC{iC}(:, 2), M, N);
        bwSum = bwSum+mask(:,:,iC);
    end
    waitbar(iC/nC, hWB,  'Processing RGB tumor contours...');

end
close(hWB)