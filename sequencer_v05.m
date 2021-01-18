% Oliver Dowie - April 2020

% a script to promt user for numbers to be entered into a musical sequence
% and then play the sequence, with UI control

% / / / / / / / /
% working : note entry and playback, input checking
% not working : silent notes, note number conversion
% / / / / / / / /

clear;

% print welcome and promt user for sequence length and check for valid input:
fprintf("Welcome to my musical sequencer...\n\n");
length = str2double(input... % use str2double on input for easier input checking
    ("Please tell me how many notes you would like to enter into the sequence: ", 's'));
while isnan(length)
    fprintf("//// Please only enter a numeric value ////\n");
    length = str2double(input...
    ("Please tell me how many notes you would like to enter into the sequence: ", 's'));
end
fprintf("\n\nNow enter numbers between 0 and 100 for our note values...\n");
fprintf("The pitch of each note will be higher of lower depending on the number entered.\n");
fprintf("A value of 0 will result in a silent note.\n\n");

global notes % make 'notes' a global variable for access inside main function
notes = [];
%i = 1;

% promt user for note values and check for valid inputs:
for i = 1:length
    
    noteVal = 0;
    fprintf("Enter a value for note %d: ", i);
    noteVal = str2double(input('', 's'));

        while noteVal > 100 || noteVal < 0 || isnan(noteVal)
            fprintf("\nThe value must be a single number within the range of 0 -> 100\n\n");
            fprintf("Enter a value for note %d: ", i);
            noteVal = str2double(input('', 's'));
        end

    notes(i) = noteVal;
end

fprintf("\n\nThe notes you entered will now be converted into a melody\n");
fprintf("within the C major scale...\n\n");




fprintf("\nPlease stand by for the user interface,\n");
fprintf("where you can control the playback of your melody...\n");


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