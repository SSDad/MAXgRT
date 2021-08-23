function Panel = addPanel(hFig)

h_LoadImage = 0.25;
h_Selection = 0.05;
h_Snake = 0.35;
h_Point = 0.3;
h_About = 1-h_LoadImage-h_Snake-h_Point-h_Selection;

w_Left = 0.2;
w_Right = 0.05;
w_Middle = 1-w_Right-w_Left;

h_ContrastBar = 0.05;
h_View = 1-h_ContrastBar;

%% View
Panel.View.hPanel = uipanel('parent', hFig,...
                                'Unit', 'Normalized',...
                                'Position', [w_Left, 0, w_Middle, h_View], ...
                                'Title', '',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'visible',                      'on', ...
                                'ForegroundColor',       'k',...
                                'BackgroundColor',       'k', ...
                                'HighlightColor',          'c',...
                                'ShadowColor',            'k');
                            
Panel.View_Cine.hPanel = uipanel('parent', hFig,...
                                'Unit', 'Normalized',...
                                'Position', [w_Left, 0, w_Middle+w_Right, 1], ...
                                'Title', '',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'visible',                      'off', ...
                                'ForegroundColor',       'k',...
                                'BackgroundColor',       'k', ...
                                'HighlightColor',          'c',...
                                'ShadowColor',            'k');


%% Contrast bar
Panel.ContrastBar.hPanel = uipanel('parent', hFig,...
                                'Unit', 'Normalized',...
                                'Position', [w_Left, h_View, w_Middle, h_ContrastBar], ...
                                'Title', '',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'visible',                      'on', ...
                                'ForegroundColor',       'k',...
                                'BackgroundColor',       'k', ...
                                'HighlightColor',          'c',...
                                'ShadowColor',            'k');

%% Slice slider
Panel.SliceSlider.hPanel = uipanel('Parent',                    hFig,...    
                                'Title',                        '',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'Position',                  [w_Left+w_Middle, 0, w_Right, 1],...
                                    'visible',                      'on', ...
                                'ForegroundColor',       'w',...
                                'BackgroundColor',       'black', ...
                                'HighlightColor',          'c',...
                                'ShadowColor',            'black');

%% Load image
Panel.LoadImage.hPanel = uipanel('parent', hFig,...
                                'Unit', 'Normalized',...
                                'Position', [0, 1-h_LoadImage, w_Left, h_LoadImage], ...
                                'Title', '',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'visible',                      'on', ...
                                'ForegroundColor',       'k',...
                                'BackgroundColor',       'k', ...
                                'HighlightColor',          'c',...
                                'ShadowColor',            'k');

Panel.LoadImage_Cine.hPanel = uipanel('parent', hFig,...
                                'Unit', 'Normalized',...
                                'Position', [0, 1-h_LoadImage, w_Left, h_LoadImage], ...
                                'Title', '',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'visible',                      'off', ...
                                'ForegroundColor',       'k',...
                                'BackgroundColor',       'k', ...
                                'HighlightColor',          'c',...
                                'ShadowColor',            'k');

%% Selection
Panel.Selection.hPanel = uipanel('parent', hFig,...
                                'Unit', 'Normalized',...
                                'Position', [0, 1-h_LoadImage-h_Selection, w_Left, h_Selection], ...
                                'Title', '',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'visible',                      'on', ...
                                'ForegroundColor',       'k',...
                                'BackgroundColor',       'k', ...
                                'HighlightColor',          'k',...
                                'ShadowColor',            'k');


%% snake
Panel.Snake.hPanel = uipanel('parent', hFig,...
                                'Unit', 'Normalized',...
                                'Position', [0, h_About+h_Point, w_Left, h_Snake], ...
                                'Title', 'Diaphragm',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'visible',                      'on', ...
                                'ForegroundColor',       'w',...
                                'BackgroundColor',       'k', ...
                                'HighlightColor',          'g',...
                                'ShadowColor',            'k');

%% Body
Panel.Body.hPanel = uipanel('parent', hFig,...
                                'Unit', 'Normalized',...
                                'Position', [0, h_About+h_Point, w_Left, h_Snake], ...
                                'Title', 'Abdomen',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'visible',                      'off', ...
                                'ForegroundColor',       'w',...
                                'BackgroundColor',       'k', ...
                                'HighlightColor',          'g',...
                                'ShadowColor',            'k');


%% point
Panel.Point.hPanel = uipanel('parent', hFig,...
                                'Unit', 'Normalized',...
                                'Position', [0, h_About, w_Left, h_Point], ...
                                'Title', 'Point on Diaphragm',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'visible',                      'on', ...
                                'ForegroundColor',       'w',...
                                'BackgroundColor',       'k', ...
                                'HighlightColor',          'g',...
                                'ShadowColor',            'k');
                            
%% about
Panel.About.hPanel = uipanel('parent', hFig,...
                                'Unit', 'Normalized',...
                                'Position', [0, 0., w_Left, h_About], ...
                                'Title', '',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'visible',                      'off', ...
                                'ForegroundColor',       'w',...
                                'BackgroundColor',       'k', ...
                                'HighlightColor',          'k',...
                                'ShadowColor',            'k');
                            
                            