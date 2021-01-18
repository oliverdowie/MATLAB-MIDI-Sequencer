% Oliver Dowie - April 2020

% a script to test looping a note sequence with a ui start/stop switch

clear

% setup uifigure:
fig = uifigure;
fig.Name = 'Sequencer';


% setup ui controls:

% speed control
speed = uiknob(fig, 'discrete',...
                'Position',[100 160 50 45],...
                'ValueChangedFcn', @speed_callback);
speed.Items = {'slower',' ',' ',' ',' ',' ',' ',' ',' ', 'faster'};
speed.ItemsData = {1, 0.8, 0.6, 0.4, 0.2, 0.1, 0.08, 0.06, 0.04, 0.02};
set(speed, 'Value', 0.4);

% start/stop control
startStop = uiswitch(fig, 'toggle',...
                        'Items', {'stop', 'start'},...
                        'Position', [265 160 20 45],...
                        'ValueChangedFcn', {@startStop_callback, speed});



% sequence contained in start/stop switch callback function:

function startStop_callback(src, eventdata, speed)
        
        toggle = get(src, 'Value');
        speedVal = 0.5;
        
        % set up MIDI parameters
        device = mididevice('IAC Driver Bus 1');
        channel = 1;
        note = [60, 62, 57, 55, 67]; % predefined note sequence
        velocity = 100;

        while strcmp(toggle, 'start')  % while loop to start/stop sequence
    
            for i = 1:length(note) % for loop for playing each note
        
                midisend(device, 'NoteOn', channel, note(i), velocity);
                    
                    if isempty(guidata(speed)) % check value of speed knob
                        speedVal = 0.4;
                    else
                        speedVal = guidata(speed);
                    end
                
                pause(speedVal);
                
                midisend(device, 'NoteOff', channel, note(i), velocity);
        
                disp(note(i))
                
                toggle = get(src, 'Value'); % check for stop switch
                if strcmp(toggle, 'stop')
                    break
                end
            end 
        end
end

%msg = midimsg('NoteOff', channel, note(i), velocity);

%midisend(device, msg);