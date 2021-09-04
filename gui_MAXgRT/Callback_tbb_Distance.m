function Callback_tbb_Distance(src, evnt)
    hFig = ancestor(src, 'Figure');
    data = guidata(hFig);
    
    TagNo = data.CineActiveTagNo;
    h = imdistline(data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hAxis.Image);
%     h2 = images.roi.Line(data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hAxis.Image, ...
%         'Position',[50 50; 100 100]); 

c = get(h, 'Children');
c(1).FontSize = 12;
c(1).FontWeight = 'bold';

for n = 2:3
    c(n).Marker = '.';
    c(n).MarkerSize = 24;
    c(n).Color = 'w';
end

for n = 4:5
%     c(n).Marker = '.';
%     c(n).MarkerSize = 24;
    c(n).Color = 'w';
end