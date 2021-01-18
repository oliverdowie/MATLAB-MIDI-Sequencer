% Oliver Dowie - April 2020

% a script to promt user for numbers to be entered into a musical sequence
% and then play the sequence, with UI control

% / / / / / / / /
% working : note entry and playback, input checking, silent notes
% still needs work : tweaks to printed messages, note conversion
% / / / / / / / /

clear;

% print welcome and promt user for sequence length and check for valid input:
fprintf("\n//// welcome to my musical sequencer ////\n\n");
length = str2double(input...
    ("please tell me how many notes you would like to enter into the sequence: ", 's'));
while isnan(length)
    fprintf("//// please only enter a numeric value ////\n");
    length = str2double(input...
    ("please tell me how many notes you would like to enter into the sequence: ", 's'));
end
fprintf("\nnow enter numbers between 0 and 100 for the note values...\n");
fprintf("the pitch of each note will be higher of lower depending on the number entered.\n");
fprintf("a value of 0 will result in a silent note.\n\n");


notes = [];
%i = 1;

% promt user for note values and check for valid inputs:
for i = 1:length
    
    noteVal = 0;
    fprintf("enter a value for note %d: ", i);
    noteVal = str2double(input('', 's'));

        while noteVal > 100 || noteVal < 0 || isnan(noteVal)
            fprintf("\nthe value must be a single number within the range of 0 -> 100\n\n");
            fprintf("enter a value for note %d: ", i);
            noteVal = str2double(input('', 's'));
        end

    notes(i) = noteVal;
end

fprintf("\n\nthe notes you entered will now be converted into a melody\n");
fprintf("within the C major scale...\n");

% convert note numbers:
global melody % make 'melody' a global variable for access inside main function
melody = scaleRounder(notes);

% implement wait animations:
waitAnimation(10, 0.03);

fprintf("please stand by for the user interface,\n");
fprintf("where you can control the playback of your melody...\n");

waitAnimation(10, 0.03);


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
        
        global melody % recall global variable 'melody'
        melodyVal = melody; % assign to local variable
        
        % MIDI set up
        device = mididevice('IAC Driver Bus 1');
        channel = 1;
        velocity = 100;

        while strcmp(toggle, 'start') % while loop for start/stop
                    
            for i = 1:length(melodyVal)
                
                if melodyVal(i) == 0 % check for silent notes and assign 0 velocity
                    velocity = 0;
                else
                    velocity = 100;
                end
                
                midisend(device, 'NoteOn', channel, melodyVal(i), velocity);
                    
                    if isempty(guidata(speed))
                        speedVal = 0.4;
                    else
                        speedVal = guidata(speed);
                    end
                
                space = blanks(i); % print spaces before note value for effect
                fprintf("%s%s  %d\n\n", space, space, melodyVal(i));
                
                pause(speedVal);
                
                midisend(device, 'NoteOff', channel, melodyVal(i), velocity);
                
                toggle = get(startStop, 'Value'); % check for stop switch
                if strcmp(toggle, 'stop')
                    break
                end
            end 
        end
end

%msg = midimsg('NoteOff', channel, note(i), velocity);

%midisend(device, msg);