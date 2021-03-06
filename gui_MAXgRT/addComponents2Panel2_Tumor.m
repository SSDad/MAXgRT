function Comp = addComponents2Panel2_Tumor(hPanel)
FC = [255 255 102]/255;

Comp.hAxis.Tumor = axes('Parent',                   hPanel, ...
                            'color',        'none',...
                            'xcolor', FC,...
                            'ycolor', FC, ...
                            'gridcolor',   FC,...
                            'Units',                    'normalized', ...
                            'HandleVisibility',     'callback', ...
                            'Position',                 [0.05 0.025 0.9 0.9]);

Comp.hAxis.Tumor.XAxisLocation='top';
hold(Comp.hAxis.Tumor, 'on')