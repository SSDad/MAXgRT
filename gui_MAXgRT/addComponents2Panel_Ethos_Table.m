function Comp = addComponents2Panel_Ethos_Table(hPanel)

h(1:3) = 1/3;
for n = 1:3
    y(n) = 1-sum(h(1:n));
end

w_1 = 1/10;
w_2 = 6/10;
w_3 = 1-w_1-w_2;

TT{1} = 'CT_Sim';
TT{2} = 'MRI_Sim';
TT{3} = 'CBCT_Sim';

FirstColumn = {'CT ', 'MRI', 'CBCT'};

bgc = [0 0 0];
%% Sim Panels
for iS = 1:3

Comp.hPanel.Sim(iS) = uipanel('parent', hPanel,...
            'Unit', 'Normalized',...
            'Position', [0 y(iS) 1 h(iS)], ...
            'Title', TT{iS}, ...
            'FontSize',                 12,...
            'Units',                     'normalized', ...
            'visible',                      'on', ...
            'ForegroundColor',       'c',...
            'BackgroundColor',       'k', ...
            'HighlightColor',          'b',...
            'ShadowColor',            'k', ...
            'Tag', [TT{iS}, '_Panel']);

% first column                
hC1 = uipanel('parent', Comp.hPanel.Sim(iS),...
            'Unit', 'Normalized',...
            'Position', [0 0 w_1 1], ...
            'FontSize',                 12,...
            'Units',                     'normalized', ...
            'visible',                      'on', ...
            'ForegroundColor',       'c',...
            'BackgroundColor',       'k', ...
            'HighlightColor',          'k',...
            'ShadowColor',            'k');

for m = 1:3
    txt.FirstColumn{m} = [FirstColumn{iS}, num2str(m)];
end
nR = length(txt.FirstColumn);
RowRatio = 2*ones(1, nR);
fun_myTable_1Col(hC1, RowRatio, txt, 12, bgc);
        
%Data Table                
Comp.hPanel.SimTable(iS) = uipanel('parent',Comp.hPanel.Sim(iS),...
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
    for iC = 1:3
        txt.DataStr{iR, iC} = '';
    end
    for iC = 4:nC
        txt.DataStr{iR, iC} = '-';
    end
end
RowRatio = ones(1, nR);
ColRatio = ones(1, nC);
[Comp.SimTable(iS).hEdit] = fun_myTable(Comp.hPanel.SimTable(iS), RowRatio, ColRatio, txt, 12, bgc);

clear txt;

for iR = 1:nR
    for iC = 1:3
        Comp.SimTable(iS).hEdit(iR, iC).Tag = ['sim_', num2str(iS), '_', num2str(iR), num2str(iC)];
        Comp.SimTable(iS).hEdit(iR, iC).Callback = @Callback_Ethos_SimTable_;
    end
    for iC = 4:nC
        Comp.SimTable(iS).hEdit(iR, iC).ForegroundColor = 'y';
        Comp.SimTable(iS).hEdit(iR, iC).Enable = 'inactive';
    end
end

end

% I ID Table
Comp.hPanel.CBCTSimID = uipanel('parent', Comp.hPanel.Sim(3),...
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

txt.FirstRow = {'Vertical', 'dVert'};                            
txt.FirstColumn = {'IDENTIFY1'
                              'IDENTIFY2'
                              'IDENTIFY3'};
nR = length(txt.FirstColumn);
nC = length(txt.FirstRow);
for iR = 1:nR
    txt.DataStr{iR, 1} = '';
    txt.DataStr{iR, 2} = '-';
end
RowRatio = 2*ones(1, nR);
ColRatio = ones(1, nC);
[Comp.CBCTSimIDTable.hEdit] = fun_myTable(Comp.hPanel.CBCTSimID, RowRatio, ColRatio, txt, 12, bgc);
for iR = 1:nR
    for iC = 2:nC
        Comp.CBCTSimIDTable.hEdit(iR, iC).ForegroundColor = 'y';
        Comp.CBCTISimDTable.hEdit(iR, iC).Enable = 'inactive';
    end
end