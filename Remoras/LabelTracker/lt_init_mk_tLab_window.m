function lt_init_mk_tLab_window

global REMORA


defaultPos = [0.25,0.25,0.38,0.4];
if isfield(REMORA.fig, 'lt')
    % check if the figure already exists. If so, don't move it.
    if isfield(REMORA.fig.lt, 'tLab_settings') && isvalid(REMORA.fig.lt.tLab_settings)
        defaultPos = get(REMORA.fig.lt.tLab_settings,'Position');
    else
        REMORA.fig.lt.tLab_settings = figure;
    end
else
    REMORA.fig.lt.tLab_settings = figure;
end

set(REMORA.fig.lt.tLab_settings,'NumberTitle','off', ...
    'Name','Create tLabs from detEdit Output',...
    'Units','normalized',...
    'MenuBar','none',...
    'Position',defaultPos, ...
    'Visible', 'on',...
    'ToolBar', 'none');

figure(REMORA.fig.lt.tLab_settings)

% button grid layouts
% 10 rows, 4 columns
r = 11; % rows      (extra space for separations btw sections)
c = 5;  % columns
h = 1/r;
w = 1/c;
dy = h * 0.8;
% dx = 0.008;
ybuff = h*.2;
% y position (relative units)
y = 1:-h:0;

% x position (relative units)
x = 0:w:1;


% colors
bgColor = [1 1 1];  % white
bgColorPink = [1.0 0.4 0.4];
bgColorOrange = [1.0 0.6 0.0];
bgColorGreen = [0.6 0.8 0.0];

REMORA.lt.tLab_paramsHelp = lt_tLab_getHelp_strings;

REMORA.lt.tLab_verify = [];
labelStr = 'tLab Creation Settings';
btnPos=[x(1) y(2) 5*w h];
REMORA.lt.tLab_verify.headtext = uicontrol(REMORA.fig.lt.tLab_settings, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'String',labelStr, ...
    'FontUnits','points', ...
    'FontWeight','bold',...
    'FontSize',10,...
    'Visible','on');  %'BackgroundColor',bgColor3,...

