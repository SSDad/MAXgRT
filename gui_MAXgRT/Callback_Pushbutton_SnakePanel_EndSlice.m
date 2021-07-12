function Callback_Pushbutton_SnakePanel_EndSlice(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
iSlice = round(data.Panel.SliceSlider.Comp.hSlider.Slice.Value);

data.Panel.Snake.Comp.Edit.EndSlice.String = num2str(iSlice);
if iSlice==data.Image.nImages
    clr = 'r';
else
    clr = 'g';
end
data.Panel.Snake.Comp.Edit.EndSlice.ForegroundColor = clr;