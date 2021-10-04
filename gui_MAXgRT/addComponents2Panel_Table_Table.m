function Comp = addComponents2Panel_Table_Table(hPanel)

h_mri = 1/3;
h_cbct = 1/3;
h_id = 0;

%% MRI Panel                
Comp.hPanel.MRI = uipanel('parent', hPanel,...
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


w_1 = 1/10;
w_2 = 6/10;
w_3 = 1-w_1-w_2;

% MRI first column                
Comp.hPanel.MRI_1 = uipanel('parent', Comp.hPanel.MRI,...
            'Unit', 'Normalized',...
            'Position', [0 0 w_1 1], ...
            'FontSize',                 12,...
            'Units',                     'normalized', ...
            'visible',                      'on', ...
            'ForegroundColor',       'c',...
            'BackgroundColor',       'k', ...
            'HighlightColor',          'k',...
            'ShadowColor',            'k', ...
            'Tag', 'MRI_1');

txt.FirstColumn = {'MRI1 '
                              'MRI2'
                              'MRI3'};
nR = length(txt.FirstColumn);
RowRatio = 2*ones(1, nR);
fun_myTable_1Col(Comp.hPanel.MRI_1, RowRatio, txt, 12);
        
% MRI Table                
Comp.hPanel.MRITable = uipanel('parent',Comp.hPanel.MRI,...
            'Unit', 'Normalized',...
            'Position', [w_1 0 w_2 1], ...
            'FontSize',                 12,...
            'Units',                     'normalized', ...
            'visible',                      'on', ...
            'ForegroundColor',       'c',...
            'BackgroundColor',       'k', ...
            'HighlightColor',          'k',...
            'ShadowColor',            'k', ...
            'Tag', 'MRITablePanel');
        
txt.FirstRow = {'X', 'Y', 'Z', 'dX', 'dY', 'dZ'};                            
txt.FirstColumn = {'Target '
                              'Abdomen'
                              'Target'
                              'Abdomen'
                              'Target'
                              'Abdomen'};
nR = length(txt.FirstColumn);
nC = length(txt.FirstRow);
for iR = 1:nR
    for iC = 1:nC
        txt.DataStr{iR, iC} = 'xy';
    end
end
RowRatio = ones(1, nR);
ColRatio = ones(1, nC);
[Comp.MRITable.hEdit] = fun_myTable(Comp.hPanel.MRITable, RowRatio, ColRatio, txt, 12);

for iR = 1:nR
    for iC = 1:3
        Comp.MRITable.hEdit(iR, iC).Tag = ['mr', num2str(iR), num2str(iC)];
        Comp.MRITable.hEdit(iR, iC).Callback = @Callback_Table_Table_MRITable;
    end
    for iC = 4:nC
        Comp.MRITable.hEdit(iR, iC).ForegroundColor = 'y';
        Comp.MRITable.hEdit(iR, iC).Enable = 'inactive';
    end
end


%% CBCT_sim panel
yCT(1) = 1-h_mri-h_cbct;
yCT(2) = yCT(1)-h_cbct;
TT{1} = 'CBCT_Sim';
TT{2} = 'CBCT_Tx';

iCT = 1;
    Comp.hPanel.CBCT(iCT) = uipanel('parent', hPanel,...
            'Unit', 'Normalized',...
            'Position', [0 yCT(iCT)  1 h_cbct], ...
            'Title', TT{iCT}, ...
            'FontSize',                 12,...
            'Units',                     'normalized', ...
            'visible',                      'on', ...
            'ForegroundColor',       'c',...
            'BackgroundColor',       'k', ...
            'HighlightColor',          'b',...
            'ShadowColor',            'k');


    % first column                
    txt.FirstColumn = {'CBCT1 '
                              'CBCT2'
                              'CBCT3'};
    Comp.hPanel.CBCT_1(iCT) = uipanel('parent', Comp.hPanel.CBCT(iCT),...
                'Unit', 'Normalized',...
                'Position', [0 0 w_1 1], ...
                'FontSize',                 12,...
                'Units',                     'normalized', ...
                'visible',                      'on', ...
                'ForegroundColor',       'c',...
                'BackgroundColor',       'k', ...
                'HighlightColor',          'k',...
                'ShadowColor',            'k');

    nR = length(txt.FirstColumn);
    RowRatio = 2*ones(1, nR);
    fun_myTable_1Col(Comp.hPanel.CBCT_1(iCT), RowRatio, txt, 12);

    % Table                
    Comp.hPanel.CBCTTable(iCT) = uipanel('parent', Comp.hPanel.CBCT(iCT),...
                'Unit', 'Normalized',...
                'Position', [w_1 0 w_2 1], ...
                'FontSize',                 12,...
                'Units',                     'normalized', ...
                'visible',                      'on', ...
                'ForegroundColor',       'c',...
                'BackgroundColor',       'k', ...
                'HighlightColor',          'k',...
                'ShadowColor',            'k', ...
                'Tag', 'MRITablePanel');

    txt.FirstRow = {'X', 'Y', 'Z', 'dX', 'dY', 'dZ'};                            
    txt.FirstColumn = {'Target '
                                  'Abdomen'
                                  'Target'
                                  'Abdomen'
                                  'Target'
                                  'Abdomen'};
    nR = length(txt.FirstColumn);
    nC = length(txt.FirstRow);
    for iR = 1:nR
        for iC = 1:nC
            txt.DataStr{iR, iC} = 'xy';
        end
    end
    RowRatio = ones(1, nR);
    ColRatio = ones(1, nC);
    [Comp.CBCTTable(iCT).hEdit] = fun_myTable(Comp.hPanel.CBCTTable(iCT), RowRatio, ColRatio, txt, 12);

    for iR = 1:nR
        for iC = 1:3
            Comp.CBCTTable(iCT).hEdit(iR, iC).Tag = ['ct', num2str(iR), num2str(iC)];
            Comp.CBCTTable(iCT).hEdit(iR, iC).Callback = @Callback_Cine_CBCTTable_;
        end
        for iC = 4:nC
            Comp.CBCTTable(iCT).hEdit(iR, iC).ForegroundColor = 'y';
            Comp.CBCTTable(iCT).hEdit(iR, iC).Enable = 'inactive';
        end
    end

    % I ID Table                
    Comp.hPanel.CBCTID(iCT) = uipanel('parent', Comp.hPanel.CBCT(iCT),...
                'Unit', 'Normalized',...
                'Position', [w_1+w_2 0 w_3 1], ...
                'FontSize',                 12,...
                'Units',                     'normalized', ...
                'visible',                      'on', ...
                'ForegroundColor',       'c',...
                'BackgroundColor',       'k', ...
                'HighlightColor',          'k',...
                'ShadowColor',            'k', ...
                'Tag', 'MRITablePanel');

    txt.FirstRow = {'Vertical', 'dVer'};                            
    txt.FirstColumn = {'IDENTIFY1'
                                  'IDENTIFY2'
                                  'IDENTIFY3'};
    nR = length(txt.FirstColumn);
    nC = length(txt.FirstRow);
    for iR = 1:nR
        for iC = 1:nC
            txt.DataStr{iR, iC} = 'id';
        end
    end
    RowRatio = 2*ones(1, nR);
    ColRatio = ones(1, nC);
    [Comp.CBCTIDTable.hEdit] = fun_myTable(Comp.hPanel.CBCTID(iCT), RowRatio, ColRatio, txt, 12);
    for iR = 1:nR
        for iC = 2:nC
            Comp.CBCTIDTable.hEdit(iR, iC).ForegroundColor = 'y';
            Comp.CBCTIDTable.hEdit(iR, iC).Enable = 'inactive';
        end
    end

