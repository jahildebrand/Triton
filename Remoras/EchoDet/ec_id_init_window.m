function ec_id_init_window

global REMORA

defaultPos = [0.25,0.25,0.3,0.2];
if isfield(REMORA.fig, 'ec')
    % check if the figure already exists. If so, don't move it.
    if isfield(REMORA.fig.ec, 'id_settings') && isvalid(REMORA.fig.ec.id_settings)
        defaultPos = get(REMORA.fig.ec.id_settings,'Position');
    else
        REMORA.fig.ec.id_settings = figure;
    end
else
    REMORA.fig.ec.id_settings = figure;
end

set(REMORA.fig.ec.id_settings,'NumberTitle','off', ...
    'Name','Make ID File from EchoDet Output',...
    'Units','normalized',...
    'MenuBar','none',...
    'Position',defaultPos, ...
    'Visible', 'on',...
    'ToolBar', 'none');

figure(REMORA.fig.ec.id_settings)

% button grid layouts
% 10 rows, 4 columns
r = 4; % rows      (extra space for separations btw sections)
c = 2;  % columns
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
bgColorGreen = [0.0 0.2 0.0];

REMORA.ec.id_verify = [];
%% Input folder
btnPos=[x(1)-w*.2 y(2)-2*ybuff w h];
loadFileStr = 'Input Folder';
REMORA.ec.id_verify.loadFileStr = uicontrol(REMORA.fig.ec.id_settings, ...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(loadFileStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');

%actual input part
labelStr=num2str(REMORA.ec.id_params.inDir);
btnPos=[x(2)-w*0.55 y(2) w*1.4 h*.8];
REMORA.ec.id_verify.filePathTxt = uicontrol(REMORA.fig.ec.id_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'Callback','ec_id_control(''setfilePath'')');

%% output name
btnPos=[x(1)-w*.2 y(3)-2*ybuff w h];
loadFileStr = 'ID File Name';
REMORA.ec.id_verify.loadFileStr = uicontrol(REMORA.fig.ec.id_settings, ...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(loadFileStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');

%actual input part
labelStr=num2str(REMORA.ec.id_params.outName);
btnPos=[x(2)-w*0.55 y(3) w*0.5 h*.8];
REMORA.ec.id_verify.outFileTxt = uicontrol(REMORA.fig.ec.id_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'Callback','ec_id_control(''setoutName'')');

%% Run button
labelStr = 'Create ID file';
btnPos=[x(2)-w/2 y(4)-2*ybuff w h];

REMORA.ec.id_verify.runTxt = uicontrol(REMORA.fig.ec.id_settings,...
    'Style','pushbutton',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColorGreen,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'FontSize',.4,...
    'Visible','on',...
    'FontWeight','bold',...
    'ForegroundColor',bgColor,...
    'Callback','ec_id_control(''runIt'')');
