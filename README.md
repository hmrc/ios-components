# HMRC Components Library for iOS [![Build Status](https://app.bitrise.io/app/1da484f90414ee0e/status.svg?token=O_OY6ORsuhaK7pYIwSr1bQ&branch=master)](https://app.bitrise.io/app/1da484f90414ee0e)

Build applications using components with the HMRC look and feel.

# Requirements

- iOS 11.0+
- Swift 5.0

# Installation

## Carthage

Carthage is a decentralised dependency manager that builds your dependencies and provides you with binary frameworks. To integrate the components library into your Xcode project using Carthage, specify it in your Cartfile:

```
github "hmrc/ios-components"
```

# Contributing

## Getting Started

The first step is to install [Homebrew](https://brew.sh):

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

We can then use Homebrew to install [Carthage](#carthage), [SwiftLint](#swiftlint), and [fastlane](#fastlane):

```
brew update && brew install carthage && brew install swiftlint && brew install fastlane
```

We then need install the latest Xcode Command Line Tools, and check this is set in Xcode in Preferences > Locations.

```
xcode-select --install
```

Next we need to build the dependencies of the app:

```
carthage bootstrap --platform ios --use-ssh
```

We're now ready to build and test the components app! 🎉

```
open UIComponents.xcodeproj
```

## Tools

### fastlane

We use [fastlane](https://docs.fastlane.tools/getting-started/ios) to automate tedious tasks such as tagging a new release.

Our fastlane [README](https://github.com/hmrc/ios-components/tree/master/fastlane) documents our custom actions.

### SwiftLint

We use [SwiftLint](https://github.com/realm/SwiftLint) to enforce Swift style and conventions. Our custom rules can be found in our [.swiftlint.yml](https://github.com/hmrc/ios-components/blob/master/.swiftlint.yml).

### Carthage

We use [Carthage](https://github.com/Carthage/Carthage) for dependency management.

- [ ] Add support for SPM
