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

set(data.Measure_Cine.hPlotObj(2), 'XData', t, 'YData', xp);