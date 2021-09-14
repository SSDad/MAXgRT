function updateSnakeMarkWave_Cine(xp, S)

global hFig
data = guidata(hFig);

nS = length(S);
yp = nan(nS, 1);
for n = 1:nS
    if ~isempty(S{n})
        xx = S{n}(:,1);
        yy = S{n}(:,2);
        if min(xx) <= xp && max(xx) >= xp
            [xu, ia, ~] = unique(xx);
            yu = yy(ia);
            
            yp(n) = interp1(xu, yu, xp);
        end
    end
end

t = 1:nS;

set(data.Measure_Cine.hPlotObj.DA(1), 'XData', t, 'YData', yp);

% SnakeTumorLine
iSlice = round(data.Panel.View_Cine.subPanel(1).ssPanel(4).Comp.hSlider.Slice.Value);
hL = data.Panel.View_Cine.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorLine;

if isnan(yp(iSlice))
    hL.Visible = 'off';
else
    hL.Position(2, :) = [xp yp(iSlice)];

    dx = abs(diff(hL.Position(:, 1)));
    dy = abs(diff(hL.Position(:, 2)));
    formatSpec = '%.1f';
    hL.Label = ['dX = ', num2str(dx, formatSpec), ',  dY = ', num2str(dy, formatSpec)];
    hL.Visible = 'on';
end