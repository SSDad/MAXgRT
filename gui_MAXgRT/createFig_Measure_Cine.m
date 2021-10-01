function createFig_Measure_Cine(TagNo)

global hFig
data = guidata(hFig);

data.Measure_Cine.hFig = figure('MenuBar',            'none', ...
                                                        'Toolbar',              'none', ...
                                                        'Name',                'Wave', ...
                                                        'NumberTitle',      'off', ...
                                                        'Units',                 'normalized',...
                                                        'Position',             [0.2 0.1 0.6 0.8],...
                                                        'Color',                 'black', ...
                                                        'CloseRequestFcn', @figCloseReq_Measure_Cine, ...
                                                        'Visible',               'on');
                                                    
%% Tumor                   
data.Measure_Cine.hPanel.Tumor = uipanel('parent', data.Measure_Cine.hFig,...
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
                    
TC = data.cine(TagNo).Tumor.Cent;
xx = 1:size(TC, 1);
%                     yy{1} = TC(:, 1);
%                     yy{2} = TC(:, 2);
for n = 1:2
    data.Measure_Cine.hAxis.Tumor(n) = axes('Parent',      data.Measure_Cine.hPanel.Tumor, ...
                                        'YAxisLocation',yLoc{n}, ...
                                        'color',        'none',...
                                        'xcolor', 'y',...
                                        'ycolor', tFC{n}, ...
                                        'gridcolor',  tFC{n},...
                                        'Units',                    'normalized', ...
                                        'HandleVisibility',     'callback', ...
                                        'Position',                 [0.05 0.1 0.9 0.85]);
    data.Measure_Cine.hAxis.Tumor(n).YLabel.String = yLB{n};

    data.Measure_Cine.hPlotObj.Tumor(n) = line(data.Measure_Cine.hAxis.Tumor(n),...
                    'XData', xx, 'YData', TC(:, n), ...
                    'Color', tFC{n}, 'LineStyle', '-', 'LineWidth', 2, 'Marker', '.', 'MarkerSize', 32);
    data.Measure_Cine.hAxis.Tumor(n).XLim =  [xx(1) xx(end)];
end
data.Measure_Cine.hAxis.Tumor(n).XLabel.String = 'Slice';
linkaxes([data.Measure_Cine.hAxis.Tumor], 'x')
%                     data.Measure_Cine.hAxis.Tumor(1).YLim =  data.cine(TagNo).Snake.xyLim(:, 2);

% Check box                   
data.Measure_Cine.hPanel.TumorCheckBox = uipanel('parent', data.Measure_Cine.hFig,...
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
    data.Measure_Cine.TumorCheckBox(n) = uicontrol('parent',  data.Measure_Cine.hPanel.TumorCheckBox, ...
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
                                'Callback', @Callback_Radiobutton_TumorCheckBox_Cine_);
end



%% Surrogate                   
data.Measure_Cine.hPanel.DA = uipanel('parent', data.Measure_Cine.hFig,...
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
for n = 1:2
    data.Measure_Cine.hAxis.DA(n) = axes('Parent',      data.Measure_Cine.hPanel.DA, ...
                                        'YAxisLocation',yLoc{n}, ...
                                        'color',        'none',...
                                        'xcolor', 'y',...
                                        'ycolor', FC(n, :), ...
                                        'gridcolor',   FC(n, :),...
                                        'Units',                    'normalized', ...
                                        'HandleVisibility',     'callback', ...
                                        'Position',                 [0.05 0.1 0.9 0.85]);
    data.Measure_Cine.hAxis.DA(n).YLabel.String = yLB{n};

    data.Measure_Cine.hPlotObj.DA(n) = line(data.Measure_Cine.hAxis.DA(n),  'XData', [], 'YData', [], ...
                    'Color', FC(n, :), 'LineStyle', '-', 'LineWidth', 2, 'Marker', '.', 'MarkerSize', 32);

end
data.Measure_Cine.hAxis.DA(n).XLabel.String = 'Slice';

% Snake wave
data.Measure_Cine.hAxis.DA(1).YLim =  data.cine(TagNo).Snake.xyLim(:, 2);
guidata(hFig, data);

hLine = data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkLine;
hLine.Visible = 'on';
xp = hLine.Position(1);
S = hLine.UserData;
updateSnakeMarkWave_Cine(xp, S);
data.Measure_Cine.hAxis.DA(1).XLim =  [1 length(S)];

%Ab wave
data.Measure_Cine.hAxis.DA(2).YLim =  data.cine(TagNo).Ab.xyLim(:, 1);
guidata(hFig, data);

hLine = data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkLine;
hLine.Visible = 'on';
yp = hLine.Position(1, 2);
S = hLine.UserData;
updateAbMarkWave_Cine(yp, S);
data.Measure_Cine.hAxis.DA(2).XLim =  data.Measure_Cine.hAxis.DA(1).XLim;

linkaxes([data.Measure_Cine.hAxis.DA], 'x')

% Check box                   
data.Measure_Cine.hPanel.DACheckBox = uipanel('parent', data.Measure_Cine.hFig,...
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
for n = 1:3%nButton
    data.Measure_Cine.DACheckBox(n) = uicontrol('parent',  data.Measure_Cine.hPanel.DACheckBox, ...
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
                                'Callback', @Callback_Radiobutton_DACheckBox_Cine_);
end

data.Measure_Cine.DACheckBox(3).Value = 0;

guidata(hFig, data);