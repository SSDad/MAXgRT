function Callback_Togglebutton_SnakePanel_ReDraw(src, evnt)

global reContL reContL2

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

if strcmp(data.bMode, 'V')
    fun_Callback_Togglebutton_SnakePanel_ReDraw(data, src, evnt);
else
    fun_Callback_Togglebutton_SnakePanel_ReDraw_Cine(data, src, evnt);
end

    function fun_Callback_Togglebutton_SnakePanel_ReDraw(data, src, evnt);

        str = src.String;
    iSlice = round(data.Panel.SliceSlider.Comp.hSlider.Slice.Value);
    x0 = data.Image.x0;
    y0 = data.Image.y0;
    dx = data.Image.dx;
    dy = data.Image.dy;

    if strcmp(str, 'reDraw')
        src.String = 'Done';
        src.ForegroundColor = 'r';
        src.BackgroundColor = [1 1 1]*0.25;

        % turn off points
        hPlotObj = data.Panel.View.Comp.hPlotObj;
        hPlotObj.Point.XData = [];
        hPlotObj.Point.YData = [];
        hPlotObj.LeftPoints.XData = [];
        hPlotObj.LeftPoints.YData = [];
        hPlotObj.RightPoints.XData = [];
        hPlotObj.RightPoints.YData = [];

        C = data.Snake.Snakes{iSlice};
        hA = data.Panel.View.Comp.hAxis.Image;

        if isempty(C)
            axis(hA);
            L = images.roi.AssistedFreehand(hA,...
                'Image', data.Panel.View.Comp.hPlotObj.Image, ...
                'Closed', 0);
            draw(L);
            reContL = L;
        else
            % convert to xy
            C(:, 1) = (C(:, 1)-1)*dx+x0;
            C(:, 2) = (C(:, 2)-1)*dy+y0;

            nWP = size(C, 1);
            WP = false(nWP, 1);
            WP(round(linspace(1, nWP-nWP/14, 14))) = true;

            reContL = drawfreehand(hA,...
                'Position', C, 'Closed', 0);%, 'Waypoints', WP);

            data.Panel.View.Comp.hPlotObj.Snake.YData = [];
            data.Panel.View.Comp.hPlotObj.Snake.XData = [];
        end
            % disable buttons
            data.Panel.Snake.Comp.Pushbutton.LoadSnake.Enable = 'off';
            data.Panel.Snake.Comp.Pushbutton.FreeHand.Enable = 'off';
            data.Panel.Snake.Comp.Pushbutton.Delete.Enable = 'off';
            data.Panel.Snake.Comp.Pushbutton.SaveSnake.Enable = 'off';
            data.Panel.Snake.Comp.Togglebutton.Slither.Enable = 'off';

    else % Done
        src.String = 'reDraw';
        src.ForegroundColor = 'g';
        src.BackgroundColor = [1 1 1]*0.25;

        data.Snake.Snakes{iSlice} = [];
        C = reContL.Position;
        % convert to ij
        jj = (C(:, 1)-x0)/dx+1;
        ii = (C(:, 2)-y0)/dy+1;
        jj = sgolayfilt(jj, 3, 75);

        jj2 = ceil(jj(1)):floor(jj(end));
        ii2 = interp1(jj, ii, jj2);

        C = [jj2' ii2'];

        data.Snake.Snakes{iSlice} = C;

        % show
        data.Panel.View.Comp.hPlotObj.Snake.YData = (C(:, 2)-1)*dy+y0;
        data.Panel.View.Comp.hPlotObj.Snake.XData = (C(:, 1)-1)*dx+x0;

        % points
        if data.Point.InitDone
            xi = data.Point.Data.xi;
            ixm = data.Point.Data.ixm;
            NP = data.Point.Data.NP;
            yi = data.Point.Data.yi;

            [~, yi(iSlice, :)] = fun_PointOnCurve(C, dx, dy, x0, y0, xi, yi(iSlice, :));
            data.Point.Data.yi = yi;

            hPlotObj = data.Panel.View.Comp.hPlotObj;
            hPlotObj.Point.XData = xi(ixm);
            hPlotObj.Point.YData = yi(iSlice, ixm);
            hPlotObj.LeftPoints.XData = xi(ixm-NP:ixm-1);
            hPlotObj.LeftPoints.YData = yi(iSlice, ixm-NP:ixm-1);
            hPlotObj.RightPoints.XData = xi(ixm+1:ixm+NP);
            hPlotObj.RightPoints.YData = yi(iSlice, ixm+1:ixm+NP);

            guidata(hFig, data)
            updatePlotPoint;
        end

        reContL.Visible = 'off';

        % enable buttons
        data.Panel.Snake.Comp.Pushbutton.LoadSnake.Enable = 'on';
        data.Panel.Snake.Comp.Pushbutton.FreeHand.Enable = 'on';
        data.Panel.Snake.Comp.Pushbutton.Delete.Enable = 'on';
        data.Panel.Snake.Comp.Pushbutton.SaveSnake.Enable = 'on';
        data.Panel.Snake.Comp.Togglebutton.Slither.Enable = 'on';

        guidata(hFig, data)
    end

    end


    function fun_Callback_Togglebutton_SnakePanel_ReDraw_Cine(data, src, evnt);

        str = src.String;
        TagNo = data.CineActiveTagNo;

        x0 = data.cine(TagNo).x0;
        y0 = data.cine(TagNo).y0;
        dx = data.cine(TagNo).dx;
        dy = data.cine(TagNo).dy;

        iSlice = data.Panel.View_Cine.subPanel(TagNo).ssPanel(4).Comp.hSlider.Slice.Value;
        iSlice = round(iSlice);

        if strcmp(str, 'reDraw')
            src.String = 'Done';
            src.ForegroundColor = 'r';
            src.BackgroundColor = [1 1 1]*0.25;
            hA =data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hAxis.Image;

            if TagNo == 3
                C = data.cine(TagNo).SnakeL.Snakes{iSlice};
                % convert to xy
                C(:, 1) = (C(:, 1)-1)*dx+x0;
                C(:, 2) = (C(:, 2)-1)*dy+y0;
                reContL = drawfreehand(hA, 'Position', C, 'Closed', 0);
                set(data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.Snake,...
                    'YData', [], 'XData', []);

                C2 = data.cine(TagNo).SnakeR.Snakes{iSlice};
                % convert to xy
                C2(:, 1) = (C2(:, 1)-1)*dx+x0;
                C2(:, 2) = (C2(:, 2)-1)*dy+y0;
                reContL2 = drawfreehand(hA, 'Position', C2, 'Closed', 0);
                set(data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.Snake2,...
                    'YData', [], 'XData', []);
            else
                C = data.cine(TagNo).Snake.Snakes{iSlice};
                % convert to xy
                C(:, 1) = (C(:, 1)-1)*dx+x0;
                C(:, 2) = (C(:, 2)-1)*dy+y0;
                reContL = drawfreehand(hA, 'Position', C, 'Closed', 0);
                set(data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.Snake,...
                    'YData', [], 'XData', []);
            end
            
            % disable buttons
            data.Panel.Snake.Comp.Pushbutton.LoadSnake.Enable = 'off';
            data.Panel.Snake.Comp.Pushbutton.FreeHand.Enable = 'off';
            data.Panel.Snake.Comp.Pushbutton.Delete.Enable = 'off';
            data.Panel.Snake.Comp.Pushbutton.SaveSnake.Enable = 'off';
            data.Panel.Snake.Comp.Togglebutton.Slither.Enable = 'off';

        else % Done
            src.String = 'reDraw';
            src.ForegroundColor = 'g';
            src.BackgroundColor = [1 1 1]*0.25;

    %         data.cine(TagNo).Snake.Snakes{iSlice} = [];

            if TagNo == 3
                C = reContL.Position;
                C = fun_convert2ij(C, x0, y0, dx, dy);     % convert to ij
                data.cine(TagNo).SnakeL.Snakes{iSlice} = C;
                set(data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.Snake,...
                    'YData', (C(:, 2)-1)*dy+y0, 'XData', (C(:, 1)-1)*dx+x0);
                reContL.Visible = 'off';

                C2 = reContL2.Position;
                C2 = fun_convert2ij(C2, x0, y0, dx, dy);     % convert to ij
                data.cine(TagNo).SnakeR.Snakes{iSlice} = C2;
                set(data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.Snake2,...
                    'YData', (C2(:, 2)-1)*dy+y0, 'XData', (C2(:, 1)-1)*dx+x0);
                reContL2.Visible = 'off';

            else
                C = reContL.Position;
                C = fun_convert2ij(C, x0, y0, dx, dy);     % convert to ij
                data.cine(TagNo).Snake.Snakes{iSlice} = C;
                set(data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.Snake,...
                    'YData', (C(:, 2)-1)*dy+y0, 'XData', (C(:, 1)-1)*dx+x0);
                reContL.Visible = 'off';
            end

            % enable buttons
            data.Panel.Snake.Comp.Pushbutton.LoadSnake.Enable = 'off';
            data.Panel.Snake.Comp.Pushbutton.FreeHand.Enable = 'on';
            data.Panel.Snake.Comp.Pushbutton.Delete.Enable = 'off';
            data.Panel.Snake.Comp.Pushbutton.SaveSnake.Enable = 'on';
            data.Panel.Snake.Comp.Togglebutton.Slither.Enable = 'on';

            guidata(hFig, data)

        end

    end

    function Cout = fun_convert2ij(C, x0, y0, dx, dy)
        jj = (C(:, 1)-x0)/dx+1;
        ii = (C(:, 2)-y0)/dy+1;

        winLen = min(round(length(jj)/4), 25);
        if mod(winLen, 2) == 0
            winLen = winLen - 1;
        end
        jj = sgolayfilt(jj, 3, winLen);

        jj2 = ceil(jj(1)):floor(jj(end));
        ii2 = interp1(jj, ii, jj2);

        Cout = [jj2' ii2'];
    end

end