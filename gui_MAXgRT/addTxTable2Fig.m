function Comp = addTxTable2Fig(hPanel, bgc)

FS = 12;

Comp.hPanel.CBCT = uipanel('parent', hPanel,...
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
            'Tag', ['CBCT_Panel']);

nC = 11;
nR = 6;
RowRatio = 2*ones(nR, 1);
RowRatio(1) = 1;
hPanel = RowRatio/sum(RowRatio);

%% all panel (vertically)
yP = 1;
for iR = 1:nR
    yP = yP-hPanel(iR);
    hSubPanel(iR) = uipanel('parent', Comp.hPanel.CBCT,...
            'Unit', 'Normalized',...
            'Position', [0 yP 1 hPanel(iR)], ...
            'FontSize',                 12,...
            'Units',                     'normalized', ...
            'visible',                      'on', ...
            'ForegroundColor',       'c',...
            'BackgroundColor',       'k', ...
            'HighlightColor',          'k',...
            'ShadowColor',            'k',...
            'Tag', ['FirstColumn_Panel']);
end

%% first panel
ColRatio = ones(nC, 1);
txtFR = {'', '', 'X', 'Y', 'Z', 'dX', 'dY', 'dZ', '', 'Vertical', 'dVert'};
fun_myTable_1Row(hSubPanel(1), ColRatio, txtFR, 12, bgc);
clear ColRatio;

% %Data Table  
ColRatio(1) = 1/nC;
ColRatio(2) = 7/nC;
ColRatio(3) = 3/nC;
nC = length(ColRatio);
wP = ColRatio/sum(ColRatio);

for iR = 1:nR-1
    for iC = 1:nC
        hSSPanel(iC) = uipanel('parent',hSubPanel(iR+1),...
            'Unit', 'Normalized',...
            'Position', [sum(wP(1:iC-1))  0 wP(iC) 1], ...
            'FontSize',                 12,...
            'Units',                     'normalized', ...
            'visible',                      'on', ...
            'ForegroundColor',       'c',...
            'BackgroundColor',       'k', ...
            'HighlightColor',          'k',...
            'ShadowColor',            'k');
    end
    
    % first column - 'CBCT'
    txtCT = ['CBCT', num2str(iR)];
    uicontrol('parent', hSSPanel(1), ...
                    'Style', 'text',...
                    'String', txtCT,...
                    'Unit', 'Normalized',...
                    'Position', [0 0 1 1], ...
                    'FontSize', FS, ...
                    'FontWeight', 'bold', ...
                    'BackgroundColor', bgc,...
                    'ForegroundColor', 'w',...
                    'Visible', 'on');

    % 'TA' table
    txt.FirstColumn = {'Target'; 'Abdomen'};
    RowRatio = [1 1];
    nR2 = length(txt.FirstColumn);
    nC2 = 6;
    ColRatio = ones(1, nC2);
    for iR2 = 1:nR2
        for iC = 1:3
            txt.DataStr{iR2, iC} = '';
        end
        for iC = 4:nC2
            txt.DataStr{iR2, iC} = '-';
        end
    end
    [Comp.TATable.hEdit] = fun_myTable_noFirstRow(hSSPanel(2), RowRatio, ColRatio, txt, 12, bgc);

    
    % 'ID' table
    txt.FirstColumn{1} = ['IDENTIFY', num2str(iR)];
    nR3 = length(txt.FirstColumn);
    RowRatio = [1];
    nC3 = 2;
    ColRatio = ones(1, nC3);
    for iR3 = 1:nR3
        txt.DataStr{iR3, 1} = '';
        txt.DataStr{iR3, 2} = '-';
    end
    [Comp.TATable.hEdit] = fun_myTable_noFirstRow(hSSPanel(3), RowRatio, ColRatio, txt, 12, bgc);

end
%         
% txt.FirstRow = {'X', 'Y', 'Z', 'dX', 'dY', 'dZ'};                            
% for m = 1:nT
%     txt.FirstColumn{m*2-1} = 'Target ';
%     txt.FirstColumn{m*2} = 'Abdomen ';
% end
% nR = length(txt.FirstColumn);
% nC = length(txt.FirstRow);
% for iR = 1:nR
%     for iC = 1:3
%         txt.DataStr{iR, iC} = '';
%     end
%     for iC = 4:nC
%         txt.DataStr{iR, iC} = '-';
%     end
% end
% RowRatio = ones(1, nR);
% ColRatio = ones(1, nC);
% [Comp.CBCTTable.hEdit] = fun_myTable(Comp.hPanel.CBCTTable, RowRatio, ColRatio, txt, 12, bgc);
% 
% for iR = 1:nR
%     for iC = 1:3
%         Comp.CBCTTable.hEdit(iR, iC).Tag = ['cbct_', num2str(iR), num2str(iC)];
%         Comp.CBCTTable.hEdit(iR, iC).Callback = @Callback_Ethos_CBCTTable_;
%     end
%     for iC = 4:nC
%         Comp.CBCTTable.hEdit(iR, iC).ForegroundColor = 'y';
%         Comp.CBCTTable.hEdit(iR, iC).Enable = 'inactive';
%     end
% end
% clear txt;
% 
% % I ID Table
% Comp.hPanel.CBCTID = uipanel('parent', Comp.hPanel.CBCT,...
%             'Unit', 'Normalized',...
%             'Position', [w_1+w_2 0 w_3 1], ...
%             'FontSize',                 12,...
%             'Units',                     'normalized', ...
%             'visible',                      'on', ...
%             'ForegroundColor',       'c',...
%             'BackgroundColor',       'k', ...
%             'HighlightColor',          'k',...
%             'ShadowColor',            'k', ...
%             'Tag', 'IDTablePanel');
% 
% txt.FirstRow = {'Vertical', 'dVert'};
% for m = 1:nT
%     txt.FirstColumn{m} = ['IDENTIFY', num2str(m)];
% end
% nR = length(txt.FirstColumn);
% nC = length(txt.FirstRow);
% for iR = 1:nR
%     txt.DataStr{iR, 1} = '';
%     txt.DataStr{iR, 2} = '-';
% end
% RowRatio = 2*ones(1, nR);
% ColRatio = ones(1, nC);
% [Comp.CBCTIDTable.hEdit] = fun_myTable(Comp.hPanel.CBCTID, RowRatio, ColRatio, txt, 12, bgc);
% for iR = 1:nR
%     for iC = 2:nC
%         Comp.CBCTIDTable.hEdit(iR, iC).ForegroundColor = 'y';
%         Comp.CBCTIDTable.hEdit(iR, iC).Enable = 'inactive';
%     end
% end