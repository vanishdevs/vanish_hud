### Hud System
![](https://img.shields.io/github/downloads/vanishdevs/vanish_hud/total?logo=github)
![](https://img.shields.io/github/downloads/vanishdevs/vanish_hud/latest/total?logo=github)
![](https://img.shields.io/github/contributors/vanishdevs/vanish_hud?logo=github)
![](https://img.shields.io/github/v/release/vanishdevs/vanish_hud?logo=github)

This resource enhances the user experience by providing a customizable and functional display interface for various game elements. This resource includes several features to improve gameplay visibility and interaction. This resource is mostly standalone for it's features meaning it does not use any framework to fetch certain variables, but in order for the status (`thirst, hunger`) to properly work, you will have to integrate another resource with it, ESX status is already integrated for users within.

### Preview

[Watch the video](https://streamable.com/tn4o8e)

### Features

- **Radar Display**: Shows the radar while only on foot or configurable to always show.
- **Speedometer**: Option to display the speedometer.
- **Notification System**: Customizable notification system.
- **Seatbelt System**: 
  - Prevent players from exiting the vehicle while buckled.
  - Configurable keybind to toggle seatbelt.
  - Option to play sound when the seatbelt is toggled.
  - Adjustable volume for seatbelt sound .
- **Street Labels**: Option to enable or disable street labels with customizable text color (RGB values).

### Installation

- Copy the downloaded script files into your server's resource folder.
- Ensure the script is properly included in your server configuration file (`server.cfg`) to ensure it loads correctly when your server starts.
- Ensure you execute the convar configuration file for configuration options to work, you would do this by simple adding `exec @vanish_hud/config.cfg` in the `server.cfg`.
- Ensure that you have the necessary dependencies installed.

### Dependencies

Ensure that the following dependency is installed:

- `ox_lib`: [Download here](https://github.com/overextended/ox_lib.git)
- `esx_status`: [Download here](https://github.com/esx-framework/esx_status) (**[IMPORTANT]: Only if using ESX, if not configure with your own status system**)
