# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Fixed
- Fixed incorrect hex codes for button highlights in 5.4.1

## [5.5.0] - 2021-04-13Z
### Changed
- Added optional body text to `InformationMessage`

## [5.4.1] - 2021-04-08
### Fixed
- Fixed incorrect hex code for `Semantic.cardShadow`

## [5.4.0] - 2021-04-08
### Changed
- Improved how colours work & allowed the option to subclass them as needed in the main app.

## [5.3.8] - 2021-03-16
### Changed
- Exposed `StatusView.iconContainerView` so it can be hidden if needed.

## [5.3.7] - 2021-03-12
### Fixed
- Fix tint colour of TransparentButton when changing light/dark mode

## [5.3.6] - 2021-02-09
### Changed
- Workaround for 'image recognition' voiceover issue with MenuRow

## [5.4.0] - 2021-01-27

### Added

- A way to use a development version of the package within main projects

## [5.3.2] - 2020-12-08
### Changed
- Use theme specific accessibility label prefixes

## [5.?.?] - ?
- Adding `fastlane` release process

## [5.0.0] - 2020-10-07
Xcode 12 update

## [4.6.5] - 2020-08-26
### Changed
- Adds a touch state to `InformationMessageCards` button

## [4.6.0] - 2020-08-20
- Added `IconButtonWithDisclosure`

## [4.5.2] - 2020-08-07
- Added `switchTintSelected`

## [4.5.1] - 2020-08-05
- Fixed button text bug when using view builder

## [4.5.0] - 2020-08-05
### Added
- Added `TouchPassThroughView`, `TouchPassThroughLabel`, `TouchPassThroughStackView`
- Changed `ViewWithCustomDisclosure` to use `TouchPassThroughStackView`
- Added selected state to `SecondaryButton` and `SelectRowView`

## [4.4.1] - 2020-08-03
### Fixed
- Removes height constraint from information message header primary buttons

## [4.4.0] - 2020-07-31
### Added
- Adds new `InformationMessageCard` component

## [4.3.1] - 2020-07-23
### Changed
- Changed status card title font to H5 from H6

## [4.3.0] - 2020-07-17
### Added
- Added header accessibility traits for fonts H3-H6
### Changed
- Changed `H6TitleBodyView` to `BoldTitleBodyView`

## [4.2.1] - 2020-07-06
### Changed
- Changed primary button highlighted state colours

## [4.2.0] - 2020-07-03
### Changed
- Changed `SummaryRowView` `prefixAccessibilityLabel` to `suffixAccessibilityLabel`

## [4.1.2] - 2020-06-23
### Fixed
- Fixed primary button background colour

## [4.1.1] - 2020-06-18
### Fixed
- Fixed some missing property assignments on `SelectRowView` and `SelectRowView`

## [4.1.0] - 2020-06-17
### Added
- Added new card shadow semantic colour

## [4.0.0] - 2020-06-10
### Removed
- Removed `switchAccessibilityLabel` from `SwitchRowView.Model`. The switch accessibility label can still be set like so: `switchRowView.switchView.accessibilityLabel = "..."`

### Added
- Adds Dark Mode for Semantic / Named component colours


## [4.0.0] - 2020-06-08


## [3.2.4] - 2020-05-29
### Added
- Added option for setting accessibility label for switch in `SwitchRowView`

## [3.2.3] - 2020-05-27
### Added
- Added option to exclude baseline from primary button

## [3.2.2] - 2020-05-21
### Changed
- Ignore `TextInputView` left view for accessibility

## [3.2.1] - 2020-05-20
### Changed
- Renamed `additionalViews` to `views` in `StatusCardView.Model` to align with `HeadlineCardView` and `PrimaryCardView`

### Fixed
- Fixed secondary button padding on `StatusCardView` and `StatusButtonCardView`

## [3.2.0] - 2020-05-20
### Changed
- Updated pink colour to improve contrast
- Changed `SelectRowView` accessibility label
- Tweaked `CardView` spacing for secondary buttons

## [3.1.0] - 2020-04-23
### Changed
- Gives secondary button top and bottom internal spacing of 12
- Removes top and button spacing around secondary button within a card view
- Removes bottom margin spacing if a secondary button is the last item within a card view

## [3.0.9] - 2020-04-03
### Changed
- Reduce vertical space between title and radio buttons in SelectRowViewGroup

