function Callback_Cine_Pushbutton_LoadImagePanel_LoadContour(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

fileList = uigetfile(fullfile(data.FileInfo.CineDataPath, '*.txt'), 'MultiSelect', 'on');
% idx = find(contains(fileList,'sag.txt', 'IgnoreCase', true));

%% single sag txt
TagNo = 1;
ffn = fullfile(data.FileInfo.CineDataPath, fileList);
[contData, NameColor] = fun_readContourTxt_withName(ffn);
nSliceC = length(contData.data);

% contour NameColor
[CLR, ia, ~] = unique(NameColor(:,1)); 
Name = NameColor(ia, 2);
for n = 1:length(Name)
    if strcmpi(Name{n}(1), 't')        
        hexCLR.Tumor =  CLR{n};
    elseif strcmpi(Name{n}(1), 'a')        
        hexCLR.Ab =  CLR{n};
    elseif strcmpi(Name{n}(1), 'd')        
        hexCLR.Snake =  CLR{n};
    end
end

% % test_1
% hexCLR.Tumor =  '#FFFF0000';
% hexCLR.Ab =  '#FFA52A2A';
% hexCLR.Snake =   '#FF00FFFF';
% 
% % contours_TK
% hexCLR.Tumor =  '#FF8A2BE2';
% hexCLR.Ab =  '#FF00008B';
% hexCLR.Snake =   '#FFE9967A';
% 
% %  test_2
% hexCLR.Tumor =  '#FFFF0000';
% hexCLR.Snake =  '#FF7FFF00';
% hexCLR.Ab =   '#FF00FFFF';
% 

x0 = data.cine.data(TagNo).x0;
y0 = data.cine.data(TagNo).y0;
dx = data.cine.data(TagNo).dx;
dy = data.cine.data(TagNo).dy;

for n = 1:nSliceC
    if ~isempty(contData.data(n).cont)
        for m = 1:length(contData.data(n).cont)
            CLR = contData.data(n).cont(m).CLR;
            if strcmp(CLR, hexCLR.Tumor)
                data.cine.data(TagNo).Tumor.CLR = CLR;
                junk = contData.data(n).cont(m).pt;
                junk = [junk; junk(1,:)]*contData.ratio;
                junk(:, 1) = (junk(:, 1)-1)*dx+x0;
                junk(:, 2) = (junk(:, 2)-1)*dy+y0;
                data.cine.data(TagNo).Tumor.Snakes{n} = junk;
            elseif strcmp(CLR, hexCLR.Ab)
                data.cine.data(TagNo).Ab.CLR = CLR;
                junk = contData.data(n).cont(m).pt*contData.ratio;
                junk(:, 1) = (junk(:, 1)-1)*dx+x0;
                junk(:, 2) = (junk(:, 2)-1)*dy+y0;
                data.cine.data(TagNo).Ab.Snakes{n} = junk;
            elseif strcmp(CLR, hexCLR.Snake)
                data.cine.data(TagNo).Snake.CLR = CLR;
                junk = contData.data(n).cont(m).pt*contData.ratio;
                junk(:, 1) = (junk(:, 1)-1)*dx+x0;
                junk(:, 2) = (junk(:, 2)-1)*dy+y0;
                data.cine.data(TagNo).Snake.Snakes{n} = junk;
            end
        end
    end
end

%% contours on slice 1
hPlotObj = data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj;

cineData = data.cine.data(TagNo);
bShow = [1 1 1];
showAllContours(hPlotObj, cineData, 1, bShow)

%% save .mat .csv
if TagNo ~=3
    Snakes =  data.cine.data(TagNo).Tumor.Snakes;
    dataFileName.mat = data.cine.data(TagNo).ffn_Tumor_mat;
    dataFileName.csv = data.cine.data(TagNo).ffn_Tumor_csv;
    saveContourMatCsv(Snakes, dataFileName);

    Snakes =  data.cine.data(TagNo).Snake.Snakes;
    dataFileName.mat = data.cine.data(TagNo).ffn_Snake_mat;
    dataFileName.csv = data.cine.data(TagNo).ffn_Snake_csv;
    saveContourMatCsv(Snakes, dataFileName);

    Snakes =  data.cine.data(TagNo).Ab.Snakes;
    dataFileName.mat = data.cine.data(TagNo).ffn_Body_mat;
    dataFileName.csv = data.cine.data(TagNo).ffn_Body_csv;
    saveContourMatCsv(Snakes, dataFileName);
end

%% OLView
    % tumor OL
    [CineTumorOL, CineTumorCent, CineTumorLim] = fun_getCineTumorOL(data.cine.data(TagNo));
    for nn = 1:length(CineTumorOL)
        data.cine.data(nn).Tumor.OL = CineTumorOL{nn};
        data.cine.data(nn).Tumor.Cent = CineTumorCent{nn};
        data.cine.data(nn).Tumor.Lim = CineTumorLim{nn};
    end
    data.cine.bTumorOLDone = 1;
    

for n = 1:1
    hA = data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hAxis.Image;
    
    % tumor
    I = zeros(data.cine.data(n).mImg, data.cine.data(n).mImg);
    red = cat(3, I, I, I);
    data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj.TumorOLView =...
        imshow(red, data.cine.data(n).RA, 'parent', hA);
    set(data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj.TumorOLView, 'AlphaData', I);
 
    % Tumor center
     data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj.TumorCenter = ...
                line(hA, 'XData', [], 'YData', [], 'Color', 'm', 'LineWidth', 1,...
                'Marker', '+', 'MarkerSize', 100, 'Tag', 'TumorCenter', 'Visible', 'on');

    % diaphragm
    cont = data.cine.data(n).Snake.Snakes;
    [I,  data.cine.data(n).Snake.xyLim] = fun_getCineContourOL(cont, data.cine.data(n).mImg, data.cine.data(n).nImg, 'D', x0, y0, dx, dy);
    green = cat(3, zeros(size(I)), I, zeros(size(I))); 
    data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj.DiaphragmOLView =...
        imshow(green, data.cine.data(n).RA, 'parent', hA);
    set(data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj.DiaphragmOLView,...
        'AlphaData', rescale(I), 'Visible', 'off');
    
%     data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.hgSnake = hggroup(hA);
%     for iSlice = 1:length(data.cine(n).Snake.Snakes)
%         pt = data.cine(n).Snake.Snakes{iSlice};
%         if ~isempty(pt)
%             line('XData', pt(:, 1), 'YData', pt(:, 2), 'Color', 'w', 'Parent',...
%             data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.hgSnake);
%         end
%     end
%     data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.hgSnake.Visible = 'off';
    
    % ab
    cont = data.cine.data(n).Ab.Snakes;
    [I, data.cine.data(n).Ab.xyLim] = fun_getCineContourOL(cont, data.cine.data(n).mImg, data.cine.data(n).nImg, 'A', x0, y0, dx, dy);
    blue = cat(3, zeros(size(I)), I, I); 
    data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj.AbOLView =...
        imshow(blue, data.cine.data(n).RA, 'parent', hA);
    set(data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj.AbOLView,...
        'AlphaData', rescale(I), 'Visible', 'off');
    
    
%     data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.hgAb = hggroup(hA);
%     for iSlice = 1:length(data.cine(n).Ab.Snakes)
%         pt = data.cine(n).Ab.Snakes{iSlice};
%         if ~isempty(pt)
%             line('XData', pt(:, 1), 'YData', pt(:, 2), 'Color', 'w', 'Parent',...
%             data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.hgAb);
%         end
%     end
%     data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.hgAb.Visible = 'off';
    
    %% Measure marks
%     hA = data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hAxis.Image;
    data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj.MarkLines =...
        addMeasureMarks_Cine(hA, data.cine.data(n));

    %% MCI crosshair
    for iM = 1:3
        data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj.MRICH(iM) =...
                    line(hA, 'XData', [], 'YData', [], 'Color', 'g', 'LineWidth', 2,...
                    'Marker', '+', 'MarkerSize', 25, 'Tag', ['mr', num2str(iM)], 'Visible', 'on');
    end
end

data.cine.bTumorOLDone = false;

if data.cine.ActiveTagNo > 0
    data.cine.Panel.OLView.hPanel.Visible = 'on';
    data.cine.Panel.Measure.hPanel.Visible = 'on';
end

data.cine.bContourLoaded = 1;

guidata(hFig, data);

end


%% save as .mat and .csv
function saveContourMatCsv(Snakes, ffn)

% .mat
save(ffn.mat, 'Snakes');

% .csv
nSlice = length(Snakes);
nP = max(cellfun(@length, Snakes));
CPM2 = [];  % Contour Points Matrix2

varNames = {'Slice#'};
for iX = 1:nP
    xname = ['x', num2str(iX)];
    yname = ['y', num2str(iX)];
    varNames = [varNames, {xname, yname}];
end

for iSlice = 1:nSlice
    junk = nan(1, nP*2);
    gC = Snakes{iSlice};
    if ~isempty(gC)
        junk(1:2:length(gC)*2-1) = gC(:, 1);
        junk(2:2:length(gC)*2) = gC(:, 2);
        CPM2 = [CPM2; [iSlice junk]];
    end
end
TT2 = array2table(CPM2, 'VariableNames', varNames);
writetable(TT2, ffn.csv);

msg = {'Contour data have been saved in:'; ffn.csv};
fun_messageBox(msg);

end