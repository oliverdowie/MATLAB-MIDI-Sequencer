 % Oliver Dowie - April 2020

% a script to promt user for numbers to be entered into a musical sequence
% and then play the sequence, with UI control

% / / / / / / / /
% working : note entry and playback, some input checking
% not working : silent notes, proper input checking
% / / / / / / / /

clear;


% print welcome and promt user for sequence length:
fprintf("Welcome to my musical sequencer...\n\n");
length = input("Please tell me how many notes you would like in the sequence: ");
fprintf("\n\nNow enter numbers between 0 and 100 for our note values...\n");
fprintf("The pitch of each note will be higher of lower depending on the number entered.\n");
fprintf("A value of 0 will result in a silent note.\n\n");

global notes % make 'notes' a global variable for access inside main function
notes = [];


% promt user for note values and check for errors:
for i = 1:length 
    fprintf("Enter a value for note %d: ", i);
    notes(i) = input('');
    if isempty(notes(i)) % check for empty entry and make 0
        notes(i) = 0;
    end
        while notes(i) > 100 || notes(i) < 0 || isnan(notes(i))
            fprintf("\nThe value must be a number within the range of 0 - 100\n");
            fprintf("Enter a value for note %d: ", i);
            notes(i) = input('');
        end
        
        
end


% setup uifigure:
fig = uifigure;
fig.Name = 'Sequencer';


% setup ui controls:

speed = uiknob(fig, 'discrete',...
                'Position',[250 100 50 50],...
                'ValueChangedFcn', @speed_callback);
speed.Items = {'slower',' ',' ',' ',' ',' ',' ',' ',' ', 'faster'};
speed.ItemsData = {1, 0.8, 0.6, 0.4, 0.2, 0.1, 0.08, 0.06, 0.04, 0.02};
set(speed, 'Value', 0.4);

%{
note1 = uiknob(fig, 'discrete',...
                'Position',[100 300 50 50],...
                'ValueChangedFcn', @note1_callback);
note1.Items = {'A','Bb','B','C','Db','D','Eb','E','F','Gb','G','Ab'};
note1.ItemsData = {45,46,47,48,49,50,51,52,53,54,55,56};
set(note1, 'Value', 48);
%}

startStop = uiswitch(fig, 'toggle',...
                        'Items', {'stop', 'start'},...
                        'Position', [100 100 50 60],...
                        'ValueChangedFcn', {@startStop_callback, speed});
                    


% sequence contained in start/stop switch callback function:

function startStop_callback(startStop, eventdata, speed)
        
        toggle = get(startStop, 'Value');
        
        global notes % recall global variable 'notes'
        note = notes; % assign value of 'notes' to local variable
        
        % MIDI set up
        device = mididevice('IAC Driver Bus 1');
        channel = 1;
        velocity = 100;

        while strcmp(toggle, 'start') % while loop for start/stop
    
            %notes = [48, 62, 57, 55, 67];
                    
            for i = 1:length(note)
        
                midisend(device, 'NoteOn', channel, note(i), velocity);
                    
                    if isempty(guidata(speed))
                        speedVal = 0.4;
                    else
                        speedVal = guidata(speed);
                    end
                
                pause(speedVal);
                
                midisend(device, 'NoteOff', channel, note(i), velocity);
        
                disp(note(i))
                
                toggle = get(startStop, 'Value'); % check for stop switch
                if strcmp(toggle, 'stop')
                    break
                end
            end 
        end
end

%msg = midimsg('NoteOff', channel, note(i), velocity);

%midisend(device, msg);