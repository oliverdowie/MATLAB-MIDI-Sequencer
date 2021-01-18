% Oliver Dowie - 2020
% C major scale MIDI note numbers

% define first octave in the scale
cMajOct = [1 3 4 6 8 9 11];

% init vectors
addOct = [];
noteNums = cMajOct;

% loop through 10 times, adding 12 to each element to make up 10 octaves of
% note values
for i = 1:10
    addOct = [cMajOct+12*i];
    noteNums = [noteNums, addOct];
end

% trim off numbers over 127 (highest MIDI note value)
noteNums(noteNums > 127) = [];

disp(noteNums)
