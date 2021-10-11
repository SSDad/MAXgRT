function createFig_Cine_Measure(TagNo)

global hFig
data = guidata(hFig);

FigName{1} = 'Wave - Sagittal';
FigName{2} = 'Wave - Coronal';
FigName{3} = 'Wave - Sag+Cor';

data.cine.Measure(TagNo).hFig = figure('MenuBar',            'none', ...
                                                        'Toolbar',              'none', ...
                                                        'Name',                FigName{TagNo}, ...
                                                        'NumberTitle',      'off', ...
                                                        'Units',                 'normalized',...
                                                        'Position',             [0.2 0.1 0.6 0.8],...
                                                        'Color',                 'black', ...
                                                        'CloseRequestFcn', @figCloseReq_Cine_Measure, ...
                                                        'Visible',               'off');
                                                    
%% Tumor                   
data.cine.Measure(TagNo).hPanel.Tumor = uipanel('parent', data.cine.Measure(TagNo).hFig,...
            'Unit', 'Normalized',...
            'Position', [0 0.5 1 0.5], ...
            'Title', 'Tumor', ...
            'FontSize',                 12,...
            'Units',                     'normalized', ...
            'visible',                      'on', ...
            'ForegroundColor',       'y',...
            'BackgroundColor',       'k', ...
            'HighlightColor',          'b',...
            'ShadowColor',            'k', ...
            'Tag', 'TumorWavePanel');

%                     tFC{1} = [159 43 104]/255;
tFC{1} = [0 1 0];
tFC{2} = [0 1 1];
yLoc{1} = 'left';
yLoc{2} = 'right';
yLB{1} = 'Horizontal (X) Coordiante (mm)';
yLB{2} = 'Vertical (Y) Coordiante (mm)';
                    
TC = data.cine.data(TagNo).Tumor.Cent;
xx = 1:size(TC, 1);
%                     yy{1} = TC(:, 1);
%                     yy{2} = TC(:, 2);
for n = 1:2
    data.cine.Measure(TagNo).hAxis.Tumor(n) = axes('Parent',      data.cine.Measure(TagNo).hPanel.Tumor, ...
                                        'YAxisLocation',yLoc{n}, ...
                                        'color',        'none',...
                                        'xcolor', 'y',...
                                        'ycolor', tFC{n}, ...
                                        'gridcolor',  tFC{n},...
                                        'Units',                    'normalized', ...
                                        'HandleVisibility',     'callback', ...
                                        'Position',                 [0.05 0.1 0.9 0.85]);
    data.cine.Measure(TagNo).hAxis.Tumor(n).YLabel.String = yLB{n};

    data.cine.Measure(TagNo).hPlotObj.Tumor(n) = line(data.cine.Measure(TagNo).hAxis.Tumor(n),...
                    'XData', xx, 'YData', TC(:, n), ...
                    'Color', tFC{n}, 'LineStyle', '-', 'LineWidth', 2, 'Marker', '.', 'MarkerSize', 24);
    data.cine.Measure(TagNo).hAxis.Tumor(n).XLim =  [xx(1) xx(end)];
end
data.cine.Measure(TagNo).hAxis.Tumor(n).XLabel.String = 'Slice';
linkaxes([data.cine.Measure(TagNo).hAxis.Tumor], 'x')
%                     data.Measure(TagNo).hAxis.Tumor(1).YLim =  data.cine(TagNo).Snake.xyLim(:, 2);

% Check box                   
data.cine.Measure(TagNo).hPanel.TumorCheckBox = uipanel('parent', data.cine.Measure(TagNo).hFig,...
            'Unit', 'Normalized',...
            'Position', [0.8 0.85 0.125 0.1], ...
            'Title', '', ...
            'FontSize',                 12,...
            'Units',                     'normalized', ...
            'visible',                      'on', ...
            'ForegroundColor',       'k',...
            'BackgroundColor',       'k', ...
            'HighlightColor',          'k',...
            'ShadowColor',            'k', ...
            'Tag', 'DACheckBoxPanel');

 nButton = 3;
 h_Gap = 0.05;
 h_Button = (1-h_Gap*(nButton+1))/nButton;
 w_Button = 0.9;
 x_Button = (1-w_Button)/2;

FS = 11;

str{1} = 'Horizontal';
str{2} = 'Vertical';
str{3} = '';

%                     FC2{1} = 'g';
%                     FC2{2} = 'c';
y = 1;
for n = 1:2%nButton
    y = y - h_Gap-h_Button;
    data.cine.Measure(TagNo).TumorCheckBox(n) = uicontrol('parent',  data.cine.Measure(TagNo).hPanel.TumorCheckBox, ...
                                'Style', 'radiobutton',...
                                'String', str{n},...
                                'Unit', 'Normalized',...
                                'Position', [x_Button y w_Button h_Button], ...
                                'FontSize', FS, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', [1 1 1]*0.25,...
                                'ForegroundColor', tFC{n},...
                                'Value', 1, ...
                                'Visible', 'on', ...
                                'Enable', 'on', ...
                                'Tag', str{n}, ...
                                'Callback', @Callback_Cine_Radiobutton_TumorCheckBox_);
end



