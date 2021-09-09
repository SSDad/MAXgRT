function updateSnakeMarkWave_Cine(S)

global hFig
data = guidata(hFig);


for n = 1:length(S)
    yp(n) = [];
    if ~isempty(S{n})
        xx = S{n}(:,1);
        yy = S{n}(:,2);
        if min(xx) <= xp && max(xx) >= xp
            yp(n) = interp1(xx, yy, xp);
        end
    end
end
