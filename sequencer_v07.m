% Oliver Dowie - April 2020

% a script to promt user for numbers to be entered into a musical sequence
% and then play the sequence, with UI control

% / / / / / / / /
% working : note entry and playback, input checking, silent notes, note
% conversion
% still needs work : tweaks to printed messages
% / / / / / / / /
% THIS VERSION: converted all printed messages to animated printing using
% my animText function

clear;

% print welcome and promt user for sequence length and check for valid input:
animText(' //// welcome to my musical sequencer ////', 3);
animText(' please tell me how many notes you would like to enter into the sequence: ', 0);
length = str2double(input('', 's'));
fprintf("\n");

while isnan(length)
    animText(' //// please only enter a numeric value ////', 1);
    animText(' please tell me how many notes you would like to enter into the sequence: ', 0);
    length = str2double(input('', 's'));
end

animText(' now enter numbers between 0 and 50 for the note values...', 1);
animText(' the pitch of each note will be higher of lower depending on the number entered.', 1);
animText(' a value of 0 will result in a silent note.', 2);


notes = [];

% promt user for note values and check for valid inputs:
for i = 1:length
    
    noteVal = 0;
    animText(' enter a value for note ', 0);
    fprintf("%d: ", i);
    noteVal = str2double(input('', 's'));

        while noteVal > 50 || noteVal < 0 || isnan(noteVal)
            fprintf("\n");
            animText(' the value must be a single number within the range of 0 -> 50', 2);
            animText(' enter a value for note ', 0);
            fprintf("%d: ", i);
            noteVal = str2double(input('', 's'));
        end

    notes(i) = noteVal;
end

fprintf("\n");
animText(' the notes you entered will now be converted into a melody', 1);
animText(' within the C major scale...', 1);

% scale up and convert note numbers:

notes = notes + 30;

global melody % make 'melody' a global variable for access inside main function
melody = scaleRounder(notes);

% implement wait animations:
waitAnimation(10, 0.03);

animText(' please stand by for the user interface,', 1);
animText(' where you can control the playback of your melody...', 1);

waitAnimation(10, 0.03);


animText(' the converted note numbers will be displayed as they are played', 2);

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