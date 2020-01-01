### Changes in 80100.27-Release:

- Changed: Updated event logic for oUF 9.0 (thanks @Rainrider)
- Changed: Update Interface version

### Changes in 80000.26-Release:

- Added: Honor level to tooltip
- Added: Level tag
- Fixed: Visibility not updating on expansion launch
- Fixed: Visibility not updating upon reaching max honor level
- Removed: Deprecated honor rested support

### Changes in 80000.25-Release:

- Fixed: Errors when mouse is disabled

### Changes in 80000.24-Release:

- Changed: Update Interface version
- Changed: Improved tooltip
- Changed: Mimicing the stock UI bar colors (can be overridden)
- Fixed: Honor tracking in Battle for Azeroth

### Changes in 70300.23-Release:

- Changed: Update Interface version
- Added: Tooltip support
- Added: Fade support

### Changes in 70200.22-Release:

- Changed: Update Interface version
- Changed: Tags are now prefixed and some renamed
- Fixed: Visibility hook not respecting element enabled state

### Changes in 70000.21-Release:

- Added: Visibility logic override support
- Changed: Moved the visibility logic to it's own function
- Changed: Current honor/experience level is passed through PostUpdate
- Fixed: Bar showing while in a vehicle

### Changes in 70000.20-Release:

- Added: Support for animated status bars (AnimatedStatusBarTemplate)
- Removed: Client backwards compatibility
- Fixed: Tags not updating for honor
- Fixed: Tags not updating correctly when leveling up
- Fixed: OverrideUpdateColor called on the wrong frame
- Fixed: Exhaustion updates for honor on bar and tags

### Changes in 70000.19-Release:

- Added: Support for Honor levels in Legion
- Added: Custom colors for Honor
- Changed: Update Interface version

### Changes in 60100.18-Release:

- Fixed: Element showing for restricted accounts (trial/veteran)

### Changes in 60000.17-Release:

- Added: Support for the new Veteran account type

### Changes in 60000.16-Release:

- Added: Support for users disabling the experience gain
- Fixed: Element showing when it was not supposed to

### Changes in 60000.15-Release:

- Added: License
- Added: Changelog
- Changed: Update Interface version
- Changed: Only show on player frame
- Changed: Internal performance tweaks

### Changes in 50400.14-Release:

- Added: Support for trial account level cap
- Changed: Update Interface version

### Changes in 50001.13-Release:

- Fixed: PostUpdate not firing for players in vehicle or at max level

### Changes in 50001.12-Release:

- Changed: Update Interface version
- Fixed: Taints caused by Blizzard leaking a global variable
- Removed: Support for oUF 1.5

### Changes in 40300.11-Release:

- Changed: Update Interface version
- Changed: Update support for oUF 1.6
- Changed: Added support for packagers to set the version automatically

### Changes in 40200.10-Release:

- Changed: Update Interface version
- Changed: Stop updating early if player is in a vehicle
- Removed: Experience bar for pets

### Changes in 40000.9-Release:

- Changed: Register tags regardless of element being added or not

### Changes in 40000.8-Release:

- Added: Tags

### Changes in 40000.7-Release:

- Added: Default texture to rested bar

### Changes in 40000.6-Release:

- Added: Override method
- Added: ForceUpdate method
- Added: PreUpdate method
- Changed: Update Interface version
- Changed: Update support for oUF 1.4
- Removed: Tooltip options

### Changes in 30300.5-Release:

- Added: Embedding support
- Changed: Update Interface version
- Fixed: Hide while in a vehicle regardless of layout properties
- Fixed: Hunter pet support

### Changes in 30200.4-Release:

- Fixed: Pass the rested xp regardless of unit

### Changes in 30200.3-Release:

- Fixed: Set the default texture properly
- Fixed: Use the interal unitID for unit checks

### Changes in 30200.2-Release:

- Fixed: Hide the rested bar on pets
- Fixed: Replicate the backdrop for pets
- Fixed: Framelevel on the rested bar

### Changes in 30200.1-Beta:

- First public release
