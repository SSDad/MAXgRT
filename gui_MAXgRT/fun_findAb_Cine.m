function [Ab] = fun_findAb_Cine(J, mBound, TagNo)

bPlot = 0;

%% crop
[M, N] = size(J);
mm = mBound;

n2 = round(N/2);
if TagNo == 3
    n2 = round(N/4);
end
rect = [1 mm(1) n2  diff(mm)];

if bPlot
    figure(101), clf
    imshow(J, []), hold on
    rectangle('Position', rect, 'EdgeColor', 'g')
end

JC = imcrop(J, rect); 
if bPlot
    figure(102), clf
    imshow(JC, [])
end

%% snake
[M, N] = size(JC);
mask = zeros(M, N);

threshold = 0.001/2;
if TagNo == 3
    threshold = 0.001*2;
end
bw = imbinarize(JC, threshold);%, 'adaptive', 'Sensitivity', 0.8);
[~, col] = find(bw, 1);
mask (1:M, 1:col-2) = 1;
bw = activecontour(JC, mask, 80, 'Chan-Vese', 'SmoothFactor', 2);
if bPlot
    figure(103)
    imshow(bw)
    hold on
end

B = bwboundaries(bw);
xx = B{1}(:, 2);
yy = B{1}(:, 1);
if bPlot
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

% sgolay
framelen = round(numel(yy)/4);
if mod(framelen, 2) == 0
    framelen = framelen+1;
end
framelen = min(framelen, 75);

yy = sgolayfilt(yy, 3, framelen); %smooth

if bPlot
    line('XData', xx, 'YData', yy, 'Color', 'r', 'LineWidth', 3) 
end

yy = yy + mm(1) - 1; % orignal coordinates

if bPlot
    figure(101)
    line('XData', xx, 'YData', yy, 'Color', 'r', 'LineWidth', 3) 
end

Ab = [yy xx];
