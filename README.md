<p align="center">
  <img src="icon.png" width="128" height="128" alt="Piper Studio Pro Icon">
</p>

# piper-studio-pro
Piper Studio Pro: A high-fidelity GTK4/libadwaita frontend for the Piper neural text-to-speech engine. Built natively for Linux, Piper Studio Pro allows you to generate, preview, and export high-quality AI speech seamlessly.

## Why use this?

Manually running terminal commands for local TTS generation can be tedious and lacks precise audio control. **Piper Studio Pro** streamlines this workflow by:

1. **Live Audio Tuning:** Adjust pitch shift and speed in real-time with precise visual sliders.
2. **Hugging Face Integration:** Paste a direct `.onnx` URL to automatically fetch and download community-trained models and their JSON configs instantly.
3. **Official Voice Browser:** Preview and download official Piper models directly within the app without ever opening a web browser.
4. **Local Voice Manager:** A clean GUI menu to manage your downloaded library and safely delete unwanted `.onnx` and `.json` files.
5. **HQ Export:** Export your generated speech directly to MP3 using ffmpeg.

## Compatibility

* **Distros:** Designed to work on any Linux distribution (CachyOS, Arch, Fedora, Debian, Ubuntu, etc.).
* **Desktop Environments:** Built using GTK4 and `libadwaita`. It fits natively into GNOME, but works flawlessly across KDE Plasma, Cinnamon, and other major desktop environments.

## Dependencies

Ensure you have the following installed on your Linux system:
* `piper-tts` (The core engine, expected to be located at `/opt/piper/piper`)
* `ffmpeg` (Used for pitch shifting and MP3 conversion)
* `python-gobject` / `python3-gi` (The Python bridge for GTK)
* `libadwaita` (For the modern GTK4 UI)

## Installation

### Manual

1. Change directory to home directory:
```bash
cd ~
```

2. Clone the repository:
```bash
git clone https://github.com/ZeroIndex-x636A06/piper-studio-pro.git
```

3. Change directory to piper-studio-pro install folder:
```bash
cd piper-studio-pro
```

4. Make the install script executable and run it:
```bash
chmod +x install.sh
./install.sh
```

## Usage

Once installed, **Piper Studio Pro** will appear in your desktop environment's application launcher. 

### Launch via Terminal

You can also launch the app manually from any terminal:
piper-studio

## Un-installation

The uninstaller will safely remove the application while giving you an interactive prompt asking if you'd like to keep or delete your downloaded voice models (located in ~/.local/share/piper/voices/).

### Manual

1. Change directory to home directory:
```bash
cd ~
```

2. Change directory to the piper-studio-pro install folder:
```bash
cd piper-studio-pro
```
*IF YOU DELETED THE DIRECTORY, RERUN THE CLONE COMMAND:*
```bash
git clone https://github.com/ZeroIndex-x636A06/piper-studio-pro.git
```
3. Make the un-install script executable and run it:
```bash
chmod +x uninstall.sh
./uninstall.sh
```

