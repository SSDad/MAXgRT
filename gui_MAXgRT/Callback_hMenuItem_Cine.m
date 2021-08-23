function Callback_hMenuItem_Cine(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
hMenuItem = data.hMenuItem;

if strcmp(src.Checked, 'off')
    hFig.Name = 'MAXgRT - Cine';
    
    src.Checked = 'on';
    hMenuItem.ViewRay.Checked = 'off';
    
    data.Panel.LoadImage.hPanel.Visible = 'off';
    data.Panel.LoadImage_Cine.hPanel.Visible = 'on';
    
    data.Panel.ContrastBar.hPanel.Visible = 'off';
    data.Panel.SliceSlider.hPanel.Visible = 'off';
    data.Panel.View.hPanel.Visible = 'off';

    data.Panel.Selection.hPanel.Visible = 'off';
    data.Panel.Snake.hPanel.Visible = 'off';
    data.Panel.Point.hPanel.Visible = 'off';

    data.Panel.View_Cine.hPanel.Visible = 'on';
    
    data.bMode = 'C';
    
%     set(data.Panel.Snake.Comp.Pushbutton.FreeHand,...
%         'Callback', @Callback_Pushbutton.SnakePanel_FreeHand_Cine);
%     
    guidata(hFig, data);
    
end