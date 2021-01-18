% Oliver Dowie - April 2020

clear

% setup uifigure:
fig = uifigure;
fig.Name = 'Sequencer';


% setup ui controls:

startStop = uiswitch(fig, 'toggle',...
                        'Items', {'stop', 'start'},...
                        'Position', [265 160 20 45],...
                        'ValueChangedFcn', @startStop_callback);
                    
% wait for figure to initialise
pause(5);

% display value stored in getappdata
disp(getappdata(startStop, 'value'))

% //////////////////////
% this doesn't work. it seems the value for the starStop button can only be
% called from within the callback function
% //////////////////////