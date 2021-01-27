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
### ios prepare_release
```
fastlane ios prepare_release
```
Updates the project version and creates a release PR to be approved
### ios tag_release
```
fastlane ios tag_release
```
Create a new tagged release of the library.

This will bump the Info.plist version, precompile the library, commit and tag the changes, then push up to master.

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
