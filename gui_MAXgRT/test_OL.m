clearvars

load('tempData');

n = 1;
cont = data.cine(n).Snake.Snakes;
M = data.cine(n).mImg;
N = data.cine(n).nImg;

figure(11), clf
imshow(data.cine(n).v(:,:,2), []);
hold on
for iSlice = 1:length(cont)
    pt = cont{iSlice};
    if ~isempty(pt)
        line('XData', pt(:, 1), 'YData', pt(:, 2), 'Color', 'g');
    end
end

I = fun_getCineContourOL(cont, M, N, 'D');
red = cat(3, I, zeros(size(I)), zeros(size(I))); 
h = imshow(red);
h.AlphaData = rescale(I);


cont = data.cine(n).Ab.Snakes;
for iSlice = 1:length(cont)
    pt = cont{iSlice};
    if ~isempty(pt)
        line('XData', pt(:, 1), 'YData', pt(:, 2), 'Color', 'g');
    end
end

I = fun_getCineContourOL(cont, M, N, 'A');
red = cat(3, I, zeros(size(I)), zeros(size(I))); 
h = imshow(red);
h.AlphaData = rescale(I);

% hF = figure(11);  clf(hF);
% hA = axes('Parent', hF);


%         line('XData', pt(:, 1), 'YData', pt(:, 2), 'Color', 'b', 'Parent', hA);


% 
% m = 0;
% for iSlice = 1:length(data.cine(n).Snake.Snakes)
%     pt = data.cine(n).Snake.Snakes{iSlice};
%     if ~isempty(pt)m = m+1;
%         xmin(m) = min(pt(:, 1));
%         xmax(m) = max(pt(:, 1));
%         ymin(m) = min(pt(:, 2));
%         ymax(m) = max(pt(:, 2));
% 
%         xx{m} = pt(:, 1);
%         yy{m} = pt(:, 2);
% 
%         line('XData', pt(:, 1), 'YData', pt(:, 2), 'Color', 'b', 'Parent', hA);
%     end
% end
% 
% x1 = max(xmin);
% x2 = min(xmax);
% xp = ceil(x1):floor(x2);
% 
% % hF = figure(12);  clf(hF);
% % hA = axes('Parent', hF);
% 
% for m = 1:length(xx)
%     [xu, ia, ic] = unique(xx{m});
%     yu = yy{m}(ia);
%     yp(m, :) = interp1(xu, yu, xp);
%     line('XData', xp, 'YData', yp(m, :), 'Color', 'r', 'Linestyle', 'non', 'Marker', 'o', 'Parent', hA);
% end
% 
% I = zeros(data.cine(n).mImg, data.cine(n).nImg);
% 
% nn = 0;
% for c = xp(1):xp(end)
%     nn = nn+1;
%     yc = yp(:, nn);
%     r1 = ceil(min(yc));
%     r2 = floor(max(yc));
%     for r = r1:r2
%         I(r, c) = sum(yc >= r);
%     end
% end

    
    
    



%     for iSlice = 1:length(data.cine(n).Ab.Snakes)
%         pt = data.cine(n).Ab.Snakes{iSlice};
%         if ~isempty(pt)
%             line('XData', pt(:, 1), 'YData', pt(:, 2), 'Color', 'w', 'Parent',...
%             data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.hgAb);
%         end
%     end
 