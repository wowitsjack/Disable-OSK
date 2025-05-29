# Block Annoying Touch Screen Keyboard on Pop!_OS & Ubuntu

**Stop the annoying default on-screen keyboard from popping up!** This bash script installs the **Improved OSK** extension - currently the **only known working method** to block the default touch screen keyboard behavior on Pop!_OS and Ubuntu.

## The Problem

Are you tired of:
- The on-screen keyboard randomly appearing when you don't want it?
- Touch screen triggering the OSK when you're using a physical keyboard?
- The default OSK interfering with your workflow?
- No easy way to disable touch screen keyboard activation?

## The Solution

The **Improved OSK** extension is currently the **only known working solution** to properly block the annoying default touch screen keyboard on:
- **Pop!_OS** (all recent versions)
- **Ubuntu** (with GNOME Shell)
- Other GNOME-based distributions

### How It Works
By installing this extension and enabling **"Ignore touch input"**, you can:
- **Block unwanted OSK activation** from touch events
- **Keep manual control** over when the keyboard appears
- **Stop interruptions** during normal computer usage
- **Maintain compatibility** with accessibility needs when required

## Compatibility

- **GNOME Shell versions**: 3.38, 40, 41, 42
- **Tested on**: Pop!_OS 22.04+, Ubuntu 20.04+, Ubuntu 22.04+
- **Works with**: Touch screen laptops, 2-in-1 devices, tablets running Linux

## Prerequisites

The script will check for these automatically:

- `wget` or `curl` (for downloading)
- `unzip` (for extracting)
- `gnome-shell` and `gnome-extensions` (pre-installed with GNOME)

## Quick Installation

```bash
# Download and run the installer
wget https://raw.githubusercontent.com/wowitsjack/main/install-improved-osk.sh
chmod +x install-improved-osk.sh
./install-improved-osk.sh
```

## Manual Installation

```bash
# Clone this repository
git clone https://github.com/wowitsjack/Disable-OSK-PopOS
cd Disable-OSK-PopOS

# Run the installer
./install-improved-osk.sh
```

## IMPORTANT: Post-Installation Setup

**You MUST complete these steps to actually block the annoying keyboard:**

### 1. Restart GNOME Shell
- Press **`Alt + F2`** to bring up the command menu
- Type **`r`** and press **Enter**
- Wait for GNOME Shell to restart

### 2. Enable the Extension
- Open the **GNOME Extensions** app
- Look for **"Improved OSK"** in your installed extensions
- **Toggle it ON** if it's not already enabled

### 3. **CRUCIAL**: Turn on "Ignore Touch Input"
- Click the **settings/gear icon** next to the Improved OSK extension
- **Turn ON "Ignore touch input"** - This is the key setting that blocks the annoying keyboard!
- Optionally adjust other settings as needed

## Verification

After setup, test that it's working:
- Touch your screen where text input fields are
- The annoying OSK should **NOT** pop up automatically
- You can still manually activate the OSK when needed

## Alternative Uses

While the main purpose is blocking the annoying OSK, this extension also provides:
- Enhanced on-screen keyboard with more keys (Arrow keys, Esc, Tab, Ctrl, Alt, Super, F1-12)
- Key combinations support (Ctrl+C, Alt+Tab, etc.)
- Manual keyboard toggle via statusbar indicator

## Troubleshooting

### OSK Still Appearing?

1. **Double-check the "Ignore touch input" setting**:
   - Open GNOME Extensions → Improved OSK → Settings
   - Ensure "Ignore touch input" is **turned ON**

2. **Restart GNOME Shell again**:
   - Press **`Alt + F2`** → type **`r`** → press **Enter**

3. **Verify extension is enabled**:
   ```bash
   gnome-extensions list --enabled --user | grep improvedosk
   ```

4. **Log out and log back in** if the above doesn't work

### Manual Commands

Enable the extension manually:
```bash
gnome-extensions enable improvedosk@nick-shmyrev.dev
```

Check if installed:
```bash
gnome-extensions list --user | grep improvedosk
```

## Uninstallation

To remove and go back to the annoying default behavior:

```bash
gnome-extensions disable improvedosk@nick-shmyrev.dev
rm -rf ~/.local/share/gnome-shell/extensions/improvedosk@nick-shmyrev.dev
```

## Why This Extension?

After extensive testing, **Improved OSK with "Ignore touch input" enabled** is currently:
- **The only reliable method** that actually works
- **Non-destructive** - doesn't break system functionality
- **Easily reversible** if you change your mind
- **Actively maintained** and compatible with recent GNOME versions

Other attempted solutions (dconf settings, input method modifications, etc.) either don't work or cause system issues.

## Links & Credits

- **Original Extension**: [Improved OSK by nick-shmyrev](https://github.com/nick-shmyrev/improved-osk-gnome-ext)
- **GNOME Extensions Page**: [extensions.gnome.org](https://extensions.gnome.org/extension/1508/improved-osk/)
- **GNOME Shell Extensions Guide**: [GNOME Documentation](https://wiki.gnome.org/Projects/GnomeShell/Extensions)

## Contributing

Found this helpful? Have improvements for the installer? 

1. Fork this repository
2. Create a feature branch  
3. Make your changes
4. Submit a pull request

## License

This installer script is provided as-is under the MIT License. The Improved OSK extension itself is licensed under MIT 

---

**Finally! No more annoying pop-up keyboards!**  
Made with care and lots of frustration at the default behavior. 
