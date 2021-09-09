function Callback_Radiobutton_Measure_Cine_(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

if strcmp(src.Tag, 'Wave')
        hRB = data.Panel.Measure_Cine.Comp.Radiobutton.Measure_Cine(1);
        if hRB.Value
            if isfield(data, 'hFig_Measure_Cine')
                if ishandle(data.hFig_Measure_Cine)
                    data.hFig_Measure_Cine.Visible = 'on';
                else
                    data.hFig_Measure_Cine.Visible = 'off';
                end
            else
                data.hFig_Measure_Cine = figure('MenuBar',            'none', ...
                                                        'Toolbar',              'none', ...
                                                        'Name',                'Wave', ...
                                                        'NumberTitle',      'off', ...
                                                        'Units',                 'normalized',...
                                                        'Position',             [0.2 0.2 0.6 0.6],...
                                                        'Color',                 'black', ...
                                                        'CloseRequestFcn', @figCloseReq_Measure_Cine, ...
                                                        'Visible',               'on');

                guidata(hFig, data);
            end
        else
            data.hFig_Measure_Cine.Visible = 'off';
        end
end
