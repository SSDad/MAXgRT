function Callback_hMenuItem_ViewRay(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
hMenuItem = data.hMenuItem;

if strcmp(src.Checked, 'off')
    hFig.Name = 'MAXgRT - ViewRay';
    
    src.Checked = 'on';
    hMenuItem.MRISim.Checked = 'off';
    hMenuItem.Ethos.Checked = 'off';

    % off
    data.cine.Panel.LoadImage.hPanel.Visible = 'off';
    data.cine.Panel.View.hPanel.Visible = 'off';
    data.cine.Panel.PtInfo.hPanel.Visible = 'off';

    data.Ethos.Panel.PtInfo.hPanel.Visible = 'off';
    data.Ethos.Panel.Data.hPanel.Visible = 'off';
    data.Ethos.Panel.Table.hPanel.Visible = 'off';
    data.Ethos.Panel.Tx.hPanel.Visible = 'off';

    % on
    data.Panel.LoadImage.hPanel.Visible = 'on';

    data.Panel.ContrastBar.hPanel.Visible = 'on';
    data.Panel.SliceSlider.hPanel.Visible = 'on';
    data.Panel.View.hPanel.Visible = 'on';

    data.Panel.Selection.hPanel.Visible = 'on';
    data.Panel.Snake.hPanel.Visible = 'on';
    data.Panel.Point.hPanel.Visible = 'on';
    
    data.bMode = 'V';
    guidata(hFig, data);
    
end