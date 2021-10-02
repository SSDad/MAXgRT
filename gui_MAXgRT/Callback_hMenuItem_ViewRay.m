function Callback_hMenuItem_ViewRay(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
hMenuItem = data.hMenuItem;

if strcmp(src.Checked, 'off')
    hFig.Name = 'MAXgRT - ViewRay';
    
    src.Checked = 'on';
    hMenuItem.Cine.Checked = 'off';
    hMenuItem.Table.Checked = 'off';

    % off
    data.Panel.LoadImage_Cine.hPanel.Visible = 'off';
    data.Panel.View_Cine.hPanel.Visible = 'off';

    data.Panel.TableMode.PtInfo.hPanel.Visible = 'off';
    data.Panel.TableMode.Data.hPanel.Visible = 'off';
    data.Panel.TableMode.Table.hPanel.Visible = 'off';

    % on
    data.Panel.LoadImage.hPanel.Visible = 'on';

    data.Panel.ContrastBar.hPanel.Visible = 'on';
    data.Panel.SliceSlider.hPanel.Visible = 'on';
    data.Panel.View.hPanel.Visible = 'on';

    data.Panel.Selection.hPanel.Visible = 'on';
    data.Panel.Snake.hPanel.Visible = 'on';
    data.Panel.Point.hPanel.Visible = 'on';

    
end