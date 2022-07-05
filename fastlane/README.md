fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios sync_project_with_local_components

```sh
[bundle exec] fastlane ios sync_project_with_local_components
```

Get project path and replace remote components with local

### ios update_dependent_projects

```sh
[bundle exec] fastlane ios update_dependent_projects
```

Creates a development tag and updates projects using this swift package

### ios reset_dependent_projects

```sh
[bundle exec] fastlane ios reset_dependent_projects
```

Reset dependent projects to remote URL

### ios dev_certs

```sh
[bundle exec] fastlane ios dev_certs
```

Sync development profiles for companion app

### ios regenerate_dev_certs

```sh
[bundle exec] fastlane ios regenerate_dev_certs
```

Regenerate development profiles for companion app

### ios sync_certificates

```sh
[bundle exec] fastlane ios sync_certificates
```

This will sync adhoc certificates to allow the companion app to build on CI

### ios build_adhoc_app

```sh
[bundle exec] fastlane ios build_adhoc_app
```

Build adhoc app for testing

### ios register_new_device

```sh
[bundle exec] fastlane ios register_new_device
```

Register new devices

### ios take_release

```sh
[bundle exec] fastlane ios take_release
```

Create a new tagged release of the library.

This will bump the release tag, precompile the library, commit and tag the changes, then push up to master.

### ios generate_screenshots

```sh
[bundle exec] fastlane ios generate_screenshots
```

Generate component screenshots using companion app

Using xcodebuild over scan because it does not allow us to specify the exact simulator to use as it overrides the `-destination` flag we need to set

Example:

 `fastlane generate_screenshots device:'iPhone XS Max' version:'latest'`

Options:

 - device: (Required) Simulator to run the tests on

 - version: (Optional) iOS version of the Simulator

 - force_dark_mode: (Optional)

### ios open_booted_sim

```sh
[bundle exec] fastlane ios open_booted_sim
```

Open and boot named simulator

Example:

`fastlane open_booted_sim device:'iPhone 11 Pro Max' version:'latest'`

Options:

 - device: (Required) Simulator to run the tests on

 - version: (Optional) iOS version of the Simulator

### ios screenshot_diff

```sh
[bundle exec] fastlane ios screenshot_diff
```

Find differences between baseline screenshots and locally generated screenshots.

Make sure you completely run the IntegrationTests target against iPhone 11 Max to generate a complete set of screenshots.

Once you have a full set of screenshots, you can rerun individual tests to update individual screenshots.

Example:

 `fastlane screenshot_diff`

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
