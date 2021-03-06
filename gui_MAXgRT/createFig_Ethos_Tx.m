function createFig_Ethos_Tx

global EthosTxTableName
global hFig
data = guidata(hFig);

EthosTxTableNo = length(EthosTxTableName);
EthosTxTableNo = EthosTxTableNo+1;
data.Ethos.TxTable(EthosTxTableNo).hFig = figure('MenuBar',            'none', ...
                                                        'Toolbar',              'none', ...
                                                        'NumberTitle',      'off', ...
                                                        'Units',                 'normalized',...
                                                        'Position',             [0.25 0.6 0.5 0.3],...
                                                        'Color',                 'black', ...
                                                        'CloseRequestFcn', @figCloseReq_Ethos_TxTable_, ...
                                                        'Visible',               'on',...
                                                        'Tag', num2str(EthosTxTableNo));

addMenu_Ethos_Tx(data.Ethos.TxTable(EthosTxTableNo).hFig);

% Name
cName = data.Ethos.Panel.PtInfo.Comp.Edit.Fraction.String;
if EthosTxTableNo == 1 % first table
    strName = cName;
else
    pName = EthosTxTableName{EthosTxTableNo-1};
    k = strfind(pName, '_');
    if numel(k)==1
        pFx1 = pName(k+1:end);
        pFx2 = [];
    else
        pFx1 = pName(k(1)+1:k(2)-1);
        pFx2 = pName(k(2)+1:end);
    end
    
    if isempty(pFx2) % no '_a'
        if strcmp(cName, pFx1)
            strName = [cName, '_a'];
        else
            strName = cName;           
        end
    else % w/ '_a'
        if strcmp(cName, pFx1) % same fraction
            L = 'abcdefghijklmnopqrstuvwxyz';
            kk = strfind(L, pFx2);
            strName = [cName, '_', L(kk+1)];
        else % new fraction
            strName = cName;           
        end
    end
end
EthosTxTableName{EthosTxTableNo} = ['Fx_', strName];
data.Ethos.TxTable(EthosTxTableNo).hFig.Name = ['CBCT_Tx_', EthosTxTableName{EthosTxTableNo}];

bgc = min(0.05*EthosTxTableNo*[1 1 1], 0.8);
data.Ethos.TxTable(EthosTxTableNo).Comp =...
    addTxTable2Fig(data.Ethos.TxTable(EthosTxTableNo).hFig, bgc);                                                    
                                                    
% List
data.Ethos.Panel.Tx.Comp.Pushbutton.Tx(EthosTxTableNo).String = EthosTxTableName{EthosTxTableNo};
data.Ethos.Panel.Tx.Comp.Pushbutton.Tx(EthosTxTableNo).BackgroundColor = bgc;
data.Ethos.Panel.Tx.Comp.Pushbutton.Tx(EthosTxTableNo).Visible = 'on';

guidata(hFig, data);