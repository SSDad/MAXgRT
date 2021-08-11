function Callback_Pushbutton_LoadImagePanel_LoadImage_Cine(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

%% load cine data
td = tempdir;
fd_info = fullfile(td, 'MAXgRT');
fn_info = fullfile(fd_info, 'info_Cine.mat');
if ~exist(fd_info, 'dir')
    mkdir(fd_info);
end

if ~exist(fn_info, 'file')
    [dataPath] = uigetdir();
    [junk, dataFolder] = fileparts(dataPath);
    [cinePath,~] = fileparts(junk);
    save(fn_info, 'cinePath');
else
    load(fn_info);
    [dataPath] = uigetdir(cinePath);
    [~, dataFolder] = fileparts(dataPath);
end

matPath = fullfile(cinePath, 'mat', dataFolder);
dcmPath = fullfile(cinePath, 'dicom', dataFolder);
data.FileInfo.CineMatPath = matPath;

if ~exist(matPath, 'dir')
    mkdir(matPath);
    fun_readCineDicom(dcmPath, matPath);
end

%% cine view
allFileList = dir(fullfile(matPath, '*.mat'));
idx = find(contains({allFileList.name}','sag.mat'));
if ~isempty(idx)
    fileList{1} = 'sag.mat';
end

idx = find(contains({allFileList.name}','cor.mat'));
if ~isempty(idx)
    fileList{2} = 'cor.mat';
end

idx = find(contains({allFileList.name}','sc.mat'));
if ~isempty(idx)
    fileList{3} = 'sc.mat';
end

data.Panel.View_Cine.subPanel = addComponents2Panel_View_Cine(data.Panel.View_Cine.hPanel, fileList);

%% load data
ffn = fullfile(matPath, 'sag.mat');
load(ffn)
data.cine(1).v = cineData.v;
[data.cine(1).mImg, data.cine(1).nImg, data.cine(1).nSlice] = size(cineData.v);
clearvars cineData;

ffn = fullfile(matPath, 'cor.mat');
load(ffn)
data.cine(2).v = cineData.v;
[data.cine(2).mImg, data.cine(2).nImg, data.cine(2).nSlice] = size(cineData.v);
clearvars cineData;

ffn = fullfile(matPath, 'sc.mat');
load(ffn)
data.cine(3).v = cat(2, cineData.sag, cineData.cor);
% data.cine(3).sag = cineData.sag;
% data.cine(3).cor = cineData.cor;
[data.cine(3).mImg, data.cine(3).nImg, data.cine(3).nSlice] = size(data.cine(3).v);
clearvars cineData;

for n = 1:3
    data.cine(n).x0 = 0;
    data.cine(n).y0 = 0;
    data.cine(n).dx = 1;
    data.cine(n).dy = 1;
end

guidata(hFig, data);

%% view
data.cine(1).iSlice = 1;
data.cine(2).iSlice = 1;
data.cine(3).iSlice = 1;

data.CineActiveTagNo = [];

% cineImg{1} = data.cine.sag(:, :, data.cine.iSlice(1));
% [~, ~, data.cine.nSlice(1)] = size(data.cine.sag);
% cineImg{2} = data.cine.cor(:, :, data.cine.iSlice(2));
% [~, ~, data.cine.nSlice(2)] = size(data.cine.cor);
% J1 = data.cine.sc.sag(:, :, data.cine.iSlice(3));
% J2 = data.cine.sc.cor(:, :, data.cine.iSlice(3));
% cineImg{3} = [J1 J2];
% [~, ~, data.cine.nSlice(3)] = size(data.cine.sc.sag);

for n = 1:3
    hA = data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hAxis.Image;
    I = data.cine(n).v(:, :, data.cine(n).iSlice);
    data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.Image =...
        imshow(I, [], 'parent', hA);
    hPlotObj = data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj;
    hPlotObj.Snake = line(hA, 'XData', [], 'YData', [], 'Color', 'm', 'LineStyle', '-', 'LineWidth', 3);
    axis(hA, 'tight', 'equal');
   
    % slider
    hSS =  data.Panel.View_Cine.subPanel(n).ssPanel(4).Comp.hSlider.Slice;
    hSS.Min = 1;
    hSS.Max = data.cine(n).nSlice;
    hSS.Value = data.cine(n).iSlice;
    hSS.SliderStep = [1 10]/(data.cine(n).nSlice-1);

    data.Panel.View_Cine.subPanel(n).ssPanel(4).Comp.hText.nImages.String...
        = [num2str(data.cine(n).iSlice), ' / ', num2str(data.cine(n).nSlice)];

%     waitbar(1, hWB, 'All slices are loaded!');
%     pause(1);
%     close(hWB);

    %contrast
    yc = histcounts(I, max(I(:))+1);
    yc = log10(yc);
    yc = yc/max(yc);
    xc = 1:length(yc);
    xc = xc/max(xc);

     data.Panel.View_Cine.subPanel(n).ssPanel(2).Comp.hPlotObj.Hist.XData = xc;
     data.Panel.View_Cine.subPanel(n).ssPanel(2).Comp.hPlotObj.Hist.YData = yc;
     
     % body
    x0 = data.cine(n).x0;
    y0 = data.cine(n).y0;
    dx = data.cine(n).dx;
    dy = data.cine(n).dy;
    mImgSize = data.cine(n).mImg;
    nImgSize = data.cine(n).nImg;
    xWL(1) = x0;
    xWL(2) = xWL(1)+dx*nImgSize;
    yWL(1) = y0-dy/2;
    yWL(2) = yWL(1)+dy*mImgSize;

    hPlotObj.Body = line(hA, 'XData', [], 'YData', [], 'Color', 'g', 'LineStyle', '-', 'LineWidth', 0.5);

    hPlotObj.Ab = line(hA,  'XData', [], 'YData', [], 'Color', 'g', 'LineStyle', '-', 'LineWidth', 3, 'Marker', '.');

%     pos = [x0 y0+yWL(2)*2/3
%             xWL(2) y0+yWL(2)*2/3];
%     hPlotObj.AbLine1 = images.roi.Line(hA, 'Color', 'g', 'Position', pos, 'LineWidth', 0.5,...
%         'Tag', 'L1', 'InteractionsAllowed', 'Translate');
%    addlistener(hPlotObj.AbLine1, 'MovingROI', @Callback_Line_AbL1);

    pos = [ x0  y0+yWL(2)/3 xWL(2) yWL(2)/3];
    hPlotObj.AbRect = images.roi.Rectangle(hA, 'Position', pos, 'Color', 'g',...
        'LineWidth', .5, 'FaceAlpha', 0.1, 'Tag', 'AbRec', 'Visible', 'off');
    addlistener(hPlotObj.AbRect, 'MovingROI', @Callback_AbRect_Cine_);
    
    x1 = pos(1);
    x2 = x1+pos(3);
    y1 = pos(2)+pos(4)/2;
    y2 = y1;
    hPlotObj.AbRectCLine = images.roi.Line(hA, 'Position',[x1 y1; x2 y2], 'Color', 'c',...
        'LineWidth', 1, 'Tag', 'AbRecCLine', 'Visible', 'off');
%     addlistener(hPlotObj.AbRectCLine, 'MovingROI', @Callback_AbRectCLine);
  
     data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj = hPlotObj;
     
end

%buttons on Snake
data.Panel.Snake.Comp.Pushbutton.FreeHand.Enable = 'on';
data.Panel.Snake.Comp.Pushbutton.StartSlice.Enable = 'on';
data.Panel.Snake.Comp.Pushbutton.EndSlice.Enable = 'on';
data.Panel.Snake.Comp.Edit.StartSlice.ForegroundColor = 'r';
data.Panel.Snake.Comp.Edit.EndSlice.ForegroundColor = 'r';

%buttons on Body
data.Panel.Body.Comp.Pushbutton.Contour.Enable = 'on';
data.Panel.Body.Comp.Togglebutton.Boundary.Enable = 'on';


guidata(hFig, data);



%
%     if ~exist(fn_info, 'file')
%         [matFile, dataPath] = uigetfile('*.mat');
%         save(fn_info, 'dataPath');
%     else
%         load(fn_info);
%         [matFile, dataPath] = uigetfile([dataPath, '*.mat']);
%         save(fn_info, 'dataPath');
%     end

% if matFile ~=0
%     data.FileInfo.DataPath = dataPath;
%     data.FileInfo.MatFile = matFile;
%     
%     hWB = waitbar(0, 'Loading Images...');
%     
%     [~, fn1, ~] = fileparts(matFile);
%     ffn_GrayImage = fullfile(dataPath, [fn1, '_GrayImage.mat']);
%     ffn_TCont = fullfile(dataPath, [fn1, '_TumorContour.mat']);
%     ffn_TCent = fullfile(dataPath, [fn1, '_TumorCenter.mat']);
%     ffn = fullfile(dataPath, matFile);
%     if ~exist(ffn_GrayImage, 'file')  % first time load
%         load(ffn)
%         %%%%%%%%%%%%%%%%%%%%%%%
%         % tumor rgb contour
%         data.Tumor.gatedContour = gatedContour;
%         data.Tumor.trackContour = trackContour;
%         data.Tumor.refContour = refContour;
%         
% %         data.Panel.Tumor.Comp.Pushbutton.Init.Enable = 'on';
%         %%%%%%%%%%%%%%%%%%%%%%%
% 
%         Image.Images = imgWrite;
%         nSlices = length(imgWrite);
%         [mImgSizeOrg, nImgSizeOrg, ~] = size(imgWrite{1});
%         Image.bContourRemoved = false;
%         
%         data.Panel.LoadImage.Comp.Pushbutton.RemoveContour.Enable = 'on';
% 
%         mImgSize = mImgSizeOrg;
%         nImgSize = nImgSizeOrg;
%         Image.mImgSizeOrg = mImgSizeOrg;
%         Image.nImgSizeOrg = nImgSizeOrg;
% 
%     else
%         load(ffn_GrayImage);
%         Image.Images = grII;
%         nSlices = length(grII);
%         [mImgSize, nImgSize] = size(grII{1});
%         
%         load(ffn_TCont);
%         load(ffn_TCent);
%         data.Tumor.cent = cent;
%         data.Tumor.eCont = eCont;
%         data.Tumor.indC = indC;
%         data.Tumor.eContXY = eContXY;
%         data.Tumor.snakeCont = snakeCont;
%         data.Tumor.snakeContLimM = snakeContLimM;
%         data.Tumor.snakeContLimN = snakeContLimN;
%         data.Tumor.snakeContXY = snakeContXY;
%         data.Tumor.refCont = refCont;
%         data.Tumor.refContXY = refContXY;
% 
%         data.Image.bContourRemoved = 1;
%         
%         Image.bContourRemoved = true;
%         
%     end
%     
%     Image.nSlices = nSlices;
% 
%     Image.indSS = 1:nSlices;
%     Image.SliderValue = 1;
%     Image.FreeHandSlice = [];
% 
%     % image info
%     Image.x0 = 0;
%     Image.y0 = 0;
% 
%     Image.FoV = str2num(data.Panel.LoadImage.Comp.hEdit.ImageInfo(1).String);
%     if mImgSize > nImgSize
%         Image.dy = Image.FoV/mImgSize;
%         Image.dx = Image.dy;
%     else
%         Image.dx = Image.FoV/nImgSize;
%         Image.dy = Image.dx;
%     end
% 
%     % save image info.
%     ImgInfoD2.FoV = Image.FoV;
%     ImgInfoD2.x0 = 0;
%     ImgInfoD2.y0 = 0;
%     
%     [~, fn1, ~] = fileparts(matFile);
%     ffn_ImgInfo = fullfile(dataPath, [fn1, '_ImgInfo.mat']);
%     save(ffn_ImgInfo, 'ImgInfoD2');
%     
%     data.Image = Image;
% 
%     % check previously saved snakes
%     [~, fn1, ~] = fileparts(matFile);
%     ffn_snakes = fullfile(dataPath, [fn1, '_Snake.mat']);
%     data.FileInfo.ffn_snakes = ffn_snakes;
%     if exist(ffn_snakes, 'file')
%         data.Panel.Snake.Comp.Pushbutton.LoadSnake.Enable = 'on';
%     end
%     
%     ffn_SnakePoints = fullfile(dataPath, [fn1, '_SnakePoints.csv']);
%     data.FileInfo.ffn_snakePoints = ffn_SnakePoints;
% 
%     ffn_SnakePointsMatrix = fullfile(dataPath, [fn1, '_SnakePointsMatrix.csv']);
%     data.FileInfo.ffn_snakePointsMatrix = ffn_SnakePointsMatrix;
%     ffn_SnakePointsMatrix2 = fullfile(dataPath, [fn1, '_SnakePointsMatrix2.csv']);
%     data.FileInfo.ffn_snakePointsMatrix2 = ffn_SnakePointsMatrix2;
% 
%     % ffn_points
%     ffn_PointOnSnake = fullfile(dataPath, [fn1, '_PointOnSnake.mat']);
%     data.FileInfo.ffn_PointOnSnake = ffn_PointOnSnake;
% 
%     % ffn_measureData
%     ffn_measureData = fullfile(dataPath, [fn1, '_measureData.mat']);
%     data.FileInfo.ffn_measureData = ffn_measureData;
%     ffn_measureDataFig = fullfile(dataPath, [fn1, '_measureDataFig']);
%     data.FileInfo.ffn_measureDataFig = ffn_measureDataFig;
%     data.FileInfo.ffn_PointData = fullfile(dataPath, [fn1, '_PointData.csv']);
%     
%     data.Snake.Snakes = cell(nSlices, 1);
%     data.Body.Contours = cell(nSlices, 1);
%     data.Body.Abs = cell(nSlices, 1);
% 
%     % ffn_AbsContour
%     ffn_AbsContour = fullfile(dataPath, [fn1, '_AbsContour.mat']);
%     data.FileInfo.ffn_AbsContour = ffn_AbsContour;
% 
%     data.FileInfo.ffn_csv_AbsContour = fullfile(dataPath, [fn1, '_AbsContourMatrix2.csv']);
%     
%     % enable buttons
%     data.Panel.Snake.Comp.Pushbutton.FreeHand.Enable = 'on';
%     data.Panel.Snake.Comp.Pushbutton.StartSlice.Enable = 'on';
%     data.Panel.Snake.Comp.Pushbutton.EndSlice.Enable = 'on';
%     data.Panel.Snake.Comp.Edit.StartSlice.String = '1';
%     data.Panel.Snake.Comp.Edit.EndSlice.String = num2str(nSlices);
%     data.Panel.Snake.Comp.Edit.StartSlice.ForegroundColor = 'r';
%     data.Panel.Snake.Comp.Edit.EndSlice.ForegroundColor = 'r';
% 
%     data.Panel.Body.Comp.Pushbutton.Contour.Enable = 'on';
%     data.Panel.Body.Comp.Togglebutton.Boundary.Enable = 'on';
% 
%     waitbar(1/3, hWB, 'Initializing View...');
% 
%     % CT images
%     iSlice = 1;
% 
%     if Image.bContourRemoved
%         I = data.Image.Images{iSlice};
% 
%         load(ffn_TCent);
%         data.Tumor.cent = cent;
%         
%         load(ffn_TCont);
%         data.Tumor.eCont = eCont;
%         data.Tumor.indC = indC;
%         data.Tumor.eContXY = eContXY;
%         data.Tumor.snakeCont = snakeCont;
%         data.Tumor.snakeContXY = snakeContXY;
%     else
%         I = rot90(Image.Images{iSlice}, 3);
%         
%         [mImgSize, nImgSize] = deal(nImgSizeOrg, mImgSizeOrg);
%         [Image.dx, Image.dy] = deal(Image.dy, Image.dx);
%     end
%     
%     data.Image.mImgSize = mImgSize;
%     data.Image.nImgSize = nImgSize;
%     
%     % Image Info
%     data.Panel.LoadImage.Comp.hEdit.ImageInfo(2).String = [num2str(mImgSize), 'x', num2str(nImgSize)];
%     data.Panel.LoadImage.Comp.hEdit.ImageInfo(2).ForegroundColor = 'c';
% 
%     data.Panel.LoadImage.Comp.hEdit.ImageInfo(3).String = num2str(Image.dx);
%     data.Panel.LoadImage.Comp.hEdit.ImageInfo(3).ForegroundColor = 'c';
%     
%     x0 = Image.x0;
%     y0 = Image.y0;
%     dx = Image.dx;
%     dy = Image.dy;
%     xWL(1) = x0-dx/2;
%     xWL(2) = xWL(1)+dx*nImgSize;
%     yWL(1) = y0-dy/2;
%     yWL(2) = yWL(1)+dy*mImgSize;
%     RA = imref2d([mImgSize nImgSize], xWL, yWL);
%     data.Image.RA = RA;
% 
%     hA = data.Panel.View.Comp.hAxis.Image;
%     hPlotObj.Image = imshow(I, RA, 'parent', hA);
%     axis(data.Panel.View.Comp.hAxis.Image, 'tight', 'equal')
% 
%     % extracted contour
%     if Image.bContourRemoved
%         hPlotObj.SnakeContour = line(hA, 'XData', [], 'YData',  [], 'LineStyle', '-', 'LineWidth', 1, 'Color', 'm');
%         hPlotObj.SnakeContourCenter = line(hA, 'XData', [], 'YData', [], 'LineStyle', 'none', 'Marker', '.', 'MarkerSize', 16, 'Color', 'm');
%         if ~isempty(snakeContXY{iSlice})
%             set(hPlotObj.SnakeContour, 'XData', snakeContXY{iSlice}(:, 1), 'YData',  snakeContXY{iSlice}(:, 2));
%             set(hPlotObj.SnakeContourCenter, 'XData', cent.x(iSlice), 'YData', cent.y(iSlice));
%         end
% 
%         CLR = 'rgb';
%         hPlotObj.RGBContour = line(hA, 'XData', eContXY{iSlice}(:, 1), 'YData', eContXY{iSlice}(:, 2),...
%             'LineStyle', '-', 'LineWidth', 1, 'Color', CLR(indC(iSlice)));
%         hPlotObj.RGBContourCenter = line(hA, 'XData',  mean(eContXY{iSlice}(:, 1)), 'YData', mean(eContXY{iSlice}(:, 2)),...
%             'LineStyle', 'none', 'Marker', '.', 'MarkerSize', 16, 'Color', CLR(indC(iSlice)));
%     else
%         hPlotObj.RGBContour = line(hA,...
%             'XData', [], 'YData', [], 'LineStyle', '-', 'LineWidth', 1);
%         hPlotObj.RGBContourCenter = line(hA,...
%             'XData', [], 'YData', [], 'LineStyle', 'none', 'Marker', '.', 'MarkerSize', 16);
% 
%         hPlotObj.SnakeContour = line(hA,...
%             'XData', [], 'YData', [], 'LineStyle', '-', 'LineWidth', 1, 'Color', 'm');
%         hPlotObj.SnakeContourCenter = line(hA,...
%             'XData', [], 'YData', [], 'LineStyle', 'none', 'Marker', '.', 'MarkerSize', 16, 'Color', 'm');
%     end
%     
%     % snake
%     hPlotObj.Snake = line(hA,...
%         'XData', [], 'YData', [], 'Color', 'm', 'LineStyle', '-', 'LineWidth', 3);
%     hPlotObj.SnakeMask = line(hA,...
%         'XData', [], 'YData', [], 'Color', 'm', 'LineStyle', '-', 'LineWidth', 1);
% 
%     % point on diaphragm
%     hPlotObj.Point = line(hA,...
%         'XData', [], 'YData', [], 'Color', 'g', 'LineStyle', 'none',...
%         'Marker', '.', 'MarkerSize', 24);
% 
%     hPlotObj.LeftPoints = line(hA,...
%             'XData', [], 'YData', [], 'Color', 'g', 'LineStyle', 'none',...
%             'Marker', '.', 'MarkerSize', 16);
% 
%     hPlotObj.RightPoints = line(hA,...
%             'XData', [], 'YData', [], 'Color', 'g', 'LineStyle', 'none',...
%             'Marker', '.', 'MarkerSize', 16);
% 
%     % body
%     hPlotObj.Body = line(hA, 'XData', [], 'YData', [], 'Color', 'g', 'LineStyle', '-', 'LineWidth', 0.5);
% 
%     hPlotObj.Ab = line(hA,  'XData', [], 'YData', [], 'Color', 'g', 'LineStyle', 'none', 'LineWidth', 3, 'Marker', '.');
% 
% %     pos = [x0 y0+yWL(2)*2/3
% %             xWL(2) y0+yWL(2)*2/3];
% %     hPlotObj.AbLine1 = images.roi.Line(hA, 'Color', 'g', 'Position', pos, 'LineWidth', 0.5,...
% %         'Tag', 'L1', 'InteractionsAllowed', 'Translate');
% %    addlistener(hPlotObj.AbLine1, 'MovingROI', @Callback_Line_AbL1);
% 
%     pos = [x0 y0+yWL(2)/3 xWL(2) yWL(2)/3];
%     hPlotObj.AbRect = images.roi.Rectangle(hA, 'Position', pos, 'Color', 'g',...
%         'LineWidth', .5, 'FaceAlpha', 0.1, 'Tag', 'AbRec', 'Visible', 'off');
%     addlistener(hPlotObj.AbRect, 'MovingROI', @Callback_AbRect);
%     
%     x1 = pos(1);
%     x2 = x1+pos(3);
%     y1 = pos(2)+pos(4)/2;
%     y2 = y1;
%     hPlotObj.AbRectCLine = images.roi.Line(hA, 'Position',[x1 y1; x2 y2], 'Color', 'c',...
%         'LineWidth', 1, 'Tag', 'AbRecCLine', 'Visible', 'off');
%     addlistener(hPlotObj.AbRectCLine, 'MovingROI', @Callback_AbRectCLine);
%   
%     data.Panel.View.Comp.hPlotObj = hPlotObj;
% 
%     % slider
%     hSS = data.Panel.SliceSlider.Comp.hSlider.Slice;
%     hSS.Min = 1;
%     hSS.Max = nSlices;
%     hSS.Value = iSlice;
%     hSS.SliderStep = [1 10]/(nSlices-1);
% 
%     data.Panel.SliceSlider.Comp.hText.nImages.String = [num2str(iSlice), ' / ', num2str(nSlices)];
% 
%     waitbar(1, hWB, 'All slices are loaded!');
%     pause(1);
%     close(hWB);
% 
%     % contrast
%     yc = histcounts(I, max(I(:))+1);
%     yc = log10(yc);
%     yc = yc/max(yc);
%     xc = 1:length(yc);
%     xc = xc/max(xc);
% 
%     data.Panel.ContrastBar.Comp.hPlotObj.Hist.XData = xc;
%     data.Panel.ContrastBar.Comp.hPlotObj.Hist.YData = yc;
% 
%     data.Snake.SlitherDone = false;
%     data.Point.InitDone = false;
%     data.Tumor.InitDone = false;
%     
%     data.Body.ContourDone = false;
% 
%     guidata(hFig, data);
%     
%      % original contour
%      getRGBContourData;
%      
%     % tumor profile
%     if data.Image.bContourRemoved
%         initTumorProfile;
%     end
% %     Callback_Pushbutton_TumorPanel_Init;
%     
% end