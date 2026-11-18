# Accessibility

These kits are meant to work for every player of your game, on every device Roblox supports. This page lists what is supported today, the known gaps, and how to report a barrier.

## Supported

- **Screen sizes:** windows and HUDs scale with the screen through `UIScale` and the viewport size, and most labels use scaled text, so the kits stay readable from small phones to large monitors.
- **Touch:** buttons, windows and panels respond to taps. The Skill Tree supports drag to pan and pinch to zoom.
- **Keyboard and mouse:** every panel that opens with a key has a configurable keybind: Skill Tree `K` and Admin Panel `F2` through attributes, Roles panel `H` through `OpenKey` in `TagConfig`.
- **Gamepad:** the animated buttons and the styled proximity prompts react to gamepad buttons.
- **Sound:** the HUD Kit settings window has separate Music and SFX volume controls. Every sound ID can be changed or set to silent in the kits' config modules.
- **Text:** all visible text lives in config modules or labels, so it can be changed, enlarged or translated without touching the scripts.

## Known limitations

- **Gamepad navigation:** menus do not yet support moving between buttons with the D-pad or thumbstick (`GuiService.SelectedObject`). Console players can use buttons that react to gamepad input, but cannot browse every window.
- **Motion and flashes:** some kits use camera shake, white flashes and fast particle effects (Limited Store reveal, Roll reveal, donation effects, Steal Egg Kit spinning shines). There is no option yet to reduce motion or disable flashes.
- **Safe areas:** most kits do not position themselves around device notches and rounded corners. Check the layout on phones with a notch before publishing.
- **Screen readers:** Roblox does not expose UI to screen readers, so the kits rely on visual information.

## Tips for your game

- Lower or disable the flash and shake effects in the reveal scripts if your audience includes players sensitive to flashing light.
- Keep the default text sizes or larger. Avoid shrinking windows below their default scale on mobile.
- Test every kit with the Studio Device Emulator on a phone, a tablet and a console layout.

## Reporting a barrier

If something in a kit is hard or impossible to use for you or your players, please open a [bug report](https://github.com/EvannT-acc/roblox-ui-kits/issues/new?template=bug_report.yml) and mention the device, the input method and what you were trying to do. Accessibility issues are treated as bugs.
