function MAXgRT

%% global 
global hFig hFig2
global bZoomSelect bLR
global nEthosTxTable

% global stopSlither
% global reContL
% global contrastRectLim

%% main window

hFig = figure('MenuBar',            'none', ...
                    'Toolbar',              'none', ...
                    'HandleVisibility',  'callback', ...
                    'Name',                'MAXgRT - ViewRay', ...
                    'NumberTitle',      'off', ...
                    'Units',                 'normalized',...
                    'Position',             [0.15 0.1 0.7 0.8],...
                    'Color',                 'black', ...
                    'CloseRequestFcn', @figCloseReq, ...
                    'Visible',               'on');

[data.hMenu, data.hMenuItem] = addMenu(hFig);
[data.tbb] = addToolbar(hFig);
                
data.Panel = addPanel(hFig);
data.Panel.LoadImage.Comp = addComponents2Panel_LoadImage(data.Panel.LoadImage.hPanel);
data.Panel.LoadImage_Cine.Comp = addComponents2Panel_LoadImage_Cine(data.Panel.LoadImage_Cine.hPanel);
data.Panel.Selection.Comp = addComponents2Panel_Selection(data.Panel.Selection.hPanel);
data.Panel.OLView_Cine.Comp = addComponents2Panel_OLView_Cine(data.Panel.OLView_Cine.hPanel);
data.Panel.Measure_Cine.Comp = addComponents2Panel_Measure_Cine(data.Panel.Measure_Cine.hPanel);
data.Panel.MCI_Cine.Comp = addComponents2Panel_MCI_Cine(data.Panel.MCI_Cine.hPanel);
data.Panel.View.Comp = addComponents2Panel_View(data.Panel.View.hPanel);
% data.Panel.View_Cine.Comp = addComponents2Panel_View_Cine(data.Panel.View_Cine.hPanel);
data.Panel.Snake.Comp = addComponents2Panel_Snake(data.Panel.Snake.hPanel);
data.Panel.Body.Comp = addComponents2Panel_Body(data.Panel.Body.hPanel);
data.Panel.ContrastBar.Comp = addComponents2Panel_ContrastBar(data.Panel.ContrastBar.hPanel);
data.Panel.SliceSlider.Comp = addComponents2Panel_SliceSlider(data.Panel.SliceSlider.hPanel);

data.Panel.Point.Comp = addComponents2Panel_Point(data.Panel.Point.hPanel);
data.Panel.About.Comp = addComponents2Panel_About(data.Panel.About.hPanel);

% Ethos mode
data.Ethos.Panel = addPanel_Ethos(hFig);
data.Ethos.Panel.PtInfo.Comp = addComponents2Panel_Ethos_PtInfo(data.Ethos.Panel.PtInfo.hPanel);
data.Ethos.Panel.Data.Comp = addComponents2Panel_Ethos_Data(data.Ethos.Panel.Data.hPanel);
data.Ethos.Panel.Tx.Comp = addComponents2Panel_Ethos_Tx(data.Ethos.Panel.Tx.hPanel);
data.Ethos.Panel.Table.Comp = addComponents2Panel_Ethos_Table(data.Ethos.Panel.Table.hPanel);

data.FC = [255 255 102]/255;
data.ActiveAxis.MovePoints = 0;

data.bMode = 'M';
bZoomSelect = 'D';
bLR = 'N';

hd = '\\bjcfs02.carenet.org\rocdata\ROCData';
if exist(hd, 'dir')
    fd_Ethos = fullfile(hd, 'MAXgRT', 'Ethos');
else
    fd_Ethos = 'C:\MAXgRT\Ethos';
end
% fd_VG = 'C:\VIZ';
if ~exist(fd_Ethos, 'dir')
    mkdir(fd_Ethos);
end
data.Ethos.fd_Ethos = fd_Ethos;
data.Ethos.MRN = [];
nEthosTxTable = 0;

guidata(hFig, data);

%% point fig
hFig2 = figure('MenuBar',            'none', ...
                    'Toolbar',              'none', ...
                    'HandleVisibility',  'callback', ...
                    'Name',                'MAXIM - Diaphragm Measurement', ...
                    'NumberTitle',      'off', ...
                    'Units',                 'normalized',...
                    'Position',             [0.05 0.05 0.9 0.85],...
                    'Color',                 'black', ...
                    'CloseRequestFcn', @fig2CloseReq, ...
                    'Visible',               'off');

addToolbar(hFig2);
data2.Panel = addPanel2(hFig2);
data2.Panel.View.Comp = addComponents2Panel2_View(data2.Panel.View.hPanel);
data2.Panel.Tumor.Comp = addComponents2Panel2_Tumor(data2.Panel.Tumor.hPanel);
data2.Panel.Button.Comp = addComponents2Panel2_Button(data2.Panel.Button.hPanel);
data2.Panel.Button1.Comp = addComponents2Panel2_Button1(data2.Panel.Button1.hPanel);
data2.Panel.Profile.Comp = addComponents2Panel2_Profile(data2.Panel.Profile.hPanel);
guidata(hFig2, data2);
                               
