function getRGBContourData

global hFig hFig2

data = guidata(hFig);
data2 = guidata(hFig2);

% tumor contour with 1x1 pixel size
[mask_GC, mask_TC, CC_GC, CC_TC, CC_RC, bInd_GC, bInd_TC] = getTumorContour(hFig);
nSlice = length(CC_GC);

% save contour as csv
dataPath = data.FileInfo.DataPath;
matFile = data.FileInfo.MatFile;
[~, fn1, ~] = fileparts(matFile);
ffn = fullfile(dataPath, [fn1, '_TumorContourPoints_RGB.csv']);

if ~exist(ffn, 'file')

    CPM = [];  % Contour Point Matrix
    for iSlice = 1:nSlice
        gC = CC_GC{iSlice};
        tC = CC_TC{iSlice};
        if ~isempty(gC)
            nP = size(gC, 1);
            junk = [iSlice*ones(nP, 1) gC];
            CPM = [CPM; junk];
        elseif ~isempty(tC)
            nP = size(tC, 1);
            junk = [iSlice*ones(nP, 1) tC];
            CPM = [CPM; junk];
        end
    end
    T = array2table(CPM, 'VariableNames',{'Slice #', 'Xt', 'Yt'});
    writetable(T, ffn);

end

% tumor center
[~, fn1, ~] = fileparts(matFile);
ffn = fullfile(dataPath, [fn1, '_TumorCenter_RGB.mat']);
if exist(ffn, 'file')
    load(ffn)
else
    cent.x = nan(nSlice, 1);
    cent.y = nan(nSlice, 1);
    for iSlice = 1:nSlice
        gC = CC_GC{iSlice};
        tC = CC_TC{iSlice};
        if ~isempty(gC)
            cent.x(iSlice) = mean(gC(:,1));
            cent.y(iSlice) = mean(gC(:,2));
        elseif ~isempty(tC)
            cent.x(iSlice) = mean(tC(:,1));
            cent.y(iSlice) = mean(tC(:,2));
        end
    end
    cent.refx = mean(CC_RC{1}(:,1));
    cent.refy = mean(CC_RC{1}(:,2));
    save(ffn, 'cent')

    % csv
    CM = [(1:nSlice)' cent.x cent.y];
   
    ffn = fullfile(dataPath, [fn1, '_TumorCenterPoints_RGB.csv']);
    T = array2table(CM, 'VariableNames',{'Slice #', 'Xc', 'Yc'});
    writetable(T, ffn);

end