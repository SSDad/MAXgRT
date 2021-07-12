function [img_gray] = fun_removeContours(img)

vMax = 1;
if isa(img, 'uint8')
    vMax = 2^8-1;
end

img_gray = img(:,:,1);
[M, N] = size(img_gray);
maskR = (img(:,:,1) == vMax) & (img(:,:,2) == 0) & (img(:,:,3) == 0);
maskG = img(:,:,1) == 0 & img(:,:,2) == vMax & img(:,:,3) == 0;
maskB = (img(:,:,1) == 0) & (img(:,:,2) == 0) & (img(:,:,3) == vMax);
        
maskRGB = maskR|maskG|maskB;
indRGB = find(maskRGB);

for n = 1:length(indRGB)
    [r, c] = ind2sub([M N], indRGB(n));
    r1 = max(r-1, 1);
    r2 = min(r+1, M);
    c1 = max(c-1, 1);
    c2 = min(c+1, N);
    J = img_gray(r1:r2, c1:c2);
    ind = J == vMax | J == 0;
    img_gray(indRGB(n)) = sum(J(~ind))/(9-sum(ind(:)));
end