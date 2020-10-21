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
### ios tag_release
```
fastlane ios tag_release
```
Create a new tagged release of the library.

This will bump the Info.plist version, precompile the library, commit and tag the changes, then push up to master.
### ios update_dependencies
```
fastlane ios update_dependencies
```
Update dependencies.
### ios check_dependencies
```
fastlane ios check_dependencies
```
Check for outdated carthage dependencies.
### ios carthage_wrapper
```
fastlane ios carthage_wrapper
```
Run carthage in a wrapper that works with Xcode 12

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
