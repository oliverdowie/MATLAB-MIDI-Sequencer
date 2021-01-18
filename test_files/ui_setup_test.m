% Oliver Dowie - 2020

% script to test GUI set up


% setup gui window:
fig = uifigure;
fig.Name = 's e q u e n c e r     p l a y b a c k     c o n t r o l   '; % window name
fig.Resize = 'off'; % disable resize
fig.Position = [1000 900 500 300];


% setup gui controls:


% speed knob
speed = uiknob(fig, 'discrete',... % knob type
                'Position',[290 120 70 70]); % knob position
speed.Items = {'slower',' ',' ',' ',' ',' ',' ',' ',' ',...
               ' ',' ',' ',' ',' ',' ',' ',' ', 'faster' }; % knob value labels
speed.ItemsData = {1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1,...
                    0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02}; % actual knob values
set(speed, 'Value', 0.4); % initial knob value



% start/stop switch
startStop = uiswitch(fig, 'toggle',...
                        'Items', {'stop', 'start'},...
                        'Position', [130 120 50 70]);