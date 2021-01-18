OLIVER DOWIE - 2020

MATLAB MIDI SEQUENCER



\\\
This MATLAB script requires the "Audio Toolbox" add-on for the implementation of MIDI data.
///



\\\
For the script to run correctly, the current MATLAB folder path needs to include the "functions" folder in this directory.
///



\\\
For the MIDI output to function correctly, the MIDI device needs to be set within the script.
In this case I am using the internal MIDI busses included in with MacOS. These are the IAC Driver Busses. These can be made available using the "Audio MIDI Setup" app in MacOS.

On Windows 10, a program such as "LoopMIDI" can provide similar internal MIDI routing options.

The app receiving the MIDI information must be set to receive MIDI on the same device.

I am using Ableton Live to receive the data, but a web app such as https://dotpiano.com/ can also be used. dotpiano.com will accept MIDI from all devices by default.

The MIDI data can also be sent to hardware devices by using a USB MIDI interface.
///



\\\
To change the MIDI device you need to know the devices you have available to use.
To find this out, type "mididevinfo" into the MATLAB command window. A list of MIDI devices will be displayed.

Input the name of your device into:

device = mididevice('your device name here');

This code is located on line 170 of the sequencer_FINAL script.
///


