function Callback_Pushbutton_BodyPanel_SaveContour(src, evnt)

global hFig

data = guidata(hFig);
AbsContours = data.Body.AbsContours;

%% .mat
ffn_AbsContour = data.FileInfo.ffn_AbsContour;
save(ffn_AbsContour, 'AbsContours');

%% .csv
ffn_csv = data.FileInfo.ffn_csv_AbsContour;

x0 = data.Image.x0;
y0 = data.Image.y0;
dx = data.Image.dx;
dy = data.Image.dy;

nSlice = length(AbsContours);
nP = max(cellfun(@length, AbsContours));
CPM2 = [];  % Contour Points Matrix2

varNames = {'Slice#'};
for iX = 1:nP
    xname = ['x', num2str(iX)];
    yname = ['y', num2str(iX)];
    varNames = [varNames, {xname, yname}];
end

for iSlice = 1:nSlice
    junk = nan(1, nP*2);
    gC = AbsContours{iSlice};
    if ~isempty(gC)
        junk(1:2:length(gC)*2-1) = (gC(:, 2)'-1)*dx+x0;
        junk(2:2:length(gC)*2) = (gC(:, 1)-1)'*dy+y0;
        CPM2 = [CPM2; [iSlice junk]];
    end
end
TT2 = array2table(CPM2, 'VariableNames', varNames);
writetable(TT2, ffn_csv);

msg = {'Abdomen data have been saved in:'; ffn_csv};
fun_messageBox(msg);

% 
%     iSlice = 1;
%     gC = Snakes{iSlice};
%     if ~isempty(gC)
%         gC(:, 1) = (gC(:, 1)-1)*dx+x0;
%         gC(:, 2) = (gC(:, 2)-1)*dy+y0;
%         nP = size(gC, 1);
%         junk = [iSlice*ones(nP, 1) gC];
%         CP = [CP; junk];
%         xc = gC(:, 1);
%     end
% 
%     for iSlice = 2:nSlice
%         gC = Snakes{iSlice};
%         if ~isempty(gC)
%             gC(:, 1) = (gC(:, 1)-1)*dx+x0;
%             gC(:, 2) = (gC(:, 2)-1)*dy+y0;
%             nP = size(gC, 1);
%             junk = [iSlice*ones(nP, 1) gC];
%             CP = [CP; junk];
%             
%             xc = intersect(gC(:, 1), xc); % for matrix
%         end
%     end
%     T = array2table(CP, 'VariableNames',{'Slice #', 'Xd', 'Yd'});
%     writetable(T, ffn_snakePoints);
% 
%     % matrix
%     CPM = [0 xc'];
%     for iSlice = 1:nSlice
%         gC = Snakes{iSlice};
%         if ~isempty(gC)
%             gC(:, 1) = (gC(:, 1)-1)*dx+x0;
%             gC(:, 2) = (gC(:, 2)-1)*dy+y0;
%             [~, ia, ib] = intersect(gC(:, 1), xc); % for matrix
%             yc = gC(ia, 2)';
%             CPM = [CPM; [iSlice yc]];
%         end
%     end
%     TT = array2table(CPM);
%     writetable(TT, ffn_snakePointsMatrix, 'WriteVariableNames', 0);
%     
%     % matrix2
%     sSlices = CPM(2:end, 1);
%     xt = data.Tumor.cent.x(sSlices);
%     yt = data.Tumor.cent.y(sSlices);
%     CPM2 = [sSlices xt yt];
%     varNames = {'Slice#', 'xt', 'yt'};
%     
%     nSS = length(sSlices);
%     for iX = 1:length(xc)
%         xd = repmat(xc(iX), nSS, 1);
%         CPM2 = [CPM2 xd CPM(2:end, iX+1)];
%         
%         xname = ['x', num2str(iX)];
%         yname = ['y', num2str(iX)];
%         
%         varNames = [varNames, {xname, yname}];
%     end
%     TT2 = array2table(CPM2, 'VariableNames', varNames);
%     writetable(TT2, ffn_snakePointsMatrix2);
