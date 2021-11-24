# HMRC Components Library for iOS [![Build Status](https://app.bitrise.io/app/1da484f90414ee0e/status.svg?token=O_OY6ORsuhaK7pYIwSr1bQ&branch=master)](https://app.bitrise.io/app/1da484f90414ee0e)

Build applications using components with the HMRC look and feel.

# Requirements

- iOS 13.0+
- Swift 5.3

# Installation

## Swift Package Manager
This library is set up to be used via Swift Package Manager - you can develop locally by following the instructions within the [wiki](https://github.com/hmrc/ios-components/wiki/Developing-with-the-Component-Library)


# Using the Component Library

The component library is created using molecular design. 

You can read more about this, and see the individual atoms, molecules, and organisms in the [Wiki](https://github.com/hmrc/ios-components/wiki)


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


### Using Android?
We have an android version of this library available [here](https://github.com/hmrc/android-components/) 
