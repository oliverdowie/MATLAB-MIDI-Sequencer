% Oliver Dowie
% script to test animating the printing of text

% feed a character array into a for loop, printing one character per loop,
% with a short delay.


% create character array:
A = '//// welcome to my musical sequencer ////';

% loop and print each character with a short pause:
for i = 1:size(A,2)
    fprintf("%s", A(i));
    pause(0.01);
end
fprintf("\n");