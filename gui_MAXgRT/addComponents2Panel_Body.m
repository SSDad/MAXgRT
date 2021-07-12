 function Comp = addComponents2Panel_Body(hPanel)

 h_Gap = 0.025;
 
 h_Button = 0.1;
 w_Button = 0.6;
 x_Button = (1-w_Button)/2;
 
 h_SliceNo = 0.4;
 h_reDraw = 0.15;
 h_Save = 0.15;
 
 x_Button = (1-w_Button)/2;
 
nG = 3;

FS = 11;
BC_PB = [1 1 1]*0.25;
BC_TB = [1 1 1]*0.75;

% Load snake
y = 1-h_Gap-h_Button;
Comp.Pushbutton.LoadContour = uicontrol('parent', hPanel, ...
                                'Style', 'pushbutton',...
                                'String', 'Load Contour',...
                                'Unit', 'Normalized',...
                                'Position', [x_Button y w_Button h_Button], ...
                                'FontSize', FS, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', BC_PB,...
                                'ForegroundColor', 'c',...
                                'Visible', 'on', ...
                                'Enable', 'off', ...
                                'Callback', @Callback_Pushbutton_BodyPanel_LoadContour);
                            
y = y-h_Gap*3-h_Button;
Comp.Togglebutton.Boundary = uicontrol('parent', hPanel, ...
                                'Style', 'togglebutton',...
                                'String', 'Boundary Lines',...
                                'Unit', 'Normalized',...
                                'Position', [x_Button y w_Button h_Button], ...
                                'FontSize', FS, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', BC_PB,...
                                'ForegroundColor', 'g',...
                                'Visible', 'on', ...
                                'Enable', 'on', ...
                                'Callback', @Callback_Togglebutton_BodyPanel_Boundary);

y = y-h_Gap-h_Button;
Comp.Pushbutton.Contour = uicontrol('parent', hPanel, ...
                                'Style', 'togglebutton',...
                                'String', 'Delineate',...
                                'Unit', 'Normalized',...
                                'Position', [x_Button y w_Button h_Button], ...
                                'FontSize', FS, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', BC_PB,...
                                'ForegroundColor', 'c',...
                                'Visible', 'on', ...
                                'Enable', 'off', ...
                                'Callback', @Callback_Togglebutton_BodyPanel_Contour);
                            
y = y-h_Gap*3-h_Button;
Comp.Pushbutton.SaveContour = uicontrol('parent', hPanel, ...
                                'Style', 'pushbutton',...
                                'String', 'Save Contour',...
                                'Unit', 'Normalized',...
                                'Position', [x_Button y w_Button h_Button], ...
                                'FontSize', FS, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', BC_PB,...
                                'ForegroundColor', 'c',...
                                'Visible', 'on', ...
                                'Enable', 'on', ...
                                'Callback', @Callback_Pushbutton_BodyPanel_SaveContour);