function [C, idxC] = fun_extractContour(I)

for n = 1:3
    J = I(:,:,n);
    maxJ = max(J(:));
    BW = J==maxJ;

    % contour
    B = bwboundaries(BW);

    pA = zeros(1, length(B));
    for nn = 1:length(B)
        pA(nn) = polyarea(B{nn}(:, 1), B{nn}(:, 2));
    end

    [polyA(n), idx] = max(pA);
    CC{n} = fliplr(B{idx});
end
[~, idxC] = max(polyA);

% in case of ring
if idxC == 1
    r2 = polyA(2)/polyA(1);
    r3 = polyA(3)/polyA(1);
    if r2>1/40
        idxC = 2;
    elseif r3>1/40
        idxC = 3;
    end
end
C = CC{idxC};