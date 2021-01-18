% Oliver Dowie
% driver to test the scaleNoteVals function

% numbers entered into the scaleNoteVals function should be the MIDI note
% values for the first octave of notes for a particular musical scale


disp("C major scale:")
C = scaleNoteVals([0 2 4 5 7 9 11]);

disp(C)


disp("all zeros:")
B = scaleNoteVals([0 0 0 0 0]);

disp(B)


disp("random numbers:")
A = scaleNoteVals([0 1 -3]);

disp(A)

% /// negative numbers ruin the number range ///