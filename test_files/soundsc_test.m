% Oliver Dowie - 2020

% testing creating sounds using MATLAB ( seems very tricky )

% CODE NOT MINE, just trying possible methods of sound generation
% plays a short tone through the default sound device
t = 0:1/44100:1;
y = sin(2*pi*300*t);
yRange = [-0.7,0.7];
soundsc(y, 44100, yRange);