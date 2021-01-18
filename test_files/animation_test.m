% Oliver Dowie - 2020

% a script to test printing dot shapes for use as a progress bar type
% animation.


A = [];
B = char(A);

for i = 15:-1:1
    for j = 1:(15-i)
        B(i) = '.';
        fprintf(" %s", B(i));
        pause(0.03);    % pause for incremental printing
    end
    fprintf("\n");
end

