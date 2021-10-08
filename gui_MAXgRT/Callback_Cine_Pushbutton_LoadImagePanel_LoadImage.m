function Callback_Cine_Pushbutton_LoadImagePanel_LoadImage(src, evnt)

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

matPath = fullfile(dataPath, 'mat');
dcmPath = fullfile(dataPath, 'dicom');
data.FileInfo.CineDataPath = dataPath;
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

data.cine.Panel.View.subPanel = addComponents2Panel_Cine_View(data.cine.Panel.View.hPanel, fileList);
% data.cine = [];
%% load data
bSC = false(3,1);
ffn = fullfile(matPath, 'sag.mat');
% data.cine(1) = [];
if exist(ffn, 'file')
    bSC(1) = 1;
    load(ffn)
    data.cine.data(1).v = cineData.v;
    [data.cine.data(1).mImg, data.cine.data(1).nImg, data.cine.data(1).nSlice] = size(cineData.v);
    data.cine.data(1).x0 = cineData.IMP(1);
    data.cine.data(1).y0 = cineData.IMP(2);
    data.cine.data(1).dx = cineData.PS(1);
    data.cine.data(1).dy = cineData.PS(2);
    clearvars cineData;
end

ffn = fullfile(matPath, 'cor.mat');
% data.cine(2) = [];
if exist(ffn, 'file')
    bSC(2) = 1;
    load(ffn)
    data.cine.data(2).v = cineData.v;
    [data.cine.data(2).mImg, data.cine.data(2).nImg, data.cine.data(2).nSlice] = size(cineData.v);
    data.cine.data(2).x0 = cineData.IMP(1);
    data.cine.data(2).y0 = cineData.IMP(2);
    data.cine.data(2).dx = cineData.PS(1);
    data.cine.data(2).dy = cineData.PS(2);
    clearvars cineData;
end

ffn = fullfile(matPath, 'sc.mat');
% data.cine(3) = [];
if exist(ffn, 'file')
    bSC(3) = 1;
    load(ffn)
    data.cine.data(3).v = cat(2, cineData.sag, cineData.cor);
    % data.cine(3).sag = cineData.sag;
    % data.cine(3).cor = cineData.cor;
    [data.cine.data(3).mImg, data.cine.data(3).nImg, data.cine.data(3).nSlice] = size(data.cine.data(3).v);
    data.cine.data(3).x0 = cineData.IMP(1);
    data.cine.data(3).y0 = cineData.IMP(2);
    data.cine.data(3).dx = cineData.PS(1);
    data.cine.data(3).dy = cineData.PS(2);
    clearvars cineData;
end

% for n = 1:3
%     data.cine(n).x0 = 0;
%     data.cine(n).y0 = 0;
%     data.cine(n).dx = 1;
%     data.cine(n).dy = 1;
% end

data.cine.bSC = bSC;
guidata(hFig, data);

%% view
% data.cine(1).iSlice = 1;
% data.cine(2).iSlice = 1;
% data.cine(3).iSlice = 1;

data.cine.ActiveTagNo = [];

% cineImg{1} = data.cine.sag(:, :, data.cine.iSlice(1));
% [~, ~, data.cine.nSlice(1)] = size(data.cine.sag);
% cineImg{2} = data.cine.cor(:, :, data.cine.iSlice(2));
% [~, ~, data.cine.nSlice(2)] = size(data.cine.cor);
% J1 = data.cine.sc.sag(:, :, data.cine.iSlice(3));
% J2 = data.cine.sc.cor(:, :, data.cine.iSlice(3));
% cineImg{3} = [J1 J2];
% [~, ~, data.cine.nSlice(3)] = size(data.cine.sc.sag);

 for n = find(bSC)'
    data.cine.data(n).iSlice = 1;
    
    % RA
    x0 =  data.cine.data(n).x0;
    y0 = data.cine.data(n).y0;
    dx = data.cine.data(n).dx;
    dy = data.cine.data(n).dy;
    xWL(1) = x0-dx/2;
    xWL(2) = xWL(1)+dx*data.cine.data(n).nImg;
    yWL(1) = y0-dy/2;
    yWL(2) = yWL(1)+dy*data.cine.data(n).mImg;
    RA = imref2d([data.cine.data(n).mImg data.cine.data(n).nImg], xWL, yWL);
    data.cine.data(n).RA = RA;
    
    % axis and image
    hA = data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hAxis.Image;
    I = data.cine.data(n).v(:, :, data.cine.data(n).iSlice);
    data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj.Image =...
        imshow(I, RA, [], 'parent', hA);
    
    % slider
    hSS =  data.cine.Panel.View.subPanel(n).ssPanel(4).Comp.hSlider.Slice;
    hSS.Min = 1;
    hSS.Max = data.cine.data(n).nSlice;
    hSS.Value = data.cine.data(n).iSlice;
    hSS.SliderStep = [1 10]/(data.cine.data(n).nSlice-1);

    data.cine.Panel.View.subPanel(n).ssPanel(4).Comp.hText.nImages.String...
        = [num2str(data.cine.data(n).iSlice), ' / ', num2str(data.cine.data(n).nSlice)];

