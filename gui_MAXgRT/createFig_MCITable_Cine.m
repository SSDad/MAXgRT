function createFig_MCITable_Cine(TagNo)

global hFig
data = guidata(hFig);

data.MCI_Cine.hFig = figure('MenuBar',            'none', ...
                                                        'Toolbar',              'none', ...
                                                        'Name',                'Wave', ...
                                                        'NumberTitle',      'off', ...
                                                        'Units',                 'normalized',...
                                                        'Position',             [0.3 0.2 0.3 0.6],...
                                                        'Color',                 'black', ...
                                                        'CloseRequestFcn', @figCloseReq_MCITable_Cine, ...
                                                        'Visible',               'on');
                                                    
%% Table                
data.MCI_Cine.hPanel.MCITable = uipanel('parent', data.MCI_Cine.hFig,...
            'Unit', 'Normalized',...
            'Position', [0 0 1 1], ...
            'Title', '', ...
            'FontSize',                 12,...
            'Units',                     'normalized', ...
            'visible',                      'on', ...
            'ForegroundColor',       'c',...
            'BackgroundColor',       'k', ...
            'HighlightColor',          'b',...
            'ShadowColor',            'k', ...
            'Tag', 'MCITablePanel');
        

h_mri = 0.4;
h_cbct = 0.4;
h_id = 0.2;
% MRI Table                
data.MCI_Cine.hPanel.MRITable = uipanel('parent', data.MCI_Cine.hPanel.MCITable,...
            'Unit', 'Normalized',...
            'Position', [0 1-h_mri 1 h_mri], ...
            'Title', 'MRI', ...
            'FontSize',                 12,...
            'Units',                     'normalized', ...
            'visible',                      'on', ...
            'ForegroundColor',       'c',...
            'BackgroundColor',       'k', ...
            'HighlightColor',          'b',...
            'ShadowColor',            'k', ...
            'Tag', 'MRITablePanel');
        
txt.FirstRow = {'', 'X', 'Y', 'dX', 'dY'};                            
txt.FirstColumn = {'MRI_1, Target '
                              'MRI_1, Abdomen'
                              'MRI_2, Target'
                              'MRI_2, Abdomen'
                              'MRI_3, Target'
                              'MRI_3, Abdomen'};
nR = 6;
nC = 4;
for iR = 1:nR
    for iC = 1:nC
        txt.DataStr{iR, iC} = 'xy';
    end
end
ColRatio = 2/3*ones(1, nC);
[data.MCI_Cine.Table.MRI.hEdit] = fun_myTable(data.MCI_Cine.hPanel.MRITable, nR, ColRatio, txt, 12);

% CBCT Table                
data.MCI_Cine.hPanel.CBCTTable = uipanel('parent', data.MCI_Cine.hPanel.MCITable,...
            'Unit', 'Normalized',...
            'Position', [0 1-h_mri-h_cbct 1 h_cbct], ...
            'Title', 'CBCT', ...
            'FontSize',                 12,...
            'Units',                     'normalized', ...
            'visible',                      'on', ...
            'ForegroundColor',       'c',...
            'BackgroundColor',       'k', ...
            'HighlightColor',          'b',...
            'ShadowColor',            'k', ...
            'Tag', 'CBCTTablePanel');
        
txt.FirstRow = {'', 'X', 'Y', 'dX', 'dY'};                            
txt.FirstColumn = {'CBCT_1, Target '
                              'CBCT_1, Abdomen'
                              'CBCT_2, Target'
                              'CBCT_2, Abdomen'
                              'CBCT_3, Target'
                              'CBCT_3, Abdomen'};
nR = 6;
nC = 4;
for iR = 1:nR
    for iC = 1:nC
        txt.DataStr{iR, iC} = 'xy';
    end
end
ColRatio = 2/3*ones(1, nC);
[data.MCI_Cine.Table.CBCT.hEdit] = fun_myTable(data.MCI_Cine.hPanel.CBCTTable, nR, ColRatio, txt, 12);

% ID Table                
data.MCI_Cine.hPanel.IDTable = uipanel('parent', data.MCI_Cine.hPanel.MCITable,...
            'Unit', 'Normalized',...
            'Position', [0 1-h_mri-h_cbct-h_id 0.65 h_id], ...
            'Title', 'Identify', ...
            'FontSize',                 12,...
            'Units',                     'normalized', ...
            'visible',                      'on', ...
            'ForegroundColor',       'c',...
            'BackgroundColor',       'k', ...
            'HighlightColor',          'b',...
            'ShadowColor',            'k', ...
            'Tag', 'CBCTTablePanel');
        
txt.FirstRow = {'', 'Vertical', 'dVertical'};                            
txt.FirstColumn = {'Identify_1 '
                              'Identify_2'
                              'Identify_3'};
nR = length(txt.FirstColumn);
nC = length(txt.FirstRow) - 1;
for iR = 1:nR
    for iC = 1:nC
        txt.DataStr{iR, iC} = 'xy';
    end
end
ColRatio = 2/3*ones(1, nC);
[data.MCI_Cine.Table.ID.hEdit] = fun_myTable(data.MCI_Cine.hPanel.IDTable, nR, ColRatio, txt, 12);

guidata(hFig, data);