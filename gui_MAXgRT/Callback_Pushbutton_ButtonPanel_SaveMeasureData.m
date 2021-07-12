function Callback_Pushbutton_ButtonPanel_SaveMeasureData(src, evnt)

global hFig hFig2
data = guidata(hFig);
data2 = guidata(hFig2);

% csv point data
yyd = data.Point.Data.yy;

xd = data.Point.Data.xi(data.Point.Data.ixm);
xxd = repmat(xd, length(data.Point.Data.xx), 1);
for n =1:length(yyd)
    if isnan(yyd(n))
        xxd(n) = nan;
    end
end

A = [data.Point.Data.xx xxd yyd  data.Tumor.cent.x data.Tumor.cent.y];
T = array2table(A, 'VariableNames',{'Slice #', 'Xd', 'Yd', 'Xt', 'Yt'});
writetable(T, data.FileInfo.ffn_PointData);

ffn_Data = data.FileInfo.ffn_measureData;
nF = 0;
if exist(ffn_Data, 'file')
    load(ffn_Data);
    nF = length(measureData);
end
measureData{nF+1} = data.MeasureData;
save(ffn_Data, 'measureData');

ffn_Fig = data.FileInfo.ffn_measureDataFig;
ffn_Fig = [ffn_Fig, '_', num2str(nF+1), '.jpg'];
%exportgraphics(hFig2, ffn_Fig, 'Resolution',300);
saveas(hFig2, ffn_Fig);

% ffn_Fig = [ffn_Fig, '_', num2str(nF+1)];
% print(hFig2, ffn_Fig, '-dpdf')