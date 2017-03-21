function shortcut2figtool(tooltiptag)
%SHORTCUT2FIGTOOL: Executes/Emulates callbacks of figure toolbar buttons.
%Can be used to create a shortcut to figure menu items in the quick access
%toolbar (useful for docked figures when the figure toolbar is "hidden"
%behind the Figure toolstrip).
%
%Syntax: SHORTCUT2FIGTOOL(tooltiptag)
%
%e.g.:    SHORTCUT2FIGTOOL('FileOpen') --> opens a new Figure
%
%The toolbar icons can be found by typing the following in the command
%window:
%fullfile(matlabroot,'/toolbox/matlab/icons/')
%
%Input argument:
%   tooltiptag - String with the emulated toolbar element
%
%The following inputs are accepted for tooltiptag:
%
%'PlottoolsOn'
%'PlottoolsOff'
%'InsertLegend'
%'InsertColorbar'
%'Linking'
%'Brushing'
%'DataCursor'
%'Rotate'
%'Pan'
%'ZoomOut'
%'ZoomIn'
%'EditPlot'
%'PrintFigure'
%'SaveFigure'
%'FileOpen'
%'NewFigure'
%
%This function relies heavily on undocumented functions and may break in a
%future Matlab release
%
%Author: Marc Jakobi
%        21.03.2017

if isempty(findobj('type', 'figure')) || isempty(findobj('type', 'axes'))
    % Do not run if no figure or axes is open
    return;
end
% Validate input
validTags = {'PlottoolsOn'; 'PlottoolsOff'; 'InsertLegend'; 'InsertColorbar'; 'Linking'; ...
    'Brushing'; 'DataCursor'; 'Rotate'; 'Pan'; 'ZoomOut'; 'ZoomIn'; 'EditPlot'; ...
    'PrintFigure'; 'SaveFigure'; 'FileOpen'; 'NewFigure'};
validatestring(tooltiptag, validTags);
if ismember(tooltiptag, {'PlottoolsOn', 'PlottoolsOff'})
    tooltiptag = ['Plottools.', tooltiptag];
elseif ismember(tooltiptag, {'InsertLegend', 'InsertColorbar'})
    tooltiptag = ['Annotation.', tooltiptag];
    h = findall(gcf, 'tag', tooltiptag);
    cax = get(gcf, 'CurrentAxes');
    switchstate
    if strcmp(tooltiptag, 'Annotation.InsertLegend')
        warning('off') %#ok<*WNOFF>
        if strcmp(h.State, 'on')
            leg = legend(cax, 'show');
            graph2dhelper('registerUndoLegendColorbar', leg);
        else
            legend(cax, 'off');
        end
        warning('on') %#ok<*WNON>
        return;
    else % InsertColorbar
        warning('off')
        if strcmp(h.State, 'on')
            cbar = colorbar('peer', cax);
            graph2dhelper('registerUndoLegendColorbar', cbar);
        else
            colorbar('peer',cax,'off');
        end
        warning('on')
        return;
    end
elseif strcmp(tooltiptag, 'Linking')
    tooltiptag = 'DataManager.Linking';
    h = findall(gcf, 'tag', tooltiptag);
    if strcmp(h.State, 'off')
        h.State = 'on';
    else
        h.State = 'off';
    end
    return;
elseif ismember(tooltiptag, {'Brushing', 'DataCursor', 'Rotate', 'Pan', 'ZoomOut', 'ZoomIn'})
    tooltiptag = ['Exploration.', tooltiptag];
    h = findall(gcf, 'tag', tooltiptag);
    switchstate
    if strcmp(tooltiptag, 'Exploration.DataCursor')
        datacursormode(gcf, h.State);
        return;
    elseif strcmp(tooltiptag, 'Exploration.Rotate')
        rotate3d(gcf, h.State);
        return;
    elseif strcmp(tooltiptag, 'Exploration.Pan')
        if strcmpi(h.State ,'on')
            pan(gcf, 'onkeepstyle')
        else
            pan(gcf, 'off');
        end
        return;
    elseif strcmp(tooltiptag, 'Exploration.ZoomIn')
        onoff = h.State;
        if strcmp(onoff, 'on')
            zoom(gcf,'inmode');
        else
            zoom(gcf,'off')
        end
        return;
    else % ZoomOut
        onoff = h.State;
        if strcmp(onoff, 'on')
            zoom(gcf, 'outmode');
        else
            zoom(gcf,'off')
        end
        return;
    end
else
    tooltiptag = ['Standard.', tooltiptag];
end
h = findall(gcf, 'tag', tooltiptag);
try
    if strcmp(h.State, 'off')
        h.State = 'on';
    else
        h.State = 'off';
    end
catch
end
callback = strrep(h.ClickedCallback, 'gcbo', 'h');
callback = strrep(callback, 'gcbf', 'gcf');
eval(callback);
    function switchstate
        if strcmp(h.State, 'off')
            h.State = 'on';
        else
            h.State = 'off';
        end
    end
end