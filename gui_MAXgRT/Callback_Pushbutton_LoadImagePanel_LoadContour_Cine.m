function Callback_Pushbutton_LoadImagePanel_LoadContour_Cine(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

fileList = uigetfile(fullfile(data.FileInfo.CineDataPath, '*.txt'), 'MultiSelect', 'on');
% idx = find(contains(fileList,'sag.txt', 'IgnoreCase', true));

%% single sag txt

TagNo = 1;
ffn = fullfile(data.FileInfo.CineDataPath, fileList);

contData = fun_readContourTxt(ffn);

nSliceC = length(contData.data);

% test_1
hexCLR.Tumor =  '#FFFF0000';
hexCLR.Ab =  '#FFA52A2A';
hexCLR.Snake =   '#FF00FFFF';

% contours_TK
hexCLR.Tumor =  '#FF8A2BE2';
hexCLR.Ab =  '#FF00008B';
hexCLR.Snake =   '#FFE9967A';

%  test_2
hexCLR.Tumor =  '#FFFF0000';
hexCLR.Snake =  '#FF7FFF00';
hexCLR.Ab =   '#FF00FFFF';

x0 = data.cine(TagNo).x0;
y0 = data.cine(TagNo).y0;
dx = data.cine(TagNo).dx;
dy = data.cine(TagNo).dy;

for n = 1:nSliceC
    if ~isempty(contData.data(n).cont)
        for m = 1:length(contData.data(n).cont)
            CLR = contData.data(n).cont(m).CLR;
            if strcmp(CLR, hexCLR.Tumor)
                data.cine(TagNo).Tumor.CLR = CLR;
                junk = contData.data(n).cont(m).pt;
                junk = [junk; junk(1,:)]*contData.ratio;
                junk(:, 1) = (junk(:, 1)-1)*dx+x0;
                junk(:, 2) = (junk(:, 2)-1)*dy+y0;
                data.cine(TagNo).Tumor.Snakes{n} = junk;
            elseif strcmp(CLR, hexCLR.Ab)
                data.cine(TagNo).Ab.CLR = CLR;
                junk = contData.data(n).cont(m).pt*contData.ratio;
                junk(:, 1) = (junk(:, 1)-1)*dx+x0;
                junk(:, 2) = (junk(:, 2)-1)*dy+y0;
                data.cine(TagNo).Ab.Snakes{n} = junk;
            elseif strcmp(CLR, hexCLR.Snake)
                data.cine(TagNo).Snake.CLR = CLR;
                junk = contData.data(n).cont(m).pt*contData.ratio;
                junk(:, 1) = (junk(:, 1)-1)*dx+x0;
                junk(:, 2) = (junk(:, 2)-1)*dy+y0;
                data.cine(TagNo).Snake.Snakes{n} = junk;
            end
        end
    end
end

%% contours on slice 1
hPlotObj = data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj;

cineData = data.cine(TagNo);
bShow = [1 1 1];
showAllContours(hPlotObj, cineData, 1, bShow)

%% save .mat .csv
if TagNo ~=3
    Snakes =  data.cine(TagNo).Tumor.Snakes;
    dataFileName.mat = data.cine(TagNo).ffn_Tumor_mat;
    dataFileName.csv = data.cine(TagNo).ffn_Tumor_csv;
    saveContourMatCsv(Snakes, dataFileName);

    Snakes =  data.cine(TagNo).Snake.Snakes;
    dataFileName.mat = data.cine(TagNo).ffn_Snake_mat;
    dataFileName.csv = data.cine(TagNo).ffn_Snake_csv;
    saveContourMatCsv(Snakes, dataFileName);

    Snakes =  data.cine(TagNo).Ab.Snakes;
    dataFileName.mat = data.cine(TagNo).ffn_Body_mat;
    dataFileName.csv = data.cine(TagNo).ffn_Body_csv;
    saveContourMatCsv(Snakes, dataFileName);
end

%% OLView
    % tumor OL
    [CineTumorOL, CineTumorCent, CineTumorLim] = fun_getCineTumorOL(data.cine);
    for nn = 1:length(CineTumorOL)
        data.cine(nn).Tumor.OL = CineTumorOL{nn};
        data.cine(nn).Tumor.Cent = CineTumorCent{nn};
        data.cine(nn).Tumor.Lim = CineTumorLim{nn};
    end
    data.bCineTumorOLDone = 1;
    

for n = 1:1
    hA = data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hAxis.Image;
    
    % tumor
    I = zeros(data.cine(n).mImg, data.cine(n).mImg);
    red = cat(3, I, I, I);
    data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.TumorOLView =...
        imshow(red, data.cine(n).RA, 'parent', hA);
    set(data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.TumorOLView, 'AlphaData', I);
 
    % Tumor center
     data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.TumorCenter = ...
                line(hA, 'XData', [], 'YData', [], 'Color', 'm', 'LineWidth', 1,...
                'Marker', '+', 'MarkerSize', 100, 'Tag', 'TumorCenter', 'Visible', 'on');

    % diaphragm
    cont = data.cine(n).Snake.Snakes;
    [I,  data.cine(n).Snake.xyLim] = fun_getCineContourOL(cont, data.cine(n).mImg, data.cine(n).nImg, 'D', x0, y0, dx, dy);
    green = cat(3, zeros(size(I)), I, zeros(size(I))); 
    data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.DiaphragmOLView =...
        imshow(green, data.cine(n).RA, 'parent', hA);
    set(data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.DiaphragmOLView,...
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
    cont = data.cine(n).Ab.Snakes;
    [I, data.cine(n).Ab.xyLim] = fun_getCineContourOL(cont, data.cine(n).mImg, data.cine(n).nImg, 'A', x0, y0, dx, dy);
    blue = cat(3, zeros(size(I)), I, I); 
    data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.AbOLView =...
        imshow(blue, data.cine(n).RA, 'parent', hA);
    set(data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.AbOLView,...
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
    hA = data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hAxis.Image;
    data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.MarkLines = ...
        addMeasureMarks_Cine(hA, data.cine(n));
end


data.bCineTumorOLDone = false;

data.Panel.OLView_Cine.hPanel.Visible = 'on';
data.Panel.Measure_Cine.hPanel.Visible = 'on';

data.bCineContourLoaded = 1;

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