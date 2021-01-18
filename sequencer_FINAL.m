% Oliver Dowie - April 2020

% this script reads in numerical values from the user to construct a
% sequence of notes to play a melody.

% the note numbers are converted into a musical scale.

% the converted notes are then looped, outputing MIDI data for use with
% external music software or hardware.

% the loop is controlled by a simple GUI with a start/stop switch and speed
% control.


clear;
clc;

%%
% /////////////////////////
% ////// USER INPUT ///////
% /////////////////////////

% print intro message:
    % 'animText' is a custom function to print messages one character at a
    % time into the command window, making it look animated.
fprintf("\n");
animText(' /////////////////////////////////////////', 1);
animText(' //// WELCOME TO MY MUSICAL SEQUENCER ////', 1);
animText(' /////////////////////////////////////////', 3);

% promt user for length of sequence:
animText(' please tell me how many notes you would like to enter into the sequence: ', 0);

% 'str2double' converts strings that represent numbers into numerical values.
% if it can't convert the input to a numerical value, it outputs NaN, 
% making input validation much easier.
length = str2double(input('', 's'));
fprintf("\n");

% validate user input and re-promt if error:
while isnan(length) || length < 1 || length > 32
    animText(' //// it''s best if you only enter a value between 1 and 32 ////', 2);
    animText(' please tell me how many notes you would like to enter into the sequence: ', 0);
    length = str2double(input('', 's'));
end

length = round(length);

fprintf("\n");
animText(' now enter numbers between 0 and 50 for the note values...', 1);
animText(' • lower numbers = lower pitch.', 1);
animText(' • higher numbers = higher pitch.', 1);
animText(' • a value of 0 will result in a silent note.', 2);

notes = [];

% promt user for each note value:
for i = 1:length
    
    noteVal = 0;
    animText(' enter a value for note ', 0);
    fprintf("%d: ", i);
    noteVal = str2double(input('', 's'));

        % validate user input and re-promt if error:
        while noteVal > 50 || noteVal < 0 || isnan(noteVal)
            fprintf("\n");
            animText(' //// the value must be a single number within the range of 0 -> 50 ////', 2);
            animText(' enter a value for note ', 0);
            fprintf("%d: ", i);
            noteVal = str2double(input('', 's'));
        end

    notes(i) = noteVal;
end

%%
% /////////////////////////
% //// NOTE CONVERSION ////
% /////////////////////////

fprintf("\n");
animText(' the notes you entered will now be converted into a melody', 1);
animText(' within the C major scale...', 1);


% scale up user input values by 30 to put them into a more musical range.
% make any value of 30 = 0, to return user 0s back to 0 (for silent notes):
notes = notes + 30;
notes(notes == 30) = 0;


% input 'notes' to the 'scaleRounder' function to round user values into
% a musical scale. in this case, it's a C major scale.
% assign the converted 'notes' vector to the global variable 'melody', for
% use within the main sequencer funtion:
global melody
melody = scaleRounder(notes); 


% graphical animations for fake wait time. just for effect :)
waitAnimation(9, 0.018);

animText(' please stand by for the user interface,', 1);
animText(' where you can control the playback of your melody...', 1);

waitAnimation(9, 0.018);

animText(' //// when you are ready, switch on the sequencer ////', 2);


%%
% /////////////////////////
% ////// GUI SET-UP ///////
% /////////////////////////

% GUI window:

fig = uifigure;
fig.Name = 's e q u e n c e r     p l a y b a c k     c o n t r o l   ';
fig.Resize = 'off';
fig.Position = [1000 900 500 300];


% setup GUI controls:

% speed control knob type, position, size etc.:
speed = uiknob(fig, 'discrete',...
                'Position',[290 120 70 70],...
                'ValueChangedFcn', @speed_callback); % callback function
            
            % labels and values for speed knob:
speed.Items = {'slower',' ',' ',' ',' ',' ',' ',' ',' ',...
               ' ',' ',' ',' ',' ',' ',' ',' ', 'faster' };
speed.ItemsData = {1, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.15, 0.1,...
                    0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02};
set(speed, 'Value', 0.4); % sets default knob value position

% start/stop switch switch type, position, size etc.:
startStop = uiswitch(fig, 'toggle',...
                        'Items', {'stop', 'start'},...
                        'Position', [130 120 50 70],...
                        'ValueChangedFcn', {@startStop_callback, speed});
                                        % callback function that also
                                        % passes the speed callback
                                        

%%                                       
% //////////////////////////////////////////////
% ///// FUNCTION FOR LOOPING NOTE SEQUENCE /////
% //////////////////////////////////////////////

% the note sequence loop is contained within the startStop callback function.
% I found this to be the most reliable way to get the switch to actually
% start and stop the sequence. the speed callback function is also passed
% into the startStop callback, so that we can also read the data from the
% speed control.

function startStop_callback(startStop, eventdata, speed)
        
        % get the value of the start/stop switch and assign to 'toggle'
        toggle = get(startStop, 'Value');
        
        % retrieve the global variable 'melody' and assign to local
        % vairable 'melodyVal'
        global melody
        melodyVal = melody;
        
        % set-up MIDI device:
        device = mididevice('MS-20 mini SYNTH'); % MIDI i/o device
        channel = 1;    % MIDI channel

        % while loop to start and stop the note sequence:
        while strcmp(toggle, 'start')
                    
            % for loop to loop through each note value:
            for i = 1:length(melodyVal)
                
                % assign a MIDI velocity of 0 for any note values of 0.
                % a velocity of 0 will produce a note off message, giving a
                % silent note. anything other than 0 has a velocity of 100.
                if melodyVal(i) == 0
                    velocity = 0;
                else
                    velocity = 100;
                end
                
                % send MIDI message:
                midisend(device, 'NoteOn', channel, melodyVal(i), velocity);
                    
                    % check for speed value:
                    if isempty(guidata(speed))
                        speedVal = 0.4;
                    else
                        speedVal = guidata(speed);
                    end
                
                
                % print triangles for each note:
                noteAnimation(4, melodyVal(i));
                
                % pause for the length of the speed value:
                pause(speedVal);
                
                % send MIDI note off message
                midisend(device, 'NoteOff', channel, melodyVal(i), velocity);
                
                
                % check for stop value from star/stop switch:
                toggle = get(startStop, 'Value');
                if strcmp(toggle, 'stop')
                    break
                end
            end 
        end
end



% the end

