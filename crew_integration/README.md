# Chromebrew Integration
## Supported Systems
- All architecture supported by Chromebrew
- Chrome/Chromium OS based system (CloudReady) with 84+ version
- Stable channel (recommend)
## Features
- Add X/Wayland applications shortcut to Chrome/Chromium OS launcher though PWA
- Redirecting `x-www-browser` to Chrome/Chromium browser
- Redirecting `x-terminal-emulator` to `crosh` shell
### Coming Soon?
- Install `.rb` installation file through Chrome extension
- Chromebrew GUI Store
## Installation
- This package is available at `crew`, install it by execute the following:
```bash
crew install crew_integration
```
## Help needed?
- Submit an new issues [here](https://github.com/skycocker/chromebrew/issues)<sup>*</sup>
<br>
<sup>*</sup> <em>Please check existing issues before submitting a new one.</em>

## Usage
```shell
crew_integration <option>
  -s                  Start shortcut server
  -n (App Name)       Make a new shortcut
  -h                  Show this message
  -u (URL)            Open URL
  -t                  Open Chrome terminal
```
