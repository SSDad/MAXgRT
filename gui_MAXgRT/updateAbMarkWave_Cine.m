function updateAbMarkWave_Cine(yp, S)

global hFig
data = guidata(hFig);

nS = length(S);
xp = nan(nS, 1);
for n = 1:nS
    if ~isempty(S{n})
        xx = S{n}(:,1);
        yy = S{n}(:,2);
        if min(yy) <= yp && max(yy) >= yp
            [yu, ia, ~] = unique(yy);
            xu = xx(ia);
            
            xp(n) = interp1(yu, xu, yp);
        end
    end
end

t = 1:nS;

set(data.Measure_Cine.hPlotObj.DA(2), 'XData', t, 'YData', xp);

% AbTumorLine
iSlice = round(data.Panel.View_Cine.subPanel(1).ssPanel(4).Comp.hSlider.Slice.Value);
hL = data.Panel.View_Cine.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorLine;
hT = data.Panel.View_Cine.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorText;

if isnan(xp(iSlice))
%     hL.Visible = 'off';
else
    hL.Position(2, :) = [xp(iSlice) yp];

    dx = abs(diff(hL.Position(:, 1)));
    dy = abs(diff(hL.Position(:, 2)));
    formatSpec = '%.1f';
    hT.Position = [xp(iSlice)+5 yp+25];
    hT.String = {['\DeltaX = ', num2str(dx, formatSpec)],...
                            ['\DeltaY = ', num2str(dy, formatSpec)], ...
                            ['D = ', num2str(sqrt(dx^2+dy^2), formatSpec)]};

    
    hL.Label = ''; %['dX = ', num2str(dx, formatSpec), ',  dY = ', num2str(dy, formatSpec)];
%     hL.Visible = 'on';
end