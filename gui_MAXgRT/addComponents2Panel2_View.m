function Comp = addComponents2Panel2_View(hPanel)
FC = [255 255 102]/255;

axPosition = [0.05 0.09 0.9 0.85];

Comp.hAxis.PlotPoint = axes('Parent',     hPanel, ...
                                'color',        'none',...
                                'xcolor', FC,...
                                'ycolor', FC, ...
                                'gridcolor',   FC,...
                                'Units',                    'normalized', ...
                                'HandleVisibility',     'callback', ...
                                'Position',                 axPosition);

Comp.hAxis.PlotPoint1 = axes('Parent',     hPanel, ...
                                'color',        'none',...
                                'xcolor', FC,...
                                'ycolor', FC, ...
                                'gridcolor',   FC,...
                                'Units',                    'normalized', ...
                                'HandleVisibility',     'callback', ...
                                'Position',                 axPosition);
                            
%% x coordinate                            
hA1 = Comp.hAxis.PlotPoint1;
hA1.YDir = 'normal';
hA1.YAxisLocation = 'right';
hA1.YLabel.String = 'X';
hold(hA1, 'on')

% points - tumor center
hPlotObj.PlotPointTC1.All = line(hA1, 'XData', [], 'YData', [],  'Marker', '.',  'MarkerSize', 16, 'Color', 'b', 'LineStyle', '-');
hPlotObj.PlotPointTC1.Current = line(hA1, 'XData', [], 'YData', [],  'Marker', '.',  'MarkerSize', 24, 'Color', 'r', 'LineStyle', 'none');

% points on diaphragm
hPlotObj.PlotPoint1.All = line(hA1, 'XData', [], 'YData', [],  'Marker', '.',  'MarkerSize', 8, 'Color', 'y', 'LineStyle', '-');
hPlotObj.PlotPoint1.Current = line(hA1, 'XData', [], 'YData', [],  'Marker', '.',  'MarkerSize', 24, 'Color', 'r', 'LineStyle', 'none');                            

%% y coordinate                            
hA = Comp.hAxis.PlotPoint;
hA.YDir = 'reverse';
hA.YLabel.String = 'Y';
hold(hA, 'on')

% points - tumor center
hPlotObj.PlotPointTC.All = line(hA, 'XData', [], 'YData', [],  'Marker', '.',  'MarkerSize', 16, 'Color', 'c', 'LineStyle', '-');
hPlotObj.PlotPointTC.Current = line(hA, 'XData', [], 'YData', [],  'Marker', '.',  'MarkerSize', 24, 'Color', 'r', 'LineStyle', 'none');

% points on diaphragm
hPlotObj.PlotPoint.All = line(hA, 'XData', [], 'YData', [],  'Marker', '.',  'MarkerSize', 16, 'Color', 'g', 'LineStyle', '-');
hPlotObj.PlotPoint.Current = line(hA, 'XData', [], 'YData', [],  'Marker', '.',  'MarkerSize', 24, 'Color', 'r', 'LineStyle', 'none');

% rect
hPlotObj.Rect = images.roi.Rectangle(hA, 'Position',[0, 0, 0, 0], 'Color', 'm', 'LineWidth', .5, 'FaceAlpha', 0.15);
addlistener(hPlotObj.Rect, 'MovingROI', @Callback_Rect_PlotPoint);

FS = 10;
hPlotObj.Text.UL = text(hA, 0, 0, '', 'Color', FC, 'FontSize', FS);
hPlotObj.Text.LL = text(hA, 0, 0, '', 'Color', FC, 'FontSize', FS);
hPlotObj.Text.Gap = text(hA, 0, 0, '', 'Color', FC, 'FontSize', FS);

hPlotObj.Text.UP = text(hA, 0, 0, '', 'Color', 'c', 'FontSize', FS);
hPlotObj.Text.LP = text(hA, 0, 0, '', 'Color', 'c', 'FontSize', FS);
hPlotObj.Text.MP = text(hA, 0, 0, '', 'Color', 'c', 'FontSize', FS);

%%
Comp.hPlotObj = hPlotObj;