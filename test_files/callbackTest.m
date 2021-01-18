% Oliver Dowie - 2020

% script to test the callback function of a toggle button
% the goal is to get a useable on/off value out of the function



% ui botton should print '1' and '0' as it is switched


button = uicontrol('Style','togglebutton', 'String', 'on/off',...
                'Callback', @toggle_callback);

            
            
            
% printing 'button' will print all of the data for the 'button' ui control:
button

            
            
% this function is called whenever the button is activated            
% (button, eventdata) contains the button press data

% get(button, 'Value') gets the on/off value of the button
            
function toggle_callback(button, eventdata)
        
        toggle = get(button, 'Value');
        disp(toggle);
        
end

