function Comp = addComponents2Panel_Ethos_Tx(hPanel)

mB = 10;
h_gap = 0.025;
hB = (1-h_gap*(1+mB))/(mB);

nB = 2;
w_gap = 0.025;
wB = (1-w_gap*(1+nB))/(nB);

xx = nan(mB, nB);
for n = 1:nB
    xx(:, n) = w_gap*n+wB*(n-1);
end

yy = nan(mB, nB);
for m = 1:mB
    yy(m, :) = h_gap*(mB-m+1)+hB*(mB-m);
end

iB = 0;
for n = 1:nB
    for m = 1:mB
        iB = iB+1;
        Comp.Pushbutton.Tx(iB) = uicontrol('parent', hPanel, ...
                                'Style', 'pushbutton',...
                                'String', ['Fx_ ', num2str(iB)],...
                                'Unit', 'Normalized',...
                                'Position', [xx(m,n) yy(m, n) wB hB], ...
                                'FontSize', 12, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', 'k',...
                                'ForegroundColor', 'c',...
                                'Value', 1, ...
                                'Visible', 'off', ...
                                'Enable', 'on', ...
                                'Tag', num2str(iB), ...
                                'Callback', @Callback_Ethos_Pushbutton_Tx_);
    end
end