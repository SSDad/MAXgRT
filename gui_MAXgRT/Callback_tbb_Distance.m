function Callback_tbb_Distance(src, evnt)
    hFig = ancestor(src, 'Figure');
    data = guidata(hFig);
    
    TagNo = data.CineActiveTagNo;
    h = imdistline(data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hAxis.Image);
%     h2 = images.roi.Line(data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hAxis.Image, ...
%         'Position',[50 50; 100 100]); 