% Oliver Dowie - 2020

% a function to print out a triangle using the size and indent inputs.

function[] = noteAnimation(size, indent)

A = [];
B = char(A);

indent(indent == 0) = 30;
indent = indent - 30;

if indent == 0
    size = 3;
end


% print triangle:

    for i = size:-1:1
        blnk = blanks(i+indent);    % blanks function creates empty char array
        fprintf("%s", blnk);        % for printing blank space at the beginning
        for j = 1 : (size - i)      % of each row.
            B(i) = '•';
            fprintf("%s ", B(i));
        end
        fprintf("\n");
    end
end
