function Comp =addComponents2Panel_CineSC_View(hPanel)

FC = [255 255 102]/255;
pos{1} = [0.05 0.025 0.45 0.9];
pos{2} = [0.5 0.025 0.45 0.9];
for n = 1:2
    Comp.hAxis(n).Image = axes('Parent',                   hPanel, ...
                            'color',        'none',...
                            'xcolor', FC,...
                            'ycolor', FC, ...
                            'gridcolor',   FC,...
                            'Units',                    'normalized', ...
                            'HandleVisibility',     'callback', ...
                            'Position',               pos{n});

    Comp.hAxis(n).Image.XAxisLocation='top';
    hold(Comp.hAxis(n).Image, 'on')
end