function [mask_GC, mask_TC, CC_GC, CC_TC, CC_RC, bInd_GC, bInd_TC] = getTumorContour(hFig)

data = guidata(hFig);

dataPath = data.FileInfo.DataPath;
matFile = data.FileInfo.MatFile;

[~, fn1, ~] = fileparts(matFile);
ffn = fullfile(dataPath, [fn1, '_Tumor_RGB.mat']);

if ~exist(ffn, 'file')
%     load(ffn)
%     if ~exist('CC_RC', 'var')
%         [M, N, ~] = size(data.hPlotObj.snakeImage.CData);
%         contRC = data.Tumor.refContour;
%         iP = round(size(contRC, 1)/2);
%         [Xout, Yout]=fun_points2contour(contRC(:, 1), contRC(:,2), iP, 'ccw');
%         CC_RC{1} = [N-Yout'+1 Xout'];
%     
%         % save as 1x1 pixel size
%         nImages = length(contGC);
%         save(ffn, 'bwSum_*', 'mask_*', 'polyA_*', 'CC_*', 'M', 'N', 'nImages', 'bInd_*');
%     end    
%     
% else
    [M, N, ~] = size(data.Panel.View.Comp.hPlotObj.Image.CData);
    contGC = data.Tumor.gatedContour;
    [bwCAll_GC, mask_GC, bwSum_GC, polyA_GC, CC_GC, bInd_GC] = fun_getCC(contGC, M, N);

    contTC = data.Tumor.trackContour;
    [bwCAll_TC, mask_TC, bwSum_TC, polyA_TC, CC_TC, bInd_TC] = fun_getCC(contTC, M, N);

    contRC = data.Tumor.refContour;
    iP = round(size(contRC, 1)/2);
    [Xout, Yout]=fun_points2contour(contRC(:, 1), contRC(:,2), iP, 'ccw');
    CC_RC{1} = [N-Yout'+1 Xout'];
    
    % save as 1x1 pixel size
    nImages = length(contGC);
    save(ffn, 'bwSum_*', 'mask_*', 'polyA_*', 'CC_*', 'M', 'N', 'nImages', 'bInd_*', '-v7.3');
end

for n = 1:length(CC_GC)
    if ~isempty(CC_GC{n})
        CC_GC{n}(:, 1) = (CC_GC{n}(:, 1)-1)*data.Image.dx+data.Image.x0;
        CC_GC{n}(:, 2) = (CC_GC{n}(:, 2)-1)*data.Image.dy+data.Image.y0;
    end
    if ~isempty(CC_TC{n})
        CC_TC{n}(:, 1) = (CC_TC{n}(:, 1)-1)*data.Image.dx+data.Image.x0;
        CC_TC{n}(:, 2) = (CC_TC{n}(:, 2)-1)*data.Image.dy+data.Image.y0;
    end
end

n = 1;
if ~isempty(CC_RC{n})
        CC_RC{n}(:, 1) = (CC_RC{n}(:, 1)-1)*data.Image.dx+data.Image.x0;
        CC_RC{n}(:, 2) = (CC_RC{n}(:, 2)-1)*data.Image.dy+data.Image.y0;
end
%     
% 

% data_main.Tumor.mask_GC = mask_GC;
% data_main.Tumor.mask_TC = mask_TC;
% data_main.Tumor.CC_GC = CC_GC;
% data_main.Tumor.CC_TC = CC_TC;
% 
% guidata(hFig_main, data_main)