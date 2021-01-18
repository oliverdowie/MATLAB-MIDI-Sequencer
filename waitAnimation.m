% Oliver Dowie - 2020

% a function to gradually print out a diamond shape made of '•' characters
% the 'size' input defines the size of the diamond
% the 'time' input defines the time delay in seconds between the printing
% of each character

function[] = waitAnimation(size, time)

A = [];
B = char(A);


% diamond top half:

    for i = size:-1:1
        blnk = blanks(i+5);     % blanks function creates empty char array
        fprintf("%s", blnk);    % for printing blank space at the beginning
        for j = 1 : (size - i)  % of each row.
            B(i) = '•';
            fprintf("%s ", B(i));
            pause(time);
        end
        fprintf("\n");
    end


% diamond lower half:

    for i = 2:size
        blnk = blanks(i+5);
        fprintf("%s", blnk);
        for j = 1:(size - i)
            B(i) = '•';
            fprintf("%s ", B(i));
            pause(time);
        end
        fprintf("\n");
    end


end