## [3.0.8] - 2020-04-03
### Changed
- Reduce vertical spacing of SelectRowView when separators are not displayed

## [3.0.7] - 2020-04-02
### Fixed
- Fixed spacing of SelectRowView when separators are not displayed

## [3.0.6] - 2020-03-30
### Changed
- Dropped D1 prefix from version

### Fixed
- Removed whitespace

## [D1-3.0.5] - 2020-03-27
### Changed
- Modified `SelectRowGroupView` so that the separators are not visible by default [HMA-2390]

## [D1-3.0.4] - 2020-02-25
### Changed
- Modified `StatusCardView` to include optional secondary button and journey ID label

## [D1-3.0.3] - 2020-02-10
### Changed
- Modified `SelectRowGroupView` so that the subTitle does not change colour when validation fails

## [D1-3.0.2] - 2020-02-07
### Changed
- Changed logic with the `shouldAnimateExpansion` toggle on the `ExpandingRowViewComponent`

## [D1-3.0.1] - 2020-02-06
### Added
- Added `shouldAnimateExpansion` toggle to `ExpandingRowViewComponent`

## [D1-3.0.0] - 2020-01-23
### Changed
- Update SnapKit dependency to v5.0.1 (Swift 5)
- Update base iOS version to iOS 11

## [D1-2.35.0] - 2020-01-08
### Added
- Added a "menu" option to the summary row view for the screen reader so the content is read out as "heading, button, then content"

## [D1-2.34.0] - 2019-12-30
### Added
- Added optional icon to SummaryRowView.

## [D1-2.33.0] - 2019-12-17
### Changed
- Updated colours in line with gov.uk standards

## [D1-2.32.1] - 2019-12-16
### Fixed
- Fix for primary button baseline when enabling / disabling

## [D1-2.32.0] - 2019-12-16
### Changed
- Added dark green baseline to primary button
- Changed default `Select Row` selected image from a tick to a filled circle
- Changed `grey3` to #F3F2F1

### Removed
- Removed `grey4`

## [D1-2.31.1] - 2019-11-22
### Fixed
- Made `selectedIndex` property of  `SelectRowGroupView` publicly readable

## [D1-2.31.0] - 2019-11-21
### Added
- Added `SelectRowGroupView` which groups SelectRowView components along with a title, subTitle and validation label

## [D1-2.22.2] - 2019-11-15
### Changed
- Ensure preferredMaxLayoutWidth is updated when validation text is set after layout has occurred

## [D1-2.22.1] - 2019-11-15
### Changed
- Fixed layout issues with validation error label on `TextInputView`

## [D1-2.22.0] - 2019-11-14
### Changed
- Add `enforceMaxLength` var to `TextInputView` (default is true)

## [D1-2.21.1] - 2019-10-25
### Changed
- Makes `WarningView`'s `iconImageView` public instead of private
- Fix SelectRowView label text colour (so it works in dark mode)

## [D1-2.21.2] - 2019-10-18
### Changed
- Fix constraint error with InsetView that exhibits itself when a large number of views are added
- Updated Grey 4 in line with HMRC colour palette

## [D1-2.21.1] - 2019-09-03
### Fixed
- Fixed removing padding from `HeadlineCardView` and `PrimaryCardView`

## [D1-2.21.0] - 2019-08-20
### Changed
- Removed TextInputView `inputDidChange` handler

### Added
- Added TextInputView `didChangeInput`, `didEndInput`, `didClearInput` handlers

## [D1-2.20.0] - 2019-08-15
### Changed
- Added `func setComponents(_:)` to `CardView` which re-sets the `CardView.components` (as opposed to `addComponents(_:)` which appends the new components).
- Removes a SelectRowView example

### Fixed
- Fixed bug with `CardView.components` not being accurate.
- Made WarningView actually conform to `Component`

## [D1-2.19.3] - 2019-08-15
### Changed
- SelectRowView now controls a group rather than a single

## [D1-2.19.2] - 2019-08-08
### Added
- Add new `SelectRowView`

## [D1-2.19.1] - 2019-07-26
### Added
- Added `currentlySelectedIndex` to `TabBarView`
- Set `TabBarView` background color based on style
- Allowed `HeadlineCardView` to be subclassed

### Fixed
- `MultiColumnRowView` priority issues

## [D1-2.19.0] - 2019-07-18
### Removed
- Removed delayedCall utility function

## [D1-2.18.3] - 2019-07-10
### Added
- Adds `TabBarView` component to molecules

