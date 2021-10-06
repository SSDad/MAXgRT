function Comp = addTxTable2Fig(hPanel)

nT = 10;
h(1:nT) = 1/3;
for n = 1:nT
    y(n) = 1-sum(h(1:n));
    TT{n} = ['CBCT_', num2str(n)];
end

w_1 = 1/10;
w_2 = 6/10;
w_3 = 1-w_1-w_2;

for iT = 1:nT

Comp.hPanel.CBCT(iT) = uipanel('parent', hPanel,...
            'Unit', 'Normalized',...
            'Position', [0 y(iT) 1 h(iT)], ...
            'Title', TT{iT}, ...
            'FontSize',                 12,...
            'Units',                     'normalized', ...
            'visible',                      'on', ...
            'ForegroundColor',       'c',...
            'BackgroundColor',       'k', ...
            'HighlightColor',          'b',...
            'ShadowColor',            'k', ...
            'Tag', [TT{iT}, '_Panel']);

% first column                
hC1 = uipanel('parent', Comp.hPanel.CBCT(iT),...
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
    txt.FirstColumn{m} = ['CBCT', num2str(m)];
end
nR = length(txt.FirstColumn);
RowRatio = 2*ones(1, nR);
fun_myTable_1Col(hC1, RowRatio, txt, 12);
        
%Data Table                
Comp.hPanel.CBCTTable(iT) = uipanel('parent',Comp.hPanel.CBCT(iT),...
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
[Comp.CBCTTable(iT).hEdit] = fun_myTable(Comp.hPanel.CBCTTable(iT), RowRatio, ColRatio, txt, 12);

clear txt;

for iR = 1:nR
    for iC = 1:3
        Comp.CBCTTable(iT).hEdit(iR, iC).Tag = ['sim_', num2str(iT), '_', num2str(iR), num2str(iC)];
        Comp.CBCTTable(iT).hEdit(iR, iC).Callback = @Callback_Ethos_SimTable_;
    end
    for iC = 4:nC
        Comp.CBCTTable(iT).hEdit(iR, iC).ForegroundColor = 'y';
        Comp.CBCTTable(iT).hEdit(iR, iC).Enable = 'inactive';
    end
end


% I ID Table
Comp.hPanel.CBCTID(iT) = uipanel('parent', Comp.hPanel.CBCT(iT),...
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
    txt.DataStr{iR, 1} = '';
    txt.DataStr{iR, 2} = '-';
end
RowRatio = 2*ones(1, nR);
ColRatio = ones(1, nC);
[Comp.CBCTIDTable(iT).hEdit] = fun_myTable(Comp.hPanel.CBCTID(iT), RowRatio, ColRatio, txt, 12);
for iR = 1:nR
    for iC = 2:nC
        Comp.CBCTIDTable(iT).hEdit(iR, iC).ForegroundColor = 'y';
        Comp.CBCTIDTable(iT).hEdit(iR, iC).Enable = 'inactive';
    end
end
clear txt;

end