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