% Oliver Dowie - 2020

% start / stop switch function

function startStop_callback(startStop, eventdata)
        
            value = get(startStop, 'Value');
            %disp(value);
            setappdata(startStop, 'value', value);
            
end

