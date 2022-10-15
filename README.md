# shortcut2figtool

> [![Maintenance](https://img.shields.io/badge/Maintained%3F-no-red.svg)](https://bitbucket.org/lbesson/ansi-colors)
>
> __NOTE:__
>
> Since I no longer use Matlab, I cannot actively maintain this model.
> I will gladly accept PRs, as long as I can review them without Matlab.

Matlab function for creating shortcuts to figure toolbar buttons (useful for docked figures).
Executes/Emulates callbacks of figure toolbar buttons.
Can be used to create a shortcut to figure menu items in the quick access
toolbar (useful for docked figures when the figure toolbar is "hidden"
behind the Figure toolstrip).

Syntax: shortcut2figtool(tooltiptag)

e.g.:    shortcut2figtool('FileOpen') --> opens a new Figure

See screenshot for example on how to use.
The toolbar icons can be found by typing the following in the command
window:
fullfile(matlabroot,'/toolbox/matlab/icons/')

Input argument:
   tooltiptag - String with the emulated toolbar element

The following inputs are accepted for tooltiptag:

'PlottoolsOn'
'PlottoolsOff'
'InsertLegend'
'InsertColorbar'
'Linking'
'Brushing'
'DataCursor'
'Rotate'
'Pan'
'ZoomOut'
'ZoomIn'
'EditPlot'
'PrintFigure'
'SaveFigure'
'FileOpen'
'NewFigure'

This function relies heavily on undocumented functions and may break in a
future Matlab release

Author: Marc Jakobi
        21.03.2017
