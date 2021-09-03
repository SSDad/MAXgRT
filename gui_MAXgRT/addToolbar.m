function tbb = addToolbar(hFig)

%% toolbar          
hToolbar = uitoolbar ('parent', hFig);

% standard
uitoolfactory(hToolbar,'Exploration.ZoomIn');
uitoolfactory(hToolbar,'Exploration.ZoomOut');
uitoolfactory(hToolbar,'Exploration.Pan');                
uitoolfactory(hToolbar,'Exploration.DataCursor');                
% uitoolfactory(hToolbar, 'Exploration.Rotate');

tbb.distance = uipushtool(hToolbar, 'TooltipString', 'Measure Distance',...
    'Enable', 'on', 'ClickedCallback', @Callback_tbb_Distance);
[img,map] = imread('tool_double_arrow.gif');
icon = ind2rgb(img,map);
tbb.distance.CData = icon;