## [D1-2.18.2] - 2019-06-21
### Changed
- Made `WarningView` `bodyLabel` public to be accessed in tests
### Fixed
- Actually call `setContentPriority` in `ExpandingRowView`

## [D1-2.18.1] - 2019-06-19
### Fixed
- Fixed `ExpandingRowView` Large text size layout
- Fixed content hugging issues with `MultiColumnRowView`

## [D1-2.18.0] - 2019-06-19
### Changed
- Made TransparentButton config and action properties public
- Updated ReadMe for `WarningView`
- Adds extra `WarningView` example
- Adds "Warning" prefix to `WarningView` accessibility Label
- Removes `icon` as a Model param for `WarningView`

## [D1-2.17.0] - 2019-06-13
### Added
- Added `WarningView` molecule as per `HMA-1145`
- Added explicit (override) accessibility label to `ExpandingRowView`, and moved other accessibility variables to its model.

## [D1-2.16.0] - 2019-06-03
### Changed
- Change `LabelColumn` priority property to horizontalPriority

## [D1-2.15.2] - 2019-05-31
### Changed
- Allow `ExpandingRowComponent` to be initialised in open or condensed format

## [D1-2.15.2] - 2019-05-24
### Added
- Added an App Icon to Components App

## [D1-2.15.1] - 2019-05-24
### Changed
- Updates `TitleBodyView` to take a `NSAttributedString` as title

## [D1-2.15.0] - 2019-05-21
### Changed
- SummaryRowView can now prefix the accessibility label with the item row index and total count

### Fixed
- Fixed wrapping of `TextInputView` character count label when font is scaled

## [D1-2.14.0] - 2019-05-14
### Added
- Added ability to embed  `[UIView]` within `InsetView`
- Added ability to use `[NSAttributedString]` within the `MultiColumnRowView`
### Changed
- Removed SnapKit from `InsetView` in favour of `NSLayoutConstraint` anchors
- Made the constants for IconButtonView Public

## [D1-2.13.0] - 2019-04-24
### Added
- Added ability to use an `NSAttributedString` for a `HeadlineCardView`'s `headlineLabel` (e.g. for displaying balances where the pounds component is in a larger font than the pence.)

## [D1-2.12.0] - 2019-04-05
### Changed
- MultiColumnRowView now takes an optional array of LabelColumn structs to define column attributes

## [D1-2.11.0] - 2019-04-05
### Added
- Added French localization for accessibility strings

## [D1-2.10.0] - 2019-04-04
### Changed
- Added ability to copy the value of a column within a MultiColumnRowView

## [D1-2.9.9] - 2019-04-04
### Fixed
- Added accessibility label to TextInputView's clear button

## [D1-2.9.6] - 2019-03-28
- Added App/Lib version to nav controller

## [D1-2.9.5] - 2019-03-26
### Changed
- Updated lib to build with Swift 5
- Moved example app images into ExampleImages enum

## [D1-2.9.4] - 2019-03-25
### Fixed
- Fixed layout issue with MultiColumnRowView [HMA-570]

## [D1-2.9.3] - 2019-03-25

## [D1-2.9.2] - 2019-03-20
### Fixed
- Fixed alignment issue on icon within example StatusCardView
- ContainerView configurations can now be modified by setting properties directly or by using builder type pattern
- Fixes top and bottom padding on example StatusCardView

## [D1-2.9.1] - 2019-03-12
### Changed
- Fixed README
- Fixed text in `BulletLabelView` to use standard label atom

## [D1-2.9.0] - 2019-03-11
### Added
- Added `BulletLabelView` atom

### Changed
- Can now use an array of styles when initialising or updating `MultiColumnRowView.swift`
- `SeparatorConfiguration` init is now public

## [D1-2.8.2] - 2019-03-06
### Changed
- Content view of `ExpandingRowView` now uses full horizontal space
- Added `middleLinesOnlyFullWidth` & `allLinesFullWidth` config to `SeparatorView`

## [D1-2.8.1] - 2019-02-27
### Fixed
- Added correct `onTintColor` to `SwitchRowView`

## [D1-2.8.0] - 2019-02-26
### Changed
- Componentised `SwitchRowView`

## [D1-2.7.2] - 2019-02-21
### Fixed
- Added accessibilityIdentifier to ButtonDescriptor

## [D1-2.7.1] - 2019-02-21
### Fixed
- Fixed `H6TitleBodyView` spacing

