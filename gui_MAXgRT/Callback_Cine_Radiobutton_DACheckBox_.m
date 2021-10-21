function Callback_Cine_Radiobutton_DACheckBox_(src, evnt)

global hFig
data = guidata(hFig);
% TagNo = data.cine.ActiveTagNo;
% 
% if strcmp(src.Tag, 'Diaphragm')
%     n = 1;
% elseif strcmp(src.Tag, 'Abdomen')
%     n = 2;
% else
%     n = 3;
% end

TagNo = str2num(src.Tag(1));
n = str2num(src.Tag(2));

if n~=3
    if src.Value
        data.cine.Measure(TagNo).hPlotObj.DA(n).Visible = 'on';
    else
        data.cine.Measure(TagNo).hPlotObj.DA(n).Visible = 'off';
    end
else
    if ~src.Value
        data.cine.Measure(TagNo).hAxis.DA(2).YDir = 'normal';
    else
        data.cine.Measure(TagNo).hAxis.DA(2).YDir = 'reverse';
    end
end