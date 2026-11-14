# Contributing

Thanks for your interest in improving these kits. Every kind of help is welcome: bug reports, ideas, screenshots of games that use a kit, documentation fixes and code changes.

## Ways to help

- **Ask or answer questions** in [Discussions > Q&A](https://github.com/EvannT-acc/roblox-ui-kits/discussions/categories/q-a).
- **Show your game** in [Discussions > Show and tell](https://github.com/EvannT-acc/roblox-ui-kits/discussions/categories/show-and-tell). Seeing the kits in real games helps everyone.
- **Report a bug** with the [bug report form](https://github.com/EvannT-acc/roblox-ui-kits/issues/new?template=bug_report.yml).
- **Suggest a kit or a feature** with the [kit request form](https://github.com/EvannT-acc/roblox-ui-kits/issues/new?template=kit_request.yml).
- **Improve the README** if a step was unclear when you installed a kit.

## Changing a kit

The kits are Roblox model files (`.rbxm`), so changes are made in Roblox Studio.

1. Fork the repository and clone your fork.
2. Open `showcase/showcase.rbxl` in Studio, or insert the kit you want to change into an empty place.
3. Make your change and test it in a playtest. Check that the Output window shows no new errors.
4. Export the kit: in the Explorer, right-click the kit's root object and choose **Save to File...**. Keep the same root object name and save over the file in `kits/`.
5. If you changed the showcase place, save it over `showcase/showcase.rbxl`.
6. Update the README when install steps, settings or the look of a kit change. Screenshots go in `docs/images/` as JPEG files.
7. Open a pull request and fill in the checklist.

## Guidelines

- Each kit must stay self-contained: no dependency on another kit or on third-party packages.
- Keep settings in the kit's config module or in attributes, never hard-coded deep in a script.
- Validate everything the client sends to the server. Never trust remote arguments.
- Keep purchases safe: use `ProcessReceipt` correctly and keep product IDs at `0` in the repository.
- Write modern Luau: `task` library, string interpolation, no deprecated APIs.
- Keep one change per pull request so it is easy to review.

## Documentation style

- English, plain ASCII characters.
- No emoji in the README or in kit documentation.
- Short sentences and numbered steps for anything a reader has to do in Studio.

By contributing, you agree that your contribution can be shared under the same terms as the rest of the repository, and you agree to follow the [Code of Conduct](CODE_OF_CONDUCT.md).