## [D1-2.7.0] - 2019-02-20
### Changed
- Added `H6TitleBodyView`
- Updated `SwitchRowView` to use `H6TitleBodyView` instead of `H5TitleBodyView`

## [D1-2.6.6] - 2019-02-08
### Changed
- Added typealias for BoolHandler

## [D1-2.6.5] - 2019-02-08
### Changed
- SummaryRowView has new property `suppressDisclosureView` which allows row content to utilise full width
- StatusCardView now can have any number of additional UIViews as children

## [D1-2.6.4] - 2019-01-23
### Changed
- Opened `UITextViewDelegate` funcs so that they can be overridden by subclasses.

## [D1-2.6.3] - 2019-01-22
### Fixed
- Fix text indent of IconButtonView when there is no icon

## [D1-2.6.2] - 2019-01-18
### Fixed
- Fixed Summary Row View disabled state

## [D1-2.6.1] - 2019-01-17
### Changed
- Opened up a couple of `TextInputView` `func`, which in turn required `CurrencyInputView` to require updating

## [D1-2.6.0] - 2019-01-17
### Added
- CGFloat extensions for spacing

## [D1-2.5.0] - 2019-01-17
### Changed
- SummaryRowView ReaderTraits renamed to `simple` and `info`
- SummaryRowView chevron now hidden when no action set

### Added
- Add option to set accessibility label and hint for SummaryRowView

## [D1-2.4.1] - 2019-01-11
### Changed
- Set MultiColumnRowView alignment to top

### Fixed
- Fixed black background bug seen on some overlayable components

## [D1-2.4.0] - 2019-01-09
### Fixed
- Fixed InsetView accessibility issues

### Added
- Added debug overlay facility [NGC-4284]

## [D1-2.3.0] - 2019-01-03
### Added
- Added `removePadding(onViews:)` method to PrimaryCardView and HeadlineCardView

### Removed
- Removed `removeBodyPadding` method from PrimaryCardView

## [D1-2.2.0] - 2019-01-03
### Fixed
- Removed ExpandingRowView animation on init

### Changed
- PrimaryCardView and HeadlineCardView can now show custom child views below the title

### Removed
- Removed the PrimaryInsetCardView, PrimaryButtonCardView, HeadlineInsetCardView and HeadlineButtonCardView organisms
- Removed the `body` parameters from the PrimaryCardView and HeadlineCardView models

## [D1-2.1.2] - 2019-01-02
### Fixed
- Fixed ExpandingRowView padding

## [D1-2.1.1] - 2018-12-21
### Fixed
- Transparent button was calling action block twice

## [D1-2.1.0] - 2018-12-21
### Added
- Add Switch Row component [NGC-4300]
- Add Summary Row component [NGC-4291]
- Add Container helper view [NGC-4363]

## [D1-2.0.1] - 2018-12-17
### Changed
- Fix validation of CurrencyInputView to only allow zero or two decimal places [NGC-4423]

## [D1-2.0.0] - 2018-12-13
### Added
- Add CurrencyInputView molecule [NGC-4186]

### Changed
- Organisms moved from Components to Components.Organisms
- H4TitleBodyView and H5TitleBodyView `subtitle` renamed to `body`
- HeadlineCardView `subtitle` renamed to `headline` and `detail` renamed to `body`
- Updated sample app placeholders and examples
- Removed margin from StatusView
- MultiColumnRowView single column now left aligned
- HeadlineButtonCardView and PrimaryButtonCardView now accept ButtonDescriptor parameter rather than buttonText string
- H4TitleBodyView, H5TitleBodyView, PrimaryCardView, PrimaryCardButtonView, PrimaryCardInsetView, StatusView, StatusCardView and StatusButtonCardView can now use attributed body text
- ExpandingRowComponent no longer reads container content automatically after expanding [NGC-4211]
- Ensure no uncommitted changes and on master when running `fastlane tag_release`
- Use closures instead of delegate to respond to changes within TextInputView molecule [NGC-4213]
- Improve accessibility of TextInputView molecule [NGC-4213]
- Increased spacing between elements in StatusView [NGC-4229]
- Replaced StatusView body UITextView with UILabel
- Changed colour of input text from red to black for error state
- Add decimal validation to CurrencyInputView [NGC-4186]

### Removed
- Removed unused setAsLink NSAttributedString extension

## [1.0.0] - 2018-11-27
Initial release!
