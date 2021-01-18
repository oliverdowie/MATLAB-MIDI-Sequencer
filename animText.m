% Oliver Dowie - 2020

% a function that takes a character array into 'charArray' and prints each
% character after a short delay, making the text look animated as it prints
% to the command window.

% enering a '1, 2, 3, or 4' into the 'newLine' input will print that number
% of new lines at the end of the text. any other value will not print a new line.

function[] = animText(charArray, newLine)

    for i = 1:size(charArray,2)
        fprintf("%s", charArray(i));
        pause(0.006); % pause between each character
    end
    
        switch newLine % switch statement for number of new lines
            case 1
                fprintf("\n");
            case 2
                fprintf("\n\n");
            case 3
                fprintf("\n\n\n");
            case 4
                fprintf("\n\n\n\n");
            otherwise
                return
        end

end
