function updateSnakeMarkWave_Cine(xp, S)

global hFig
data = guidata(hFig);

nA = 10; % number of points average on each side
nA = str2double(data.Panel.Measure_Cine.Comp.Edit.NoP.String);

nS = length(S);
yp = nan(nS, 1);
for n = 1:nS
    if ~isempty(S{n})
        xx = S{n}(:,1);
        yy = S{n}(:,2);
        if min(xx) <= xp && max(xx) >= xp
            [xu, ia, ~] = unique(xx);
            yu = yy(ia);

            dx = data.cine.dx;
            xA = xp-dx*nA:dx:xp+dx*nA;
            yA = nan(1, nA*2+1);
            
            for iP = 1:length(xA)
                 if min(xx) <= xA(iP) && max(xx) >= xA(iP)
                     yA(iP) =  interp1(xu, yu, xA(iP));
                 end
            end
            yp(n) = mean(yA, 'omitnan');;

        end
    end
end

t = 1:nS;
set(data.Measure_Cine.hPlotObj.DA(1), 'XData', t, 'YData', yp);

% SnakeTumorLine
iSlice = round(data.Panel.View_Cine.subPanel(1).ssPanel(4).Comp.hSlider.Slice.Value);
hL = data.Panel.View_Cine.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorLine;
hT = data.Panel.View_Cine.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorText;

if isnan(yp(iSlice))
%     hL.Visible = 'off';
else
    hL.Position(2, :) = [xp yp(iSlice)];

    dx = abs(diff(hL.Position(:, 1)));
    dy = abs(diff(hL.Position(:, 2)));
    formatSpec = '%.1f';
    hT.Position = [xp+10 yp(iSlice)-20];
    hT.String = {['\DeltaX = ', num2str(dx, formatSpec)],...
                            ['\DeltaY = ', num2str(dy, formatSpec)], ...
                            ['D = ', num2str(sqrt(dx^2+dy^2), formatSpec)]};

    
    hL.Label = ''; % ['dX = ', num2str(dx, formatSpec), ',  dY = ', num2str(dy, formatSpec)];
%     hL.Visible = 'on';
end