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
# Checklist
**This lil' checklist shows you what I need to do/have done.**
- [x] Actually make the script
- [x] Finish the modified Google Tutorial part of the tutorial
- [x] Finish the rest of the Tutorial
- [ ] Test said script
- [ ] Make YouTube video
- [ ] Edit said video

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

## Configure a Developer Project and Account Settings
### Configure a Google Developer Project
> A Google Developer Project gives your device access to the Google Assistant API. The project tracks quota usage and gives you valuable metrics for the requests made from your device.
To enable access to the Google Assistant API, do the following on your development machine:
1. In the Cloud Platform Console, go to the Projects page. Select an existing project or create a new project.
[GO TO THE PROJECTS PAGE](https://console.cloud.google.com/project)
2. Enable the Google Assistant API on the project you selected (see the [Terms of Service](https://developers.google.com/assistant/sdk/terms-of-service)).
[ENABLE THE API](https://console.developers.google.com/apis/api/embeddedassistant.googleapis.com/overview)
Click **Enable.**
3. Create an OAuth Client ID with the following steps:

* Create the client ID. 
* [CREATE AN OAUTH CLIENT ID](https://console.developers.google.com/apis/credentials/oauthclient)
* You may need to set a product name for the product consent screen. On the OAuth consent screen tab, give the product a name and click Save.
* Click **Other** and give the client ID a name.
* Click **Create.** A dialog box appears that shows you a client ID and secret. (No need to remember or save this, just close the dialog.)
* Click ⬇ (at the far right of screen) for the client ID to download the client secret JSON file (``` client_secret_<client-id>.json ```).

4. Copy the client_secret_<client-id>.json file from your development machine to your device. This step is not necessary if you downloaded this file directly to your device.

In a later step, you will use this file to authorize the Google Assistant SDK sample to make Google Assistant queries.

###Set activity controls for your account

In order to use the Google Assistant, you must share certain activity data with Google. The Google Assistant needs this data to function properly; this is not specific to the SDK.

Open the Activity Controls page for the Google account that you want to use with the Assistant. You can use any Google account, it does not need to be your developer account.

**Ensure the following toggle switches are enabled (blue):**

* Web & App Activity
  * In addition, be sure to select the Include Chrome browsing history and activity from websites and apps that use Google services checkbox.
* Device Information
* Voice & Audio Activity

# Using the script/Tutorial

1. Copy the repository to the home directory.
```
cd /home/pi
git clone https://github.com/YTThatOneGuy/AssistantPi-Custom-installer-Pi3.git
```
2. Make the script(s) executable
```
chmod +x Install1.sh
chmod +x Install2.sh
chmod +x run.sh
chmod +x update.sh
```
3. Run Installer 1
```
./Install1.sh
```
* **Run Installer 2 ONLY if errors appear**
```
./Install2.sh
```
4.
Run the authorization tool. Remove the --headless flag on the end if you are using the terminal directly on the Pi (VNC session or keyboard plugged in to the Pi)
```
google-oauthlib-tool --client-secrets /path/to/client_secret_client-id.json --scope https://www.googleapis.com/auth/assistant-sdk-prototype --save --headless
```
You should see a URL displayed in the terminal:
```
Please go to this URL: https://...
```
Copy-Paste the link into your browser of choice on any device. 

After you approve, a code will appear in your browser, such as "6/XXXX". Copy and paste this code into the terminal:
```
Enter the authorization code:
```
>If authorization was successful, you will see OAuth credentials initialized in the terminal.

>If instead you see InvalidGrantError, then an invalid code was entered. Try again, taking care to copy and paste the entire code.

5. Start the assistant
```
google-assistant-demo
```
*Try saying "Okay Google" or "Hey Google" and a query**
* Press ctrl+C at any time to stop it.
6. To start the assistant again from the home directory **(For Example: You restarted the Pi)**
cd AssistantPi-Custom-installer-Pi3
./run.sh
7. To install Assistant updates from the home directory
```
cd AssistantPi-Custom-installer-Pi3
./update.sh
```