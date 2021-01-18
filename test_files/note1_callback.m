% Oliver Dowie - 2020


% callback function for note value knob

function note1_callback(note1, eventdata)
        
            value = get(note1, 'Value');
            %disp(value);
            guidata(note1, value); % use guidata to store the data
            
end