function fun_SlitherCallback_Cine(src, evnt)

bPlot = 0;

global stopSlither 
global bLR

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

startSlice = str2double(data.Panel.Snake.Comp.Edit.StartSlice.String);
endSlice = str2double(data.Panel.Snake.Comp.Edit.EndSlice.String);

bV = src.Value;

if bV
    src.String = 'Stop';
    src.ForegroundColor = 'r';
    src.BackgroundColor = [1 1 1]*0.25;

    TagNo = data.CineActiveTagNo;
    x0 = data.cine(TagNo).x0;
    y0 = data.cine(TagNo).y0;
    dx = data.cine(TagNo).dx;
    dy = data.cine(TagNo).dy;

    sV = data.cine(TagNo).iSlice;
    J = data.cine(TagNo).v(:,:,sV);

    L = data.Snake.FreeHand.L;
    if TagNo == 3
        if mean(L.Position(:,1)) < size(J, 2)/2
            bLR = 'L';
        else
            bLR = 'R';
        end
    end
    
    [mJ, nJ] = size(J);
    cAF = L.Position;

    % convert to ij
    cAF(:, 1) = (cAF(:, 1)-x0)/dx+1;
    cAF(:, 2) = (cAF(:, 2)-y0)/dy+1;

    nSlices = data.cine(TagNo).nSlice;

    L.Visible = 'off';

    xMarg = 0;
    yMarg = 10;
    
    %% rect
    xmin = round(min(cAF(:, 1)));
    xmax = round(max(cAF(:, 1)));
    ymin = round(min(cAF(:, 2)));
    ymax = round(max(cAF(:, 2)));

    y1 = ymin-yMarg;
    y2 = ymax+yMarg;
    x1 = xmin-xMarg;
    x2 = xmax+xMarg;

    T = J(y1:y2, x1:x2);

%% template match
% hPlotObj = data.Panel.View.Comp.hPlotObj;
hPlotObj = data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj;
% tumor/diaphram vertical center
% mTC = round((mean(data.Tumor.cent.y, 'omitnan')-y0)/dy)+1;
% 
% J = II{iSlice};
%         if mTC < mDP
%             mCut = mTC-mBuffer;
%             J2 = J(mCut:end, :);
%         else
%             mCut = mTC+mBuffer;
%             J2 = J(1:mCut, :);
%         end

% mBuffer = round(mJ/10);
% mDP = mean(cAF(:, 2));
% if mDP < mJ/2
%     m1 = 1;
%     m2 = max(cAF(:,2))+round((mJ-max(cAF(:,2)))/2);
% else
%     m1 = round(min(cAF(:,2))/2);
%     m2 = mJ;
% end    

CLR = 'rgb';
% Tumor = data.Tumor;
% mMid = round(mJ/2);
for iSlice = startSlice:endSlice
    
    if stopSlither
        break;
    end
    
%     if data.Tumor.indC(iSlice) > 1 % gating or tracking contour on image
    
        J = data.cine(TagNo).v(:,:,iSlice);
%         J2 = J(m1:m2, :);
        
        %%%% template match
        nXC = normxcorr2(T, J);
        [ypeak, xpeak] = find(nXC==max(nXC(:)));
        yoffSet = ypeak-size(T,1);
%         if mDP > mJ/2
%             yoffSet = yoffSet+m1;
%          end
        xoffSet = xpeak-size(T,2);

        C(:, 1) = cAF(:, 1)+xoffSet-x1+1;
        C(:, 2) = cAF(:, 2)+yoffSet-y1+1;

%         % snake on cropped
%         if mDP < mJ/2
%             Rect = [xoffSet+1, yoffSet+1, size(T,2), nJ-yoffSet];
%         else
            Rect = [xoffSet+1, yoffSet+1, size(T,2), size(T,1)];
