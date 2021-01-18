% Ooliver Dowie - 2020

% callback function for speed control

function speed_callback(speed, eventdata)
        
            value = get(speed, 'Value');
            %disp(value);
            guidata(speed, value); % stores the current value into guidata
            
end