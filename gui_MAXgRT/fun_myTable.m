function [hEdit] = fun_myTable(parent, RowRatio, columnRatio, txt, FS)

junk = 1+sum(columnRatio);
wCell = [1 columnRatio]/junk;
nC = length(columnRatio);

junk = 1+sum(RowRatio);
hCell = [1 RowRatio]/junk;
nR = length(RowRatio);

junk = cumsum(wCell);
xP = [0 junk(1:end-1)];
% yP = hCell*nR:-hCell:0;

% all cells
yP = 1;
for iR = 1:nR+1
    yP = yP-hCell(iR);
    for iC = 1:nC+1
        hET(iR, iC) = uipanel('parent', parent,...
                                'Unit', 'Normalized',...
                                'Position', [xP(iC) yP wCell(iC) hCell(iR)],...
                                'Units',                     'normalized', ...
                                'visible',                      'on', ...
                                'ForegroundColor',       'k',...
                                'BackgroundColor',       'k', ...
                                'HighlightColor',          'w',...
                                'ShadowColor',            'k');
    end
end

% first row
for iC = 1:nC
    hText.FirstRow(iC) = uicontrol('parent', hET(1, iC+1), ...
                                'Style', 'text',...
                                'String', txt.FirstRow{iC},...
                                'Unit', 'Normalized',...
                                'Position', [0 0 1 1], ...
                                'FontSize', FS, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', 'k',...
                                'ForegroundColor', 'w',...
                                'Visible', 'on');
end

% first column
for iR = 1:nR
    hText.FirsColumn(iR) = uicontrol('parent', hET(iR+1, 1), ...
                                'Style', 'text',...
                                'String', txt.FirstColumn{iR},...
                                'Unit', 'Normalized',...
                                'Position', [0 0 1 1], ...
                                'FontSize', FS, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', 'k',...
                                'ForegroundColor', 'w',...
                                'Visible', 'on');
end

% data
for iC = 1:nC
    for iR = 1:nR
        hEdit(iR, iC) = uicontrol('parent', hET(iR+1, iC+1), ...
                                'Style', 'edit',...
                                'Unit', 'Normalized',...
                                'Position', [0 0 1 1],...
                                'FontSize', FS, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', 'k',...
                                'ForegroundColor', 'g',...
                                'String', txt.DataStr{iR, iC}, ...
                                'Visible', 'on');

    end
end