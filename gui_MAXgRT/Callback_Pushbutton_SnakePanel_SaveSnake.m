function Callback_Pushbutton_SnakePanel_SaveSnake(src, evnt)

global bLR

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
if strcmp(data.bMode, 'V')
    fun_Callback_Pushbutton_SnakePanel_SaveSnake(data, src, evnt);
else
    fun_Callback_Pushbutton_SnakePanel_SaveSnake_Cine(data, src, evnt);
end


    function     fun_Callback_Pushbutton_SnakePanel_SaveSnake(data, src, evnt);

    ffn_snakes = data.FileInfo.ffn_snakes;

    Snakes = data.Snake.Snakes;
    save(ffn_snakes, 'Snakes');

    % save snake as csv
    x0 = data.Image.x0;
    y0 = data.Image.y0;
    dx = data.Image.dx;
    dy = data.Image.dy;

    ffn_snakePoints = data.FileInfo.ffn_snakePoints;
    ffn_snakePointsMatrix = data.FileInfo.ffn_snakePointsMatrix;
    ffn_snakePointsMatrix2 = data.FileInfo.ffn_snakePointsMatrix2;

    % if ~exist(ffn_snakePoints, 'file')
        nSlice = length(Snakes);
        CP = [];  % Contour Points
        junk = find(data.Tumor.indC ~= 1);
        iSlice = junk(1);
        gC = Snakes{iSlice};
        if ~isempty(gC)
            gC(:, 1) = (gC(:, 1)-1)*dx+x0;
            gC(:, 2) = (gC(:, 2)-1)*dy+y0;
            nP = size(gC, 1);
            junk = [iSlice*ones(nP, 1) gC];
            CP = [CP; junk];
            xc = gC(:, 1);
        end

        for iSlice = 2:nSlice
            gC = Snakes{iSlice};
            if ~isempty(gC)
                gC(:, 1) = (gC(:, 1)-1)*dx+x0;
                gC(:, 2) = (gC(:, 2)-1)*dy+y0;
                nP = size(gC, 1);
                junk = [iSlice*ones(nP, 1) gC];
                CP = [CP; junk];

                xc = intersect(gC(:, 1), xc); % for matrix
            end
        end
        T = array2table(CP, 'VariableNames',{'Slice #', 'Xd', 'Yd'});
        writetable(T, ffn_snakePoints);

        % matrix
        CPM = [0 xc'];
        for iSlice = 1:nSlice
            gC = Snakes{iSlice};
            if ~isempty(gC)
                gC(:, 1) = (gC(:, 1)-1)*dx+x0;
                gC(:, 2) = (gC(:, 2)-1)*dy+y0;
                [~, ia, ib] = intersect(gC(:, 1), xc); % for matrix
                yc = gC(ia, 2)';
                CPM = [CPM; [iSlice yc]];
            end
        end
        TT = array2table(CPM);
        writetable(TT, ffn_snakePointsMatrix, 'WriteVariableNames', 0);

        % matrix2
        sSlices = CPM(2:end, 1);
        xt = data.Tumor.cent.x(sSlices);
        yt = data.Tumor.cent.y(sSlices);
        CPM2 = [sSlices xt yt];
        varNames = {'Slice#', 'xt', 'yt'};

        nSS = length(sSlices);
        for iX = 1:length(xc)
            xd = repmat(xc(iX), nSS, 1);
            CPM2 = [CPM2 xd CPM(2:end, iX+1)];

            xname = ['x', num2str(iX)];
            yname = ['y', num2str(iX)];

            varNames = [varNames, {xname, yname}];
        end
        TT2 = array2table(CPM2, 'VariableNames', varNames);
        writetable(TT2, ffn_snakePointsMatrix2);

    % end


    if data.Point.InitDone
        Point = data.Point.Data;
        ffn_PointOnSnake = data.FileInfo.ffn_PointOnSnake;
        save(ffn_PointOnSnake, 'Point');
        msg = ['Snakes have been saved in ', ffn_snakes, ' and Points have been saved in ', ffn_PointOnSnake]; 
    else
        msg = ['Snakes have been saved in ', ffn_snakes]; 
    end

    msg = {'Snake matrix data have been saved in:';  ffn_snakePointsMatrix2};
    hMB = msgbox('');
    pos = hMB.Position;
    w = pos(3);
    h = pos(4);
    hMB.Position = [pos(1)-w*2.5 pos(2)-h/2 w*6 h*2];
    hT = findall(hMB, 'Type', 'Text');
    hT.String = msg;
    hT.FontSize = 14;
    hPB = findall(hMB, 'Style', 'pushbutton');
    hPB.FontSize = 14;
    hPB.Visible = 'off';
    end

    function     fun_Callback_Pushbutton_SnakePanel_SaveSnake_Cine(data, src, evnt)
        TagNo = data.CineActiveTagNo;
        
        % mat
        if TagNo == 3
%             if strcmp(bLR, 'L')
            if data.cine(TagNo).SnakeL.SlitherDone
                Snakes = data.cine(TagNo).SnakeL.Snakes;
                ffn_mat = data.cine(TagNo).ffn_SnakeL_mat;
                ffn_csv = data.cine(TagNo).ffn_SnakeL_csv;
                save(ffn_mat, 'Snakes');
                fun_saveSnake_csv(data, TagNo, ffn_csv, Snakes);
            end
            if data.cine(TagNo).SnakeR.SlitherDone
                Snakes = data.cine(TagNo).SnakeR.Snakes;
                ffn_mat = data.cine(TagNo).ffn_SnakeR_mat;
                ffn_csv = data.cine(TagNo).ffn_SnakeR_csv;
                save(ffn_mat, 'Snakes');
                fun_saveSnake_csv(data, TagNo, ffn_csv, Snakes);
            end
        else
            Snakes = data.cine(TagNo).Snake.Snakes;
            ffn_mat = data.cine(TagNo).ffn_Snake_mat;
            ffn_csv = data.cine(TagNo).ffn_Snake_csv;
            save(ffn_mat, 'Snakes');
            fun_saveSnake_csv(data, TagNo, ffn_csv, Snakes);
        end
    end

    function fun_saveSnake_csv(data, TagNo, ffn_csv, Snakes)
        % csv
        
        x0 = data.cine(TagNo).x0;
        y0 = data.cine(TagNo).y0;
        dx = data.cine(TagNo).dx;
        dy = data.cine(TagNo).dy;
       
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
            gC =Snakes{iSlice};
            if ~isempty(gC)
                junk(1:2:length(gC)*2-1) = (gC(:, 2)'-1)*dx+x0;
                junk(2:2:length(gC)*2) = (gC(:, 1)-1)'*dy+y0;
                CPM2 = [CPM2; [iSlice junk]];
            end
        end
        TT2 = array2table(CPM2, 'VariableNames', varNames);

        writetable(TT2, ffn_csv);

        msg = {'Snake data have been saved in:'; ffn_csv};
        fun_messageBox(msg);
    end

end

