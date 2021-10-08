function Callback_hMenuItem_MRISim(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
hMenuItem = data.hMenuItem;

if strcmp(src.Checked, 'off')
    hFig.Name = 'MAXgRT - MRI_Sim';
    
    src.Checked = 'on';
    hMenuItem.ViewRay.Checked = 'off';
    hMenuItem.Ethos.Checked = 'off';
    
    data.Ethos.Panel.PtInfo.hPanel.Visible = 'off';
    data.Ethos.Panel.Data.hPanel.Visible = 'off';
    data.Ethos.Panel.Table.hPanel.Visible = 'off';
    data.Ethos.Panel.Tx.hPanel.Visible = 'off';

    data.Panel.LoadImage.hPanel.Visible = 'off';
    
    data.Panel.ContrastBar.hPanel.Visible = 'off';
    data.Panel.SliceSlider.hPanel.Visible = 'off';
    data.Panel.View.hPanel.Visible = 'off';

    data.Panel.Selection.hPanel.Visible = 'off';
    data.Panel.Snake.hPanel.Visible = 'off';
    data.Panel.Point.hPanel.Visible = 'off';
    data.Panel.Body.hPanel.Visible = 'off';

    data.cine.Panel.LoadImage.hPanel.Visible = 'on';
    data.cine.Panel.View.hPanel.Visible = 'on';
    
    data.bMode = 'C';
    
%     set(data.Panel.Snake.Comp.Pushbutton.FreeHand,...
%         'Callback', @Callback_Pushbutton.SnakePanel_FreeHand_Cine);
%     
    guidata(hFig, data);
    
end