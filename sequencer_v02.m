% Oliver Dowie - April 2020

% / / / / / / / / / / / / / / / / / / / / / / /

% attempting to generate audio within MATLAB.
% spoiler alert, it's too tricky at this stage
% this does produce audio, but it's horrible and
% the speed and start/stop controls don't work properly.

% / / / / / / / / / / / / / / / / / / / / / / /

clear

% setup uifigure:
fig = uifigure;
fig.Name = 'Sequencer';


% setup ui controls:

speed = uiknob(fig, 'discrete',...
                'Position',[100 160 50 45],...
                'ValueChangedFcn', @speed_callback);
speed.Items = {'slower',' ',' ',' ',' ',' ',' ',' ',' ', 'faster'};
speed.ItemsData = {1, 0.8, 0.6, 0.4, 0.2, 0.1, 0.08, 0.06, 0.04, 0.02};
set(speed, 'Value', 0.4);

startStop = uiswitch(fig, 'toggle',...
                        'Items', {'stop', 'start'},...
                        'Position', [265 160 20 45],...
                        'ValueChangedFcn', {@startStop_callback, speed});
                    


% sequence contained in start/stop switch callback function:

function startStop_callback(src, eventdata, speed)
    
    melody = [200, 300, 400]; % oscialltor pitch values
    
    
    %notes = struct('C4',261.63,'E4',329.63,'G4sharp',415.30,'A4',440,'B4',493.88, ...
    %'C5',523.25,'D5',587.25,'D5sharp',622.25,'E5',659.25,'Silence',0);

    deviceWriter = audioDeviceWriter('SampleRate',44100); % init audio device

        toggle = get(src, 'Value');
        i = 1;
        speedVal = 0.4;

        while strcmp(toggle, 'start') 
            for i = 1:length(melody)
                tic
                while toc < 1 % using an idea from the audioOscillator documentaion
                    osc = audioOscillator('Frequency',melody(i),'Amplitude',0.7);

                    synthesizedAudio = osc();
                    deviceWriter(synthesizedAudio);
                end

                if isempty(guidata(speed))
                        speedVal = 0.4;
                else
                        speedVal = guidata(speed);
                end
                
                    toggle = get(src, 'Value'); % check for stop switch
                    if strcmp(toggle, 'stop')
                        break
                    end
            end
        end
end




