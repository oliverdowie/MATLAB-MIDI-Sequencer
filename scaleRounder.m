% Oliver Dowie - 2020
% A function to round user input values into a musical scale

% idea for this function taken from the matlab forums:
% User: Tom Gaudette
% https://au.mathworks.com/matlabcentral/answers/4249-round-towards-specific-values-in-an-array

function[melody] = scaleRounder(notesIn)

cMaj = scaleNoteVals([0 2 4 5 7 9 11]); % < my function to get all note values for a scale


% loop through each element of 'notesIn', comparing it to each element in
% 'cMaj' by subtracting the 'cMaj' values from the 'notesIn' values. The
% differences are added to the 'diff' array:

    for i = 1:length(notesIn)
        for j = 1:length(cMaj) 
            diff(j,i) = notesIn(i) - cMaj(j);
        end
    end
    
% each value of 'notesIn' will be rounded to the closest value in 'cMaj'
% this is done by finding the lowest value in each column of the 'diff'
% array, using the 'min' function (the lowest value being the result of the
% smallest difference between each element in 'notesIn' and 'cMaj')

    [values, index] = min(abs(diff));

% 'values' contains the lowest values
% 'index' now contains the list of index locations in cMaj that correspond to
% the nearest notesIn value

% assign the rounded values to 'melody':
    melody = cMaj(index);

end
