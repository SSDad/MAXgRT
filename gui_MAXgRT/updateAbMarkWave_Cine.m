function updateAbMarkWave_Cine(TagNo, yp, S)
global hFig
data = guidata(hFig);

nA = 10; % number of points average on each side
nA = str2double(data.cine.Panel.Measure.Comp.Edit.NoP.String);

nS = length(S);
xp = nan(nS, 1);
for n = 1:nS
    if ~isempty(S{n})
        xx = S{n}(:,1);
        yy = S{n}(:,2);
        
        if min(yy) <= yp && max(yy) >= yp
            [yu, ia, ~] = unique(yy);
            xu = xx(ia);
             
            dy = data.cine.data(TagNo).dy;
            yA = yp-dy*nA:dy:yp+dy*nA;
            xA = nan(1, nA*2+1);
            
            for iP = 1:length(yA)
                 if min(yy) <= yA(iP) && max(yy) >= yA(iP)
                     xA(iP) =  interp1(yu, xu, yA(iP));
                 end
            end
            xp(n) = mean(xA, 'omitnan');;
        end
    end
end

t = 1:nS;

set(data.cine.Measure(TagNo).hPlotObj.DA(2), 'XData', t, 'YData', xp);
hg = data.cine.Measure(TagNo).hPlotObj.DADot(2);
for id = 1:nS
    set(hg.Children(id), 'XData', t(id), 'YData', xp(id));
end

% AbTumorLine
iSlice = round(data.cine.Panel.View.subPanel(min(TagNo, 3)).ssPanel(4).Comp.hSlider.Slice.Value);
% hL = data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorLine;
% hT = data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorText;
hL = data.cine.hPlotObj(TagNo).MarkLines.AbTumorLine;
hT = data.cine.hPlotObj(TagNo).MarkLines.AbTumorText;

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