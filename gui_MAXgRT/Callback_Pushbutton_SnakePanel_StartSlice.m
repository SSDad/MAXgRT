function Callback_Pushbutton_SnakePanel_StartSlice(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
iSlice = round(data.Panel.SliceSlider.Comp.hSlider.Slice.Value);

data.Panel.Snake.Comp.Edit.StartSlice.String = num2str(iSlice);
if iSlice==1
    clr = 'r';
else
    clr = 'g';
end
data.Panel.Snake.Comp.Edit.StartSlice.ForegroundColor = clr;