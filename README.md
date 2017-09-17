# AssistantPi-Custom-installer-Pi3
A simple easy-installation script for those who want to easily install The Google Assistant SDK on their Pi3.
# YouTube Video
Coming Soon
# Requirements
* Raspberry Pi 3 running Raspbian (**feel free to experiment with other OSes**)
* Speakers
* Usb Microphone (or any other functional microphone setup)
# Notes before starting
* I'm going to assume at this point that you already have SSH access on your Pi
* Tell me if anything goes wrong
# Tutorial
## Configure and Test the Audio
**The following steps are modified from Google's official documentation.**
1. Verify that recording and playback work:

Play a test sound (this will be a person speaking). Press Ctrl+C when done. If you don't hear anything when you run this, check your speaker connection.
```
speaker-test -t wav
```
Record a short audio clip. If you get an error, go to step 2.
```
arecord --format=S16_LE --duration=5 --rate=16000 --file-type=raw out.raw
```
Check the recording by replaying it.
```
aplay --format=S16_LE --rate=16000 out.raw
```
Adjust the playback and recording volume.
```
alsamixer
```
If recording and playback are working, then you are done configuring audio. If not (or if you receive an error), continue to the next step below.

2. Find your recording and playback devices.

Locate your USB microphone in the list of capture hardware devices. Write down the card number and device number.
```
arecord -l
```
Locate your speaker in the list of playback hardware devices. Write down the card number and device number. Note that the 3.5mm-jack is typically labeled Analog.
```
aplay -l
```
3. Create a new file named .asoundrc in the home directory (/home/pi). Make sure it has the right slave definitions for microphone and speaker; use the configuration below but replace <card number> and <device number> with the numbers you wrote down in the previous step. Do this for both pcm.mic and pcm.speaker.
```
nano .asoundrc
```
```
pcm.!default {
  type asym
  capture.pcm "mic"
  playback.pcm "speaker"
}
pcm.mic {
  type plug
  slave {
    pcm "hw:<card number>,<device number>"
  }
}
pcm.speaker {
  type plug
  slave {
    pcm "hw:<card number>,<device number>"
  }
}
```
4. If you have both an HDMI monitor and a 3.5mm jack speaker connected, you can play audio out of either one. Run the following command:
```
sudo raspi-config
```
Go to **Advanced options > Audio** and select the desired output device.
5. Repeat Step 1 to verify that recording and playback work. If it's still not working, check that the microphone and speaker are properly connected. If this is not the issue, then try a different microphone or speaker.

1. Copy the repository to the home directory.
```
cd /home/pi
git clone https://github.com/YTThatOneGuy/AssistantPi-Custom-installer-Pi3.git
```
.

###### To be continued...
