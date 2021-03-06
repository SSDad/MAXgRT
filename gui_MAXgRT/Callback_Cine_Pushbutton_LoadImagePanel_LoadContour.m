function Callback_Cine_Pushbutton_LoadImagePanel_LoadContour(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

fileList = uigetfile(fullfile(data.FileInfo.CineDataPath, '*.txt'), 'MultiSelect', 'on');
ind{1} = find(contains(fileList,'sag', 'IgnoreCase', true) & ~contains(fileList,'cor', 'IgnoreCase', true));
ind{2} = find(contains(fileList,'cor', 'IgnoreCase', true) & ~contains(fileList,'sag', 'IgnoreCase', true));
ind{3} = find(contains(fileList,'cor', 'IgnoreCase', true) & contains(fileList,'sag', 'IgnoreCase', true));

for  iV = 1:4
    data.cine.data(iV).bContourJustLoaded = 0;
end

for TagNo = 1:3
    if ~isempty(ind{TagNo}) % contour file exists
        if iscell(fileList)
            ffn = fullfile(data.FileInfo.CineDataPath, fileList{ind{TagNo}});
        else
            ffn = fullfile(data.FileInfo.CineDataPath, fileList);
        end           
        [contData3{TagNo}, NameColor] = fun_readContourTxt_withName(ffn);

        nSliceC = length(contData3{TagNo}.data);

        % contour NameColor
        [CLR, ia, ~] = unique(NameColor(:,1)); 
        Name = NameColor(ia, 2);
        for n = 1:length(Name)
            if strcmpi(Name{n}(1), 't')        
                contCLR(TagNo).Tumor =  CLR{n};
            elseif strcmpi(Name{n}(1), 'a')        
                contCLR(TagNo).Ab =  CLR{n};
            elseif strcmpi(Name{n}(1), 'd')        
                contCLR(TagNo).Snake =  CLR{n};
            end
        end
        % %  test_2
        % hexCLR.Tumor =  '#FFFF0000';
        % hexCLR.Snake =  '#FF7FFF00';
        % hexCLR.Ab =   '#FF00FFFF';
        
        data.cine.data(TagNo).bContourLoaded = 1;
        data.cine.data(TagNo).bContourJustLoaded = 1;
        if TagNo == 3
            data.cine.data(4).bContourLoaded = 1;
            data.cine.data(4).bContourJustLoaded = 1;
        end
    end
end

for TagNo = 1:4
    contData = [];
    if TagNo < 3
        if data.cine.data(TagNo).bContourJustLoaded
            contData = contData3{TagNo};
            hexCLR = contCLR(TagNo);
        end
    else
        if data.cine.data(TagNo).bContourJustLoaded
            nData = length(contData3{3}.data)/2;
            contData.ratio = contData3{3}.ratio;
            hexCLR = contCLR(3);
            if TagNo == 3
                contData.data = contData3{3}.data(1:nData);
            else
                contData.data = contData3{3}.data(nData+1:end);
            end
        end
    end
    
    if ~isempty(contData)
        x0 = data.cine.data(TagNo).x0;
        y0 = data.cine.data(TagNo).y0;
        dx = data.cine.data(TagNo).dx;
        dy = data.cine.data(TagNo).dy;

        for n = 1: length(contData.data)
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
                    elseif strcmp(CLR, hexCLR.Snake)
                        data.cine.data(TagNo).Snake.CLR = CLR;
                        junk = contData.data(n).cont(m).pt*contData.ratio;
                        junk(:, 1) = (junk(:, 1)-1)*dx+x0;
                        junk(:, 2) = (junk(:, 2)-1)*dy+y0;
                        data.cine.data(TagNo).Snake.Snakes{n} = junk;
                    elseif isfield(hexCLR, 'Ab')
                        if strcmp(CLR, hexCLR.Ab)
                            data.cine.data(TagNo).Ab.CLR = CLR;
                            junk = contData.data(n).cont(m).pt*contData.ratio;
                            junk(:, 1) = (junk(:, 1)-1)*dx+x0;
                            junk(:, 2) = (junk(:, 2)-1)*dy+y0;
                            data.cine.data(TagNo).Ab.Snakes{n} = junk;
                        end
                    end
                end
            end
        end

        %% save .mat .csv
        Snakes =  data.cine.data(TagNo).Tumor.Snakes;
        dataFileName.mat = data.cine.data(TagNo).ffn_Tumor_mat;
        dataFileName.csv = data.cine.data(TagNo).ffn_Tumor_csv;
        saveContourMatCsv(Snakes, dataFileName);

        Snakes =  data.cine.data(TagNo).Snake.Snakes;
        dataFileName.mat = data.cine.data(TagNo).ffn_Snake_mat;
        dataFileName.csv = data.cine.data(TagNo).ffn_Snake_csv;
        saveContourMatCsv(Snakes, dataFileName);

        if TagNo == 1 | TagNo == 3
            Snakes =  data.cine.data(TagNo).Ab.Snakes;
            dataFileName.mat = data.cine.data(TagNo).ffn_Body_mat;
            dataFileName.csv = data.cine.data(TagNo).ffn_Body_csv;
            saveContourMatCsv(Snakes, dataFileName);
        end
        
        if TagNo == 1 
            msg = {'Sagittal contour data have been saved.'};
        elseif TagNo == 2
            msg = {'Coronal contour data have been saved.'};
        elseif TagNo == 3
            msg = {'Sagittal contour in Sag+Cor data have been saved.'};
        elseif TagNo == 4
            msg = {'Coronal contour in Sag+Cor data have been saved.'};
        end
        fun_messageBox(msg);
        
        %% OLView
        % tumor
        [data.cine.data(TagNo).Tumor.OL, data.cine.data(TagNo).Tumor.OLSum,...
            data.cine.data(TagNo).Tumor.Cent, data.cine.data(TagNo).Tumor.Lim] =...
            fun_getCineTumorOL(data.cine.data(TagNo));
        data.cine.data(TagNo).bTumorOLDone = 1;

        hA = data.cine.hAxis(TagNo);
        I = zeros(data.cine.data(TagNo).mImg, data.cine.data(TagNo).nImg);
        red = cat(3, I, I, I);
        data.cine.hPlotObj(TagNo).TumorOLView = imshow(red, data.cine.data(TagNo).RA, 'parent', hA);
        set(data.cine.hPlotObj(TagNo).TumorOLView, 'AlphaData', I);
        
        % Tumor center
         data.cine.hPlotObj(TagNo).TumorCenter = ...
                    line(hA, 'XData', [], 'YData', [], 'Color', 'm', 'LineWidth', 1,...
                    'Marker', '+', 'MarkerSize', 100, 'Tag', 'TumorCenter', 'Visible', 'on');

        % diaphragm
        cont = data.cine.data(TagNo).Snake.Snakes;
        [I,  data.cine.data(TagNo).Snake.xyLim] = fun_getCineContourOL(cont, data.cine.data(TagNo).mImg, data.cine.data(TagNo).nImg, 'D', x0, y0, dx, dy);
        green = cat(3, zeros(size(I)), I, zeros(size(I))); 
        data.cine.hPlotObj(TagNo).DiaphragmOLView =...
            imshow(green, data.cine.data(TagNo).RA, 'parent', hA);
        set(data.cine.hPlotObj(TagNo).DiaphragmOLView, 'AlphaData', rescale(I), 'Visible', 'off');
    
        % ab
        if TagNo == 1 | TagNo == 3
            cont = data.cine.data(TagNo).Ab.Snakes;
            [I, data.cine.data(TagNo).Ab.xyLim] = fun_getCineContourOL(cont, data.cine.data(TagNo).mImg, data.cine.data(TagNo).nImg, 'A', x0, y0, dx, dy);
            blue = cat(3, zeros(size(I)), zeros(size(I)), I); 
            data.cine.hPlotObj(TagNo).AbOLView =...
                imshow(blue, data.cine.data(TagNo).RA, 'parent', hA);
            set(data.cine.hPlotObj(TagNo).AbOLView,...
                'AlphaData', rescale(I), 'Visible', 'off');
        end
        
        %% contours on slice 1
        cineData = data.cine.data(TagNo);
        bShow = [1 1 1];
        if TagNo == 2 | TagNo == 4
            bShow = [1 1 0];
        end
        showAllContours(data.cine.hPlotObj(TagNo), cineData, 1, bShow)
        
        %% Measure marks
        data.cine.hPlotObj(TagNo).MarkLines =...
            addMeasureMarks_Cine(hA, data.cine.data(TagNo), TagNo);

        %% MCI crosshair
        for iM = 1:3
            data.cine.hPlotObj(TagNo).MRICH(iM) =...
                        line(hA, 'XData', [], 'YData', [], 'Color', 'g', 'LineWidth', 2,...
                        'Marker', '+', 'MarkerSize', 25, 'Tag', ['mr', num2str(iM)], 'Visible', 'on');
        end
        
        axis(hA, 'xy')

        % initialize measure fig
        guidata(hFig, data);
        createFig_Cine_Measure(TagNo);
        data = guidata(hFig);
    end %isempty(cineData)
end % TagNo

if data.cine.ActiveTagNo > 0
    data.cine.Panel.OLView.hPanel.Visible = 'on';
    data.cine.Panel.Measure.hPanel.Visible = 'on';
end

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
end