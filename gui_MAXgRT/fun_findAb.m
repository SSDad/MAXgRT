function [Ab] = fun_findAb(J, mBound)

bPlot = 0;

%% crop
[M, N] = size(J);
mm = mBound;
rect = [1 mm(1) round(N/2) diff(mm)];
if bPlot
    figure(101), clf
    imshow(J), hold on
    rectangle('Position', rect, 'EdgeColor', 'g')
end

JC = imcrop(J, rect); 
if bPlot
    figure(102), clf
    imshow(JC)
end

%% snake
[M, N] = size(JC);
mask = zeros(M, N);

bw = imbinarize(JC, 0.25);
[~, col] = find(bw, 1);
mask (1:M, 1:col-2) = 1;
bw = activecontour(JC, mask, 100, 'Chan-Vese', 'SmoothFactor', 0.4);

B = bwboundaries(bw);
xx = B{1}(:, 2);
yy = B{1}(:, 1);
if bPlot
    figure(103)
    imshow(bw)
    line('XData', xx, 'YData', yy, 'Color', 'g') 
end

%% remove straight lines
ind = xx == 1;  % left
xx(ind) = [];
yy(ind) = [];

ind = yy == 1;  % top
xx(ind) = [];
yy(ind) = [];

ind = yy == M; % bottom
xx(ind) = [];
yy(ind) = [];

yy = sgolayfilt(yy, 3, 75); %smooth

if bPlot
    line('XData', xx, 'YData', yy, 'Color', 'r', 'LineWidth', 3) 
end

yy = yy + mm(1) - 1; % orignal coordinates

if bPlot
    figure(101)
    line('XData', xx, 'YData', yy, 'Color', 'r', 'LineWidth', 3) 
end

Ab = [yy xx];
