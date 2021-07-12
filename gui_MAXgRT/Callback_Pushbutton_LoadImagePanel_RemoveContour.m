function Callback_Pushbutton_LoadImagePanel_RemoveContour(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

Image = data.Image;
nSlices = Image.nSlices;

x0 = Image.x0;
y0 = Image.y0;
dx = Image.dx;
dy = Image.dy;

dataPath = data.FileInfo.DataPath;
matFile = data.FileInfo.MatFile;
[~, fn1, ~] = fileparts(matFile);
ffn_GrayImage = fullfile(dataPath, [fn1, '_GrayImage.mat']);
ffn_TCont = fullfile(dataPath, [fn1, '_TumorContour.mat']);
ffn_TCent = fullfile(dataPath, [fn1, '_TumorCenter.mat']);
ffn_TCent_csv = fullfile(dataPath, [fn1, '_TumorCenterPoints.csv']);

cent.x = nan(nSlices, 1);
cent.y = nan(nSlices, 1);

ffn_TCP_csv = fullfile(dataPath, [fn1, '_TumorContourPoints.csv']);
CPM = []; % tumor Contour Point Matrix

imgs = data.Image.Images;
colormap(data.Panel.View.Comp.hAxis.Image, gray);
CLR = 'rgb';

snakeContLimM = [inf 0];
snakeContLimN = [inf 0];

wbStr = 'Removing RGB contours...';
hWB = waitbar(0, wbStr); 
for iSlice = 1:nSlices
    
    J = rot90(imgs{iSlice}, 3);
    grII{iSlice} = fun_removeContours(J);
%     data.Panel.SliceSlider.Comp.hSlider.Slice.Value = iSlice;
    
    [C, idxC] = fun_extractContour(J);
    eCont{iSlice} = C;
    indC(iSlice) = idxC;
    
    % snake
    snakeCont{iSlice} = [];
    snakeContXY{iSlice} = [];
%     set(data.Panel.View.Comp.hPlotObj.SnakeContour, 'XData', [], 'YData', []);
%     set(data.Panel.View.Comp.hPlotObj.SnakeContourCenter, 'XData', [], 'YData', []);
    if idxC > 1
        mask = poly2mask(C(:, 1), C(:, 2), Image.mImgSize, Image.nImgSize);
        bw = activecontour(grII{iSlice}, mask, 20, 'Chan-Vese', 'SmoothFactor', 3, 'ContractionBias', 0.);

        B = bwboundaries(bw);
        nP = zeros(length(B), 1);
        for m = 1:length(B)
            nP(m) = size(B{m}, 1);
        end
        [~, idx] = max(nP);
        S = fliplr(B{idx});
        snakeCont{iSlice} = S;
        
        snakeContLimN(1) = min(snakeContLimN(1), min(S(:, 1)));
        snakeContLimN(2) = max(snakeContLimN(2), max(S(:, 1)));
        snakeContLimM(1) = min(snakeContLimM(1), min(S(:, 2)));
        snakeContLimM(2) = max(snakeContLimM(2), max(S(:, 2)));

        S(:, 1) = (S(:, 1)-1)*dx + x0;
        S(:, 2) = (S(:, 2)-1)*dy + y0;
        snakeContXY{iSlice} = S;
        
        cent.x(iSlice) = mean(S(:, 1));
        cent.y(iSlice) = mean(S(:, 2));

        nP = size(S, 1);
        junk = [iSlice*ones(nP, 1) S];
        CPM = [CPM; junk];
    end
    
    % extracted contour in xy
    C(:, 1) = (C(:, 1)-1)*dx + x0;
    C(:, 2) = (C(:, 2)-1)*dy + y0;
    eContXY{iSlice} = C;
    
    waitbar(iSlice/nSlices, hWB, [wbStr, num2str(iSlice), '/', num2str(nSlices)]);
end

%% ref contour
contRC = data.Tumor.refContour;
iP = round(size(contRC, 1)/2);
[Xout, Yout] = fun_points2contour(contRC(:, 1), contRC(:,2), iP, 'ccw');
refCont = [data.Image.mImgSizeOrg-Yout'+1 Xout'];
refContXY(:, 1) = (refCont(:, 1)-1)*dx + x0;
refContXY(:, 2) = (refCont(:, 2)-1)*dy + y0;

% save data
waitbar(1, hWB, 'Saving gray images and tumor snakes...');

save(ffn_GrayImage, 'grII', '-v7.3');  % gray images
save(ffn_TCont, 'eCont*', 'snakeCont*', 'indC', 'refCont*'); % tumor

save(ffn_TCent, 'cent') % save Tumor Center
CM = [(1:nSlices)' cent.x cent.y];   
TCM = array2table(CM, 'VariableNames',{'Slice #', 'Xc', 'Yc'});
writetable(TCM, ffn_TCent_csv);

% Contour Points Matrix to csv
T = array2table(CPM, 'VariableNames',{'Slice #', 'Xt', 'Yt'});
writetable(T, ffn_TCP_csv); 

close(hWB);
% %% tumor center
% cent.refx = mean(CC_RC{1}(:,1));
% cent.refy = mean(CC_RC{1}(:,2));
%

% update first slice
iSlice = 1;
iSlice = data.Panel.SliceSlider.Comp.hSlider.Slice.Value;
CLR = 'rgb';
data.Panel.View.Comp.hPlotObj.Image.CData = grII{iSlice};

if ~isempty(snakeContXY{iSlice})
    set(data.Panel.View.Comp.hPlotObj.SnakeContour, 'XData', snakeContXY{iSlice}(:, 1), 'YData', snakeContXY{iSlice}(:, 2));
    set(data.Panel.View.Comp.hPlotObj.SnakeContourCenter, 'XData', cent.x(iSlice), 'YData', cent.y(iSlice));
end
set(data.Panel.View.Comp.hPlotObj.RGBContour, 'XData', eContXY{iSlice}(:, 1),...
    'YData', eContXY{iSlice}(:, 2), 'Color', CLR(indC(iSlice)));
set(data.Panel.View.Comp.hPlotObj.RGBContourCenter, 'XData', mean(eContXY{iSlice}(:, 1)),...
    'YData', mean(eContXY{iSlice}(:, 2)), 'Color', CLR(indC(iSlice)));
drawnow

data.Tumor.cent = cent;
data.Tumor.eCont = eCont;
data.Tumor.indC = indC;
data.Tumor.eContXY = eContXY;
data.Tumor.snakeCont = snakeCont;
data.Tumor.snakeContLimM = snakeContLimM;
data.Tumor.snakeContLimN = snakeContLimN;
data.Tumor.snakeContXY = snakeContXY;
data.Tumor.refCont = refCont;
data.Tumor.refContXY = refContXY;

data.Image.Images = grII;
data.Image.bContourRemoved = 1;
data.Panel.LoadImage.Comp.Pushbutton.RemoveContour.Enable = 'off';

guidata(hFig, data);

initTumorProfile;