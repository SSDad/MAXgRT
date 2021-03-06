function Comp = addComponents2Panel_Cine_ZoomButton(hPanel, TagNo)

BC_PB = [1 1 1]*0.25;

Comp.Pushbutton.Zoom = uicontrol('parent', hPanel, ...
                                'Style', 'pushbutton',...
                                'String', 'O',...
                                'Unit', 'Normalized',...
                                'Position', [0.2 0.2 0.6 0.6], ...
                                'FontSize', 12, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', BC_PB,...
                                'ForegroundColor', 'c',...
                                'Visible', 'on', ...
                                'Enable', 'off', ...
                                'Tag', num2str(TagNo), ...
                                'Callback', @Callback_Cine_Pushbutton_ZoomButton_);