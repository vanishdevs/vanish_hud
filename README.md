### Hud System

This resource enhances the user experience by providing a customizable and functional display interface for various game elements. This resource includes several features to improve gameplay visibility and interaction.

### Preview

[Watch the video](https://streamable.com/5u1eo9)

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

### Configuration

Configure the following parameters in the config:

- `Coords`: The position where the NPC will be located.
- `Ped`: The model of the NPC (can be found in FiveM docs about peds).
- `PedAnim`: The scenario the NPC will be performing while standing.
- `Items`: The contents of the starter pack, defined as a table where the key is the item name and the value is the quantity.

### Dependencies

Ensure that the following dependency is installed:

- `ox_lib`: [Download here](https://github.com/overextended/ox_lib.git)
- `esx_status`: [Download here](https://github.com/esx-framework/esx_status) **Only if using ESX, if not configure with your own status system**