%% Surrogate                   
data.cine.Measure(TagNo).hPanel.DA = uipanel('parent', data.cine.Measure(TagNo).hFig,...
            'Unit', 'Normalized',...
            'Position', [0 0 1 0.5], ...
            'Title', 'Surrogate', ...
            'FontSize',                 12,...
            'Units',                     'normalized', ...
            'visible',                      'on', ...
            'ForegroundColor',       'y',...
            'BackgroundColor',       'k', ...
            'HighlightColor',          'b',...
            'ShadowColor',            'k', ...
            'Tag', 'DAWavePanel');

%                     FC = [255 255 102]/255;
FC(1, :) = [0 1 0];
FC(2, :) = [0 1 1];
yLoc{1} = 'left';
yLoc{2} = 'right';
yLB{1} = 'Diaphram Vertical Coordiante (mm)';
yLB{2} = 'Abdomen Horizontal Coordiante (mm)';
TT{1} = 'DWave';
TT{2} = 'AWave';

nA = [2 1]; 
for n = 1:nA(TagNo)
    data.cine.Measure(TagNo).hAxis.DA(n) = axes('Parent',      data.cine.Measure(TagNo).hPanel.DA, ...
                                        'YAxisLocation',yLoc{n}, ...
                                        'color',        'none',...
                                        'xcolor', 'y',...
                                        'ycolor', FC(n, :), ...
                                        'gridcolor',   FC(n, :),...
                                        'Units',                    'normalized', ...
                                        'HandleVisibility',     'callback', ...
                                        'Position',                 [0.05 0.1 0.9 0.85]);
    data.cine.Measure(TagNo).hAxis.DA(n).YLabel.String = yLB{n};

    data.cine.Measure(TagNo).hPlotObj.DA(n) = line(data.cine.Measure(TagNo).hAxis.DA(n),  'XData', [], 'YData', [], ...
                    'Color', FC(n, :), 'LineStyle', '-', 'LineWidth', 2, 'Marker', '.', 'MarkerSize', 24);

end
data.cine.Measure(TagNo).hAxis.DA(n).XLabel.String = 'Slice';

% Snake wave
data.cine.Measure(TagNo).hAxis.DA(1).YLim =  data.cine.data(TagNo).Snake.xyLim(:, 2);
guidata(hFig, data);

hLine = data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkLine;
% hLine.Visible = 'on';
xp = hLine.Position(1);
S = hLine.UserData;
updateSnakeMarkWave_Cine(TagNo, xp, S);
data.cine.Measure(TagNo).hAxis.DA(1).XLim =  [1 length(S)];

%Ab wave
if TagNo == 1
    data.cine.Measure(TagNo).hAxis.DA(2).YLim =  data.cine.data(TagNo).Ab.xyLim(:, 1);
    guidata(hFig, data);

    hLine = data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkLine;
%     hLine.Visible = 'on';
    yp = hLine.Position(1, 2);
    S = hLine.UserData;
    updateAbMarkWave_Cine(TagNo, yp, S);
    data.cine.Measure(TagNo).hAxis.DA(2).XLim =  data.cine.Measure(TagNo).hAxis.DA(1).XLim;

    linkaxes([data.cine.Measure(TagNo).hAxis.DA], 'x')
end

% Check box                   
data.cine.Measure(TagNo).hPanel.DACheckBox = uipanel('parent', data.cine.Measure(TagNo).hFig,...
            'Unit', 'Normalized',...
            'Position', [0.7 0.35 0.2 0.1], ...
            'Title', '', ...
            'FontSize',                 12,...
            'Units',                     'normalized', ...
            'visible',                      'on', ...
            'ForegroundColor',       'k',...
            'BackgroundColor',       'k', ...
            'HighlightColor',          'k',...
            'ShadowColor',            'k', ...
            'Tag', 'DACheckBoxPanel');

 nButton = 3;
 h_Gap = 0.05;
 h_Button = (1-h_Gap*(nButton+1))/nButton;
 
 w_Gap = 0.05;
 w(1) = 0.5;
 x(1) = w_Gap;
 y(1) = 1-h_Gap-h_Button;
 
 w(2) = w(1);
 x(2) = x(1);
 y(2) = y(1)-h_Gap-h_Button;
 
 w(3) = 1-w(1)-w_Gap*3;
 x(3) = w(1)+w_Gap*2;
y(3) = y(2);
 
FS = 11;

str{1} = 'Diaphragm';
str{2} = 'Abdomen';
str{3} = 'Inv';

FC2{1} = 'g';
FC2{2} = 'c';
FC2{3} = 'c';

nA = [3 1];
for n = 1:nA(TagNo)%nButton
    data.cine.Measure(TagNo).DACheckBox(n) = uicontrol('parent',  data.cine.Measure(TagNo).hPanel.DACheckBox, ...
                                'Style', 'radiobutton',...
                                'String', str{n},...
                                'Unit', 'Normalized',...
                                'Position', [x(n) y(n) w(n) h_Button], ...
                                'FontSize', FS, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', [1 1 1]*0.25,...
                                'ForegroundColor', FC2{n},...
                                'Value', 1, ...
                                'Visible', 'on', ...
                                'Enable', 'on', ...
                                'Tag', str{n}, ...
                                'Callback', @Callback_Cine_Radiobutton_DACheckBox_);
end

if TagNo == 1
    data.cine.Measure(TagNo).DACheckBox(3).Value = 0;
end

guidata(hFig, data);