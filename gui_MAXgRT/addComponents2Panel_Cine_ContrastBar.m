function Comp = addComponents2Panel_Cine_ContrastBar(hPanel, TagNo)

global contrastRectLim_Cine

Comp.hAxis.ContrastBar = axes('Parent',        hPanel , ...
                    'color',        [1 1 1]*0.25,...
                    'Units',       'normalized', ...
                    'Position',    [0.1 0.1 0.8 0.8]);
                
hold(Comp.hAxis.ContrastBar, 'on');
Comp.hAxis.ContrastBar.XLim = [0 1];
Comp.hAxis.ContrastBar.YLim = [0 1];

Comp.hPlotObj.Hist = line(Comp.hAxis.ContrastBar,...
    'XData', [], 'YData', [], 'Color', 'w', 'LineStyle', '-', 'LineWidth', 1);
Comp.hPlotObj.Rect = images.roi.Rectangle(Comp.hAxis.ContrastBar,...
    'Position',[0, -0.1,1, 1.2], 'FaceAlpha', 0.3, 'Tag', num2str(TagNo));
addlistener(Comp.hPlotObj.Rect, 'MovingROI', @Callback_Cine_ContrastRect_);

Comp.Panel.Constrast.hAxis = [0 1];
% Comp.Panel.Constrast.hAxis = [0 1];

contrastRectLim_Cine(TagNo, :) = [0 1];