btnPos=[x(1) y(3)+ybuff 5*w h*.6];
loadSaveStr = 'Load/Save Paths';
REMORA.lt.tLab_verify.loadSaveTxt = uicontrol(REMORA.fig.lt.tLab_settings, ...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(loadSaveStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on',...
    'BackgroundColor',bgColorGreen);

%% Input file for conversion
btnPos=[x(1) y(4)+ybuff w h];
loadFileStr = 'Input Folder';
REMORA.lt.tLab_verify.loadFileStr = uicontrol(REMORA.fig.lt.tLab_settings, ...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(loadFileStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');

%actual input part
labelStr=num2str(REMORA.lt.tLab_params.filePath);
btnPos=[x(2) y(4)+2*ybuff (w*4)*.95 h*.8];
REMORA.lt.tLab_verify.filePathTxt = uicontrol(REMORA.fig.lt.tLab_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'TooltipString',sprintf(REMORA.lt.tLab_paramsHelp.filePath),...
    'Callback','lt_tLab_control(''setfilePath'')');

%% set TPWS iteration
btnPos=[x(1) y(6)+ybuff w h];
TPWSStr = 'TPWS Iteration';
REMORA.lt.tLab_verify.TPWSStr = uicontrol(REMORA.fig.lt.tLab_settings, ...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(TPWSStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');

%actual input part
TPWSitr = REMORA.lt.tLab_params.TPWSitr;
btnPos=[x(2) y(6)+2*ybuff w*.5 h*.8];
REMORA.lt.tLab_verify.TPWSitrTxt = uicontrol(REMORA.fig.lt.tLab_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',TPWSitr,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'TooltipString',sprintf(REMORA.lt.tLab_paramsHelp.TPWSitr),...
    'Callback','lt_tLab_control(''setTPWSitr'')');
%% file type string
btnPos=[x(1) y(5)+ybuff w h];
fileTypeStr = 'File Type';
REMORA.lt.tLab_verify.fileTypeStr = uicontrol(REMORA.fig.lt.tLab_settings, ...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(fileTypeStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');

%% initialize filetype button group
btnPos = [x(2) y(5)+2*ybuff w*3.8 h*.9];
bg = uibuttongroup(REMORA.fig.lt.tLab_settings,...
    'Visible','on',...
    'Position',btnPos);
    
%'SelectionChangedFcn',@bselection);

%% tpws file type button
if ~isfield(REMORA.lt.tLab_params,'TPWStype')
    REMORA.lt.tLab_params.TPWStype = 0;
end

if REMORA.lt.tLab_params.TPWStype
    showFDPCheck = 'on';
else
    showFDCheck = 'off';
end

labelStr = 'TPWS';
btnPos=[x(1) y(7) w*2 h*5];
REMORA.lt.tLab_verify.TPWSCheck = uicontrol(bg,...
    'Style','radiobutton',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'Value',REMORA.lt.tLab_params.TPWStype,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'HorizontalAlignment','left',...
    'Callback','lt_tLab_control(''setTPWSCheck'')');

%% remove FDs checkbox
if ~isfield(REMORA.lt.tLab_params,'rmvFDs')
    REMORA.lt.tLab_params.rmvFDs = 0;
end

% if REMORA.lt.tLab_params.rmvFDs
%     showFDPath = 'on';
% else
%     showFDPath = 'off';
% end

labelStr = 'Remove False Detections from TPWS';
btnPos=[x(2)+w/6 y(5) w*2 dy];
REMORA.lt.tLab_verify.rmvFDsCheck = uicontrol(REMORA.fig.lt.tLab_settings,...
    'Style','checkbox',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'Value',REMORA.lt.tLab_params.rmvFDs,...
    'FontUnits','normalized', ...
    'TooltipString',sprintf(REMORA.lt.tLab_paramsHelp.rmvFDs),...
    'Visible',showFDCheck,...
    'HorizontalAlignment','left',...
    'Callback','lt_tLab_control(''rmvFDsCheck'')');


%% ID file type checkbox
if ~isfield(REMORA.lt.tLab_params,'IDtype')
    REMORA.lt.tLab_params.IDtype = 0;
end

labelStr = 'detEdit ID File';
btnPos=[x(2) y(7) w h*5];
REMORA.lt.tLab_verify.IDCheck = uicontrol(bg,...
    'Style','radiobutton',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on',...
    'HorizontalAlignment','left',...
    'Callback','lt_tLab_control(''setIDCheck'')');
    %'Value',REMORA.lt.tLab_params.IDtype,...

%% FD file type checkbox
if ~isfield(REMORA.lt.tLab_params,'FDtype')
    REMORA.lt.tLab_params.FDtype = 0;
end

labelStr = 'detEdit FD File';
btnPos=[x(3) y(7) w*2 h*5];
REMORA.lt.tLab_verify.FDCheck = uicontrol(bg,...
    'Style','radiobutton',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'Value',REMORA.lt.tLab_params.FDtype,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'HorizontalAlignment','left',...
    'Callback','lt_tLab_control(''setFDCheck'')');

%% TD file type checkbox
if ~isfield(REMORA.lt.tLab_params,'TDtype')
    REMORA.lt.tLab_params.TDtype = 0;
end

labelStr = 'detEdit TD File';
btnPos=[x(4) y(7) w*2 h*5];
REMORA.lt.tLab_verify.TDCheck = uicontrol(bg,...
    'Style','radiobutton',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'Value',REMORA.lt.tLab_params.TDtype,...
    'FontUnits','normalized', ...
    'HandleVisibility','off',...
    'HorizontalAlignment','left',...
    'Callback','lt_tLab_control(''setTDCheck'')');
%% save dir filepath
btnPos=[x(1) y(7) w h];
saveDirStr = 'Output Directory';
REMORA.lt.tLab_verify.saveDirStr = uicontrol(REMORA.fig.lt.tLab_settings, ...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(saveDirStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');

%actual input part
labelStr=num2str(REMORA.lt.tLab_params.saveDir);
btnPos=[x(2) y(7)+ybuff (w*4)*.95 h*.8];
REMORA.lt.tLab_verify.saveDirTxt = uicontrol(REMORA.fig.lt.tLab_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'TooltipString',sprintf(REMORA.lt.tLab_paramsHelp.saveDir),...
    'Callback','lt_tLab_control(''setSaveDir'')');


%% file prefix
btnPos=[x(1) y(8) w h];
filePreStr = 'Output File Prefix';
REMORA.lt.tLab_verify.filePreStr = uicontrol(REMORA.fig.lt.tLab_settings, ...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(filePreStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');

%actual input part
labelStr=num2str(REMORA.lt.tLab_params.filePrefix);
btnPos=[x(2) y(8)+ybuff (w*3)*.5 h*.8];
REMORA.lt.tLab_verify.filePrefixTxt = uicontrol(REMORA.fig.lt.tLab_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'TooltipString',sprintf(REMORA.lt.tLab_paramsHelp.filePrefix),...
    'Callback','lt_tLab_control(''setFilePrefix'')');

%% Settings stuff
btnPos=[x(1) y(9)+ybuff 5*w h*.6];
settingsStr = 'Other Settings';
REMORA.lt.tLab_verify.settingsTxt = uicontrol(REMORA.fig.lt.tLab_settings, ...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(settingsStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on',...
    'BackgroundColor',bgColorPink);

%% label name
btnPos=[x(1) y(10) w h];
labelNameStr = 'Label Name';
REMORA.lt.tLab_verify.labelNameStr = uicontrol(REMORA.fig.lt.tLab_settings, ...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(labelNameStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');

%actual input part
labelStr=num2str(REMORA.lt.tLab_params.trueLabel);
btnPos=[x(2)-w/4 y(10)+ybuff (w*3)*.95 h*.8];
REMORA.lt.tLab_verify.label1Txt = uicontrol(REMORA.fig.lt.tLab_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'TooltipString',sprintf(REMORA.lt.tLab_paramsHelp.trueLabel),...
    'Callback','lt_tLab_control(''setLabel1Name'')');


%% time offset
btnPos=[x(1) y(11) w h];
tOffsetStr = 'Time Offset';
REMORA.lt.tLab_verify.tOffsetStr = uicontrol(REMORA.fig.lt.tLab_settings, ...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(tOffsetStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');

%actual input part
labelStr=num2str(REMORA.lt.tLab_params.timeOffset);
btnPos=[x(2)-w/4 y(11)+ybuff w h*.8];
REMORA.lt.tLab_verify.timeOffsetTxt = uicontrol(REMORA.fig.lt.tLab_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'TooltipString',sprintf(REMORA.lt.tLab_paramsHelp.timeOffset),...
    'Callback','lt_tLab_control(''setTimeOffset'')');

%% set click duration
btnPos=[x(3) y(11) w h];
clickDurStr = 'Click Duration';
REMORA.lt.tLab_verify.clickDurStr = uicontrol(REMORA.fig.lt.tLab_settings, ...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(clickDurStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');

%actual input part
labelStr=num2str(REMORA.lt.tLab_params.dur);
btnPos=[x(4)-w/5 y(11)+ybuff w h*.8];
REMORA.lt.tLab_verify.durTxt = uicontrol(REMORA.fig.lt.tLab_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'TooltipString',sprintf(REMORA.lt.tLab_paramsHelp.dur),...
    'Callback','lt_tLab_control(''setClickDuration'')');


%% Run button
labelStr = 'Create tLab File';
btnPos=[x(2)+w/2 y(12) w h];

REMORA.lt.tLab_verify.runTxt = uicontrol(REMORA.fig.lt.tLab_settings,...
    'Style','pushbutton',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColorOrange,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'FontSize',.5,...
    'Visible','on',...
    'FontWeight','bold',...
    'TooltipString',sprintf(REMORA.lt.tLab_paramsHelp.runButton),...
    'Callback','lt_tLab_control(''runtLabCreator'')');
