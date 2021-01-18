% Oliver Dowie
% Musical scale MIDI note numbers

% This function takes in the first octave of MIDI note values, and expands
% that accross the range of MIDI note values (0 -> 127)

function[noteNums] = scaleNoteVals(firstOct)

% init vectors
addOct = [];
noteNums = firstOct;

% loop through 10 times, adding 12 to each element to make up 11 octaves of
% note values
    for i = 1:10
        addOct = [firstOct+12*i];
        noteNums = [noteNums, addOct];
    end

% trim off numbers over 127 (highest MIDI note value)
noteNums(noteNums > 127) = [];

end
