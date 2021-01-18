% Oliver Dowie - April 2020

% a script to test looping a note sequence with a ui start/stop switch

clear

% setup uifigure:
fig = uifigure;
fig.Name = 'Sequencer';


% setup ui controls:

startStop = uiswitch(fig, 'toggle',...
                        'Items', {'stop', 'start'},...
                        'Position', [265 160 20 45],...
                        'ValueChangedFcn', @startStop_callback);
     

% set up MIDI device

device = mididevice('IAC Driver Bus 1');
channel = 1;
note = [60, 62, 57, 55, 67];
velocity = 100;

pause(5);

% while loop to start/stop the sequence
while strcmp((getappdata(startStop, 'value')), 'start')
    
            for i = 1:length(note)
        
                midisend(device, 'NoteOn', channel, note(i), velocity);
                pause(0.1);
                midisend(device, 'NoteOff', channel, note(i), velocity);
        
                disp(note(i))
                
                %toggle = get(src, 'Value');
                if strcmp((getappdata(startStop, 'value')), 'stop')
                    break
                end
            end 
end


% ////////////////////////

% start/stop switch works to start the sequence loop, but does NOT work to
% stop it

% ////////////////////////