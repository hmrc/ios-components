fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios sync_project_with_local_components
```
fastlane ios sync_project_with_local_components
```
Get project path and replace remote components with local
### ios update_dependent_projects
```
fastlane ios update_dependent_projects
```
Creates a development tag and updates projects using this swift package
### ios reset_dependent_projects
```
fastlane ios reset_dependent_projects
```
Reset dependent projects to remote URL
### ios sync_certificates
```
fastlane ios sync_certificates
```
This will sync adhoc certificates to allow the companion app to build on CI
### ios build_adhoc_app
```
fastlane ios build_adhoc_app
```
Build adhoc app for testing
### ios register_new_device
```
fastlane ios register_new_device
```
Register new devices
### ios take_release
```
fastlane ios take_release
```
Create a new tagged release of the library.

This will bump the release tag, precompile the library, commit and tag the changes, then push up to master.
### ios generate_screenshots
```
fastlane ios generate_screenshots
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
```
fastlane ios open_booted_sim
```
Open and boot named simulator

Example:

`fastlane open_booted_sim device:'iPhone 11 Pro Max' version:'latest'`

Options:

 - device: (Required) Simulator to run the tests on

 - version: (Optional) iOS version of the Simulator
### ios remove_artifacts_directory
```
fastlane ios remove_artifacts_directory
```
Remove artifacts directory

Example:

 `fastlane remove_artifacts_directory

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