%     waitbar(1, hWB, 'All slices are loaded!');
%     pause(1);
%     close(hWB);

    %contrast
    yc = histcounts(I, max(I(:))+1);
    yc = log10(yc);
    yc = yc/max(yc);
    xc = 1:length(yc);
    xc = xc/max(xc);

     data.cine.Panel.View.subPanel(n).ssPanel(2).Comp.hPlotObj.Hist.XData = xc;
     data.cine.Panel.View.subPanel(n).ssPanel(2).Comp.hPlotObj.Hist.YData = yc;
     
    % snake
    hPlotObj = data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj;
    hPlotObj.Snake = line(hA, 'XData', [], 'YData', [], 'Color', 'm', 'LineStyle', '-', 'LineWidth', 3);
    hPlotObj.Snake2 = line(hA, 'XData', [], 'YData', [], 'Color', 'c', 'LineStyle', '-', 'LineWidth', 3);
    axis(hA, 'tight', 'equal', 'on');
   
    % body
    x0 = data.cine.data(n).x0;
    y0 = data.cine.data(n).y0;
    dx = data.cine.data(n).dx;
    dy = data.cine.data(n).dy;
    mImgSize = data.cine.data(n).mImg;
    nImgSize = data.cine.data(n).nImg;
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

    % tumor
    hPlotObj.Tumor = line(hA, 'XData', [], 'YData', [], 'Color', 'c', 'LineStyle', '-', 'LineWidth', 3);


    data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj = hPlotObj;

     % save file names
     if n ~=3
         data.cine.data(n).ffn_Snake_mat = fullfile(data.FileInfo.CineMatPath, ['Snake_', num2str(n), '.mat']);
         data.cine.data(n).ffn_Snake_csv = fullfile(data.FileInfo.CineMatPath, ['SnakePointsMatrix2_', num2str(n), '.csv']);

         data.cine.data(n).Snake.SlitherDone = 0;
         
         data.cine.data(n).ffn_Tumor_mat = fullfile(data.FileInfo.CineMatPath, ['Tumor_', num2str(n), '.mat']);
         data.cine.data(n).ffn_Tumor_csv = fullfile(data.FileInfo.CineMatPath, ['TumorPointsMatrix2_', num2str(n), '.csv']);
     else
         data.cine.data(n).ffn_SnakeL_mat = fullfile(data.FileInfo.CineMatPath, ['SnakeL_', num2str(n), '.mat']);
         data.cine.data(n).ffn_SnakeR_mat = fullfile(data.FileInfo.CineMatPath, ['SnakeR_', num2str(n), '.mat']);
         data.cine.data(n).ffn_SnakeL_csv = fullfile(data.FileInfo.CineMatPath, ['SnakePointsMatrix2L_', num2str(n), '.csv']);
         data.cine.data(n).ffn_SnakeR_csv = fullfile(data.FileInfo.CineMatPath, ['SnakePointsMatrix2R_', num2str(n), '.csv']);

         data.cine.data(n).SnakeL.SlitherDone = 0;
         data.cine.data(n).SnakeR.SlitherDone = 0;

         data.cine.data(n).ffn_TumorL_mat = fullfile(data.FileInfo.CineMatPath, ['TumorL_', num2str(n), '.mat']);
         data.cine.data(n).ffn_TumorR_mat = fullfile(data.FileInfo.CineMatPath, ['TumorR_', num2str(n), '.mat']);
         data.cine.data(n).ffn_TumorL_csv = fullfile(data.FileInfo.CineMatPath, ['TumorPointsMatrix2L_', num2str(n), '.csv']);
         data.cine.data(n).ffn_TumorR_csv = fullfile(data.FileInfo.CineMatPath, ['TumorPointsMatrix2R_', num2str(n), '.csv']);
     end
     
     data.cine.data(n).ffn_Body_mat = fullfile(data.FileInfo.CineMatPath, ['AbsContour_', num2str(n), '.mat']);
     data.cine.data(n).ffn_Body_csv = fullfile(data.FileInfo.CineMatPath, ['AbsContourMatrix2_', num2str(n), '.csv']);

     % enable zoom button
    data.cine.Panel.View.subPanel(n).ssPanel(1).Comp.Pushbutton.Zoom.Enable = 'on';
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

% LoadContour button
data.cine.Panel.LoadImage.Comp.Pushbutton.LoadContour.Enable = 'on';
data.cine.bContourLoaded = 0;

guidata(hFig, data);