%         end
        
        %%%% snake
        [sC] = fun_findDiaphragm_Cine(J, Rect, C);
        % smooth
        % sC(:, 1) = sgolayfilt(sC(:, 1), 3, 75);
        framelen = round(size(sC, 1)/4);
        if mod(framelen, 2) == 0
            framelen = framelen+1;
        end
        framelen = min(framelen, 25);
        sC(:, 2) = sgolayfilt(sC(:, 2), 3, framelen);

        if bPlot
            figure(101), clf
            imshow(J, []); 
            axis on;
            hold on
            line(cAF(:, 1), cAF(:, 2), 'Color', 'g', 'LineWidth', 2)
            line(C(:, 1), C(:, 2), 'Color', 'r')
            rectangle('Position', Rect, 'EdgeColor', 'c');

            line(sC(:, 1), sC(:, 2), 'Color', 'm')

%             figure(102), clf
%             imshow(J2, []); 
%             axis on;
%             hold on
    % %         line(C(:, 1), C(:, 2), 'Color', 'g')
        end
    
%     else
%         sC = [];
%     end    

%     data.Snake.Snakes{iSlice} = sC;

%     % tumor snake
%     set(data.Panel.View.Comp.hPlotObj.RGBContour, 'XData', Tumor.eContXY{iSlice}(:, 1),...
%         'YData', Tumor.eContXY{iSlice}(:, 2), 'Color', CLR(Tumor.indC(iSlice)));
%     set(data.Panel.View.Comp.hPlotObj.RGBContourCenter, 'XData', mean(Tumor.eContXY{iSlice}(:, 1)),...
%         'YData', mean(Tumor.eContXY{iSlice}(:, 2)), 'Color', CLR(Tumor.indC(iSlice)));
% 
%     if Tumor.indC(iSlice) == 1
%         set(data.Panel.View.Comp.hPlotObj.SnakeContour, 'XData', [], 'YData', []);
%         set(data.Panel.View.Comp.hPlotObj.SnakeContourCenter, 'XData', [], 'YData', []);
%     else
%         set(data.Panel.View.Comp.hPlotObj.SnakeContour, 'XData', Tumor.snakeContXY{iSlice}(:, 1),...
%             'YData', Tumor.snakeContXY{iSlice}(:, 2));
%         set(data.Panel.View.Comp.hPlotObj.SnakeContourCenter, 'XData', mean(Tumor.snakeContXY{iSlice}(:, 1)),...
%             'YData', mean(Tumor.snakeContXY{iSlice}(:, 2)));
%     end

    
    % snake on image
    hPlotObj.Image.CData = J;
    if isempty(sC)
        hPlotObj.Snake.YData = [];
        hPlotObj.Snake.XData = [];
    else
        hPlotObj.Snake.YData = (sC(:, 2)-1)*dy+y0;
        hPlotObj.Snake.XData = (sC(:, 1)-1)*dx+x0;
    end
    
    if TagNo == 3
        sC2 = [];
        if strcmp(bLR, 'L')
            data.cine(TagNo).SnakeL.Snakes{iSlice} = sC;
            if data.cine(TagNo).SnakeR.SlitherDone
                sC2 = data.cine(TagNo).SnakeR.Snakes{iSlice};
            end
        else
            data.cine(TagNo).SnakeR.Snakes{iSlice} = sC;
            if data.cine(TagNo).SnakeL.SlitherDone
                sC2 = data.cine(TagNo).SnakeL.Snakes{iSlice};
            end
        end
        if isempty(sC2)
            hPlotObj.Snake2.YData = [];
            hPlotObj.Snake2.XData = [];
        else
            hPlotObj.Snake2.YData = (sC2(:, 2)-1)*dy+y0;
            hPlotObj.Snake2.XData = (sC2(:, 1)-1)*dx+x0;
        end
    else
        data.cine(TagNo).Snake.Snakes{iSlice} = sC;
    end

    % update slider
    data.Panel.View_Cine.subPanel(TagNo).ssPanel(4).Comp.hSlider.Slice.Value = iSlice;
    data.Panel.View_Cine.subPanel(TagNo).ssPanel(4).Comp.hText.nImages.String...
        = [num2str(iSlice), ' / ', num2str(data.cine(TagNo).nSlice)];

%     % points
%     if data.Point.InitDone && ~isempty(sC)
%         xi = data.Point.Data.xi;
%         ixm = data.Point.Data.ixm;
%         NP = data.Point.Data.NP;
%         yi = data.Point.Data.yi;
% 
%         [~, yi(iSlice, :)] = fun_PointOnCurve(sC, dx, dy, x0, y0, xi, yi(iSlice, :));
%         data.Point.Data.yi = yi;
% 
%         hPlotObj = data.Panel.View.Comp.hPlotObj;
%         hPlotObj.Point.XData = xi(ixm);
%         hPlotObj.Point.YData = yi(iSlice, ixm);
%         hPlotObj.LeftPoints.XData = xi(ixm-NP:ixm-1);
%         hPlotObj.LeftPoints.YData = yi(iSlice, ixm-NP:ixm-1);
%         hPlotObj.RightPoints.XData = xi(ixm+1:ixm+NP);
%         hPlotObj.RightPoints.YData = yi(iSlice, ixm+1:ixm+NP);
%     
%         guidata(hFig, data)
%         updatePlotPoint;
%     end
    
    drawnow;
    clear sC;

end

    if stopSlither
        src.String = 'Slither';
        src.ForegroundColor = 'g';
        stopSlither = false;
        src.Value = 0;
        
        hPlotObj.Snake.XData = [];
        hPlotObj.Snake.YData = [];
        
    else
        
        % slther done
        if TagNo == 3
            if strcmp(bLR, 'L')
                data.cine(TagNo).SnakeL.SlitherDone = true;
            else
                data.cine(TagNo).SnakeR.SlitherDone = true;
            end
        else
            data.cine(TagNo).Snake.SlitherDone = true;
        end

        % enable buttons
        data.Panel.Snake.Comp.Togglebutton.ReDraw.Enable = 'on';
        data.Panel.Snake.Comp.Pushbutton.Delete.Enable = 'on';
        data.Panel.Snake.Comp.Pushbutton.SaveSnake.Enable = 'on';

        data.Panel.Point.Comp.Popup.Neighbour.Enable = 'on';
        data.Panel.Point.Comp.Pushbutton.Init.Enable = 'on';

        data.Panel.Point.Comp.Radiobutton.Tumor.Enable = 'on';
        data.Panel.Point.Comp.Radiobutton.Dome.Enable = 'on';
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % slice 1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    iSlice = startSlice;
    hPlotObj.Image.CData = data.cine(TagNo).v(:,:,iSlice);
    if TagNo == 3
        sC2 = [];
        if strcmp(bLR, 'L')
            sC = data.cine(TagNo).SnakeL.Snakes{iSlice};
            if data.cine(TagNo).SnakeR.SlitherDone
                % snake on image
                sC2 = data.cine(TagNo).SnakeR.Snakes{iSlice};
            end
        else
            sC = data.cine(TagNo).SnakeR.Snakes{iSlice};
            if data.cine(TagNo).SnakeL.SlitherDone
                sC2 = data.cine(TagNo).SnakeL.Snakes{iSlice};
            end
        end
        if isempty(sC2)
            hPlotObj.Snake2.YData = [];
            hPlotObj.Snake2.XData = [];
        else
            hPlotObj.Snake2.YData = (sC2(:, 2)-1)*dy+y0;
            hPlotObj.Snake2.XData = (sC2(:, 1)-1)*dx+x0;
        end
    else
        sC = data.cine(TagNo).Snake.Snakes{iSlice};
    end

    if isempty(sC)
        hPlotObj.Snake.YData = [];
        hPlotObj.Snake.XData = [];
    else
        hPlotObj.Snake.YData = (sC(:, 2)-1)*dy+y0;
        hPlotObj.Snake.XData = (sC(:, 1)-1)*dx+x0;
    end
    % update slider
    data.Panel.View_Cine.subPanel(TagNo).ssPanel(4).Comp.hSlider.Slice.Value = iSlice;
    data.Panel.View_Cine.subPanel(TagNo).ssPanel(4).Comp.hText.nImages.String...
        = [num2str(iSlice), ' / ', num2str(data.cine(TagNo).nSlice)];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    guidata(hFig, data);

    src.String = 'Slither';
    src.ForegroundColor = 'g';
    src.Value = 0;
else
    stopSlither = true;
end