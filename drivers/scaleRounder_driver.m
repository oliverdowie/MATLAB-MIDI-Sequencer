% Oliver Dowie
% a driver to test the scaleRounder function

% 'A' can contain any numerical values
% 'B' should output the values of A rounded to the nearest values of the
% scale set in the scaleRounder function. In this case, it's the C major
% scale.

clc

% test 1

disp('input1')
in1 = [-300 6 7 8 9 10 11 12 13 14 15 300];
disp(in1)

disp('expected out1')
exp = [0 5 7 7 9 9 11 12 12 14 14 127];
disp(exp)

B = scaleRounder(in1);

disp('output1')
disp(B);


% test 2

disp('input2')
in2 = [-1 -239 -23458 123452 128 0 130];
disp(in2)

disp('expected out2')
exp = [0 0 0 127 127 0 127];
disp(exp)

C = scaleRounder(in2);

disp('output2')
disp(C);