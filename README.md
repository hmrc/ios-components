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

# Usage

## Atoms

### UIButton

#### Primary

  

```swift
UIButton.buildPrimaryButton(string: "Primary Button") {
	// Set other button properties by accessing $0
}
```

  

#### Disabled Primary

  

```swift
UIButton.buildPrimaryButton(string: "Disabled Primary Button", enabled: false) {
	// Set other button properties by accessing $0
}
```

  

#### Secondary

  

```swift
UIButton.buildSecondaryButton(string: "Secondary Button") {
	// Set other button properties by accessing $0
}
```

  

### UILabel
The label builder automatically set the following:
```swift
adjustsFontForContentSizeCategory = true
numberOfLines = 0
lineBreakMode = .byWordWrapping
```
They can be overridden within the closure of the label by accessing `$0`

For `H3`, `H4` and `H5` the labels are created with `accessibilityTraits = .header`
  

#### H3 

```swift
UILabel.buildH3Label {
	$0.text = "H3 Text"
}
```

#### H4

```swift
UILabel.buildH4Label {
	$0.text = "H4 Text"
}
```

  

#### H5

```swift
UILabel.buildH5Label {
	$0.text = "H5 Text"
}
```

#### Bold

```swift
UILabel.buildBoldLabel {
	$0.text = "Bold Text"
}
```

#### Body

```swift
UILabel.buildBodyLabel {
	$0.text = "Body Text"
}
```

#### Info

```swift
UILabel.buildInfoLabel {
	$0.text = "Info Text"
}
```

#### Link

```swift
UILabel.buildLinkLabel {
	$0.text = "Link Text"
}
```

#### Error

```swift
UILabel.buildErrorLabel {
	$0.text = "Error Text"
}
```

#### Bulleted

```swift
Components.Atoms.BulletLabelView(text: "bulleted text")
```

### NSMutableAttributedString
- [ ] Convert to use the new builder pattern

#### H3

```swift
NSMutableAttributedString.styled(.H3, string: "H3 Text")
```

#### H4

```swift
NSMutableAttributedString.styled(.H4, string: "H4 Text")
```

#### H5

```swift
NSMutableAttributedString.styled(.H5, string: "H5 Text")
```

#### Bold

```swift
NSMutableAttributedString.styled(.bold, string: "Bold Text")
```

#### Body

```swift
NSMutableAttributedString.styled(.body, string: "Body Text")
```

#### Info

```swift
NSMutableAttributedString.styled(.info, string: "Info Text")
```

#### Link

```swift
NSMutableAttributedString.styled(.link, string: "Link Text")
```

#### Error

```swift
NSMutableAttributedString.styled(.error, string: "Error Text")
```

## Molecules

### Text Input View

```swift
let model = Components.Molecules.TextInputView.Model("Enter text", leftViewText: nil, initialText: "Some Text", maxLength: 0))
let textInputView = Components.Molecules.TextInputView(frame: frame)
textInputView.updateUI(for: model)
```

To set a validation error message:

```swift
textInputView.set(validationError: "Validation Error")
```

To respond to changes:

```swift
textInputView.didChangeInput = {
    // do something
}

textInputView.didEndInput = {
    // do something
}

textInputView.didClearInput = {
    // do something
}

nameInputView.didTapReturn = {
    // do something
}
```

To set a validation error message:

```swift
textInputView.set(validationError: "Validation Error")
```

To disable enforcement of max length:

```swift
textInputView.enforceMaxLength = false
```


### Currency Input View

```swift
let model = Components.Molecules.CurrencyInputView.Model(title: "Title", initialText: "InitialText", maxLength: 5))
let currencyInputView = Components.Molecules.CurrencyInputView(frame: frame)
currencyInputView.updateUI(for: model)
```


### H4 Title Body View

```swift
let view = Components.Molecules.H4TitleBodyView(title: "Title", body: "Body")
```

### H5 Title Body View

```swift
let view = Components.Molecules.H5TitleBodyView(title: "Title", body: "Body")
```

### Bold Title Body View

```swift
let view = Components.Molecules.BoldTitleBodyView(title: "Title", body: "Body")
```

### Inset View

```swift
let view = Components.Molecules.InsetView(text: "Inset Text") // text can also be NSAttributedString
```

### Multi Column Row View

This component can display a row with one, two or three equally distributed columns. Using the optional attributes array it is possible to individually apply styling, hugging layout priority and the ability to copy the column text

```swift
let view = Components.Molecules.MultiColumnRowView(
    labels: ["Text 1", "Text 2", "Text 3"],
    style: .body
)
```
```swift    
let view = Components.Molecules.MultiColumnRowView(
    labels: ["Text 1", "Text 2"],
    attributes: [
        LabelColumn(style: .body, canCopy: false, huggingPriority: .required),
        LabelColumn(style: .bold, canCopy: true, huggingPriority: .defaultHigh)
    ]
)
```

### Switch Row View

```swift
let view = Components.Molecules.SwitchRowView(
    model: .init(
        title: "Title",
        body: "Body. Switch: off", // optional
        isOn: false
    )
)
view.valueChanged = { isOn in
    print("Switch is: " + isOn ? "on" : "off")
}
return view
```

### Icon Button View

```swift
let view = Components.Molecules.IconButtonView(
    title: "Title",
    icon: UIImage(named: "icon")
)
view.didTapButton = { _ in
    // do something
}
```

### Status View

```swift
let view = Components.Molecules.StatusView(
    model: .init(
        icon: UIImage(named: "icon"),
        title: "Title",
        body: "Body", // body can also be NSAttributedString
    )
)
```

### Warning View

```swift
let view = Components.Molecules.WarningView(
    model: .init(
        text: "Warning Text"
    )
)
```

### Tab Bar View
A segmented control like controller - takes an array of `Segments` and a `theme`, each segment has a closure action which is performed on item tab.
Has an optional parameter `startsSelected` which defaults to false.

#### Accessibility
Uses default button accessibility traits with a label of "segment_title, position_of_segment of number_of_segments"

#### Example Usage
```swift
let tabBarView = Components.Molecules.TabBarView(
    model: .init(
        segments: [
            .init(title: "title 1", startsSelected: true) { },
            .init(title: "title 2") { },
        ],
        theme: .dark / .light
    )
)
```

### Select Row View
Adds a radio button type component

#### Accessibility
Reads 'Selected / Not selected, body_text, radio button' for VO

#### Example usage
```swift
let selectRowView = Components.Molecules.SelectRowView(
    model: .init(
        isSelected: true, (defaults to false)
        body: "body text",
        selectedImage: UIImage(), (defaults to nil, if nil will use tick)
        deselectedImage: UIImage() (defaults to nil, if nil will use circle)
    )
)
selectRowView.tapHandler = {  } // Not required
```

```swift
let selectRowView = Components.Molecules.SelectRowView(
    model: .init(
        rows: [
            .init(isSelected: true, body: "Option 1"),
            .init(body: "Option 2")
        ]
    )
)
selectRowView.tapHandler = {  } // Not required            
```
### Select Row Group View
Group an array of `Select Row View` components along with a title, subTitle and validation label

#### Example usage

```swift
let selectRowGroupView = Components.Molecules.SelectRowGroupView(
    title: "Can we collect analytics data when you use this app?",
    subTitle: "",
    rowContent: [
        .init(label: "yes", accessibilityIdentifier: "RadioButtonYes"),
        .init(label: "no", accessibilityIdentifier: "RadioButtonNo")
    ],
    selectedIndex: 0
)
```
```swift
let selectRowGroupView2 = Components.Molecules.SelectRowGroupView(
    title: "Are you moving goods?",
    subTitle: "",
    rowContent: [
        .init(label: "yes", accessibilityIdentifier: "RadioButtonYes"),
        .init(label: "no", accessibilityIdentifier: "RadioButtonNo")
    ],
    selectedIndex: nil
)
selectRowGroupView2.set(validationError: "You must select yes or no")
```

## Organisms

### Headline Card View

```swift 
let view = Components.Organisms.HeadlineCardView(
    model: .init(
        title: "Title",
        headline: "Headline",       // Can be String or NSAttributedString
        views: [] // list of child views to display below headline
    )
)
```

Padding can be removed from child views using the `removePadding(onViews:)` method.

### Primary Card View

```swift
let view = Components.Organisms.PrimaryCardView(
    model: .init(
        title: "Title",
        views: [] // list of child views to display below headline
    )
)
```

Padding can be removed from child views using the `removePadding(onViews:)` method.

### Expanding Row View

```swift
let component = Components.Organisms.ExpandingRowView(
    model: .init(
        title: "Title",
        subtitle: "Subtitle",
        icon: UIImage(named: "icon"),
        expandedView: expandedView,
        shouldAnimateExpansion: true|false // Optional: default is true
    )
)
```

### Status Card View

```swift
let view = Components.StatusCardView(
    model: .init(
        icon: UIImage(named: "icon"),
        title: "Title",
        body: "Body" // body can also be NSAttributedString,
        buttonModel: .init(
            title: "Button Title", 
            actionBlock: { _ in
                handler()
            }),
        views: [UIView(), UIButton()],
        journeyId: "121212-343434-565656-787878"
    )
)
```

### Status Button Card View

```swift
let buttonDescriptor = ButtonDescriptor(
    style: .primary(true),
    visible: true,
    title: "Button",
    alignment: .center
)
let view = Components.StatusButtonCardView(
    model: .init(
        icon: UIImage(named: "icon"),
        title: "Title",
        body: "Body", // body can also be NSAttributedString
        buttonDescriptor: buttonDescriptor
    )
)
view.didTapButton = { _ in
    // do something
}
```

### Icon Button Card View

```swift
let view = Components.Organisms.IconButtonCardView(
    model: .init(
        title: "Title",
        icon: UIImage(named: "icon")
    )
)
view.didTapButton = { _ in
    // do something
}
```

### Information Message Card
- Headline takes an optional CTA array. If this is not nil then `BodyContent` is NOT rendered. 
If this is nil then `BodyContent` is rendered below the main `InformationMessge`

```swift
Components.Organisms.InformationMessageCard(
    model: .init(
            id: "",
            theme: .info,
            icon: UIImage(named: "warning")!,
            headline: .init(
                title: "Placeholder",
                ctas: [ .init(
                    message: "CTA Message",
                    link: "",
                    accessibilityIdentifier: "",
                    linkType: .normal,
                    displayType: .primary
                )]
            ),
            bodyContent: nil
        )
    )
```

### Summary Row View
- A tappable component that can display a vertical stack of Multi Column Row Views.
- Has an optional icon property that appears on the leading side of the view.

If the component is used in a list of similar items (e.g. news articles) it is possible to suffix the accessibilityLabel with the item row index and count using the `suffixAccessibilityLabel` method.

#### Accessibility
Exposes `readerTrait` property that changes the way the component interacts with the screen reader.

- `info` - Specifies that the row will be read out element by element when read by screen reader. This is the default trait.

- `simple` - Specifies that the row will be read out as one element by screen reader.

#### Example usage

```swift
let model = Components.Organisms.SummaryRowView.Model(
    title: "Title",
    rowViews: [
        Components.Molecules.MultiColumnRowView(labels: ["Text 1", "Text 2", "Text 3"], style: .info)
    ]
)
//OR
let model = Components.Organisms.SummaryRowView.Model(
    title: "Title",
    rowViews: [
        Components.Molecules.MultiColumnRowView(labels: ["Text 1", "Text 2", "Text 3"], style: .info)
    ],
    icon: UIImage(named: "warning")
)

let view = Components.Organisms.SummaryRowView(model: model)
view.action = {
    // do something
}

view.suppressDisclosureView = true // completely hides disclosure view allowing row content to fill full width

view.setReader(trait: .info)
//OR
view.setReader(trait: .simple)
//OR
view.setReader(trait: .menu)

```
## Helper Methods

### String.buildStackViewFromParagraphs() -> UIStackView

A string extension method which, ideally, takes a multiline string and returns a `UIStackView` containing a mixture of `UILabel` and `Components.Atoms.BulletLabelView`. 

This is benificial for VoiceOver as each paragraph becomes read out individually instead of one large block.

Default `UIStackView` properties:
```swift
axis = .vertical
spacing = .spacer8
```

## Helper Views

### Icon Button With Disclosure
- A tappable component that has:
    - An optional leading icon with customisable tint color
    - Title text with customisable tint color
    - A chevron discolure icon with customisable tint color
    - Customisable insets
    - Customisable selected background color
```swift
let buttonWithDisclosure = IconButtonWithDisclosure(
    model: .init(
        title: "Title",
        icon: UIImage(named: "icon"),
        textColor: UIColor.black,
        iconColor: UIColor.blue,
        disclosureColor: UIColor.darkGrey,
        customSelectedStateColor: UIColor.white,
        buttonContentInsets: .init(padding: 4.0)
    )
)
```

## Semantic Colours
| Name | Light Mode | Dark Mode | Usage |
| ------- | ------- | ------- | ------- |
| Card Background |![#FFFFFF](https://placehold.it/15/FFFFFF/000000?text=+)|![#252525](https://placehold.it/15/252525/000000?text=+)| UIColor.Semantic.cardBackground.raw
| Card Shadow |![#B0B4B6](https://placehold.it/15/B0B4B6/000000?text=+)|![#FFFFFF](https://placehold.it/15/FFFFFF/000000?text=+)| UIColor.Semantic.cardShadow.raw
| Dark Text |![#0A0D0D](https://placehold.it/15/0A0D0D/000000?text=+)|![#FFFFFF](https://placehold.it/15/FFFFFF/000000?text=+)| UIColor.Semantic.darkText.raw
| Divider |![#B0B4B6](https://placehold.it/15/B0B4B6/000000?text=+)|![#6F777A](https://placehold.it/15/6F777A/000000?text=+)| UIColor.Semantic.divider.raw
| Error Text |![#D4351C](https://placehold.it/15/D4351C/000000?text=+)|![#EB67CA](https://placehold.it/15/EB67CA/000000?text=+)| UIColor.Semantic.errorText.raw
| Expandable Button Text |![#2C70B8](https://placehold.it/15/2C70B8/000000?text=+)|![#5BC0C6](https://placehold.it/15/5BC0C6/000000?text=+) | UIColor.Semantic.expandableButtonText.raw
| Information Text |![#6F777B](https://placehold.it/15/6F777B/000000?text=+)|![#B1B4B6](https://placehold.it/15/B1B4B6/000000?text=+)| UIColor.Semantic.infoText.raw
| Inset Text |![#B1B4B6](https://placehold.it/15/B1B4B6/000000?text=+)|![#6F777B](https://placehold.it/15/6F777B/000000?text=+)| UIColor.Semantic.insetText.raw
| Light Text |![#FFFFFF](https://placehold.it/15/FFFFFF/000000?text=+)|![#0B0C0C](https://placehold.it/15/0B0C0C/000000?text=+)| UIColor.Semantic.lightText.raw
| Link Text |![#2C70B8](https://placehold.it/15/2C70B8/000000?text=+)|![#5BC0C6](https://placehold.it/15/5BC0C6/000000?text=+) | UIColor.Semantic.linkText.raw
| Page Background |![#F3F2F1](https://placehold.it/15/F3F2F1/000000?text=+)|![#0B0C0C](https://placehold.it/15/0B0C0C/000000?text=+)| UIColor.Semantic.pageBackground.raw
| Primary Button Background |![#24703C](https://placehold.it/15/24703C/000000?text=+)| Clear | UIColor.Semantic.primaryButtonBackground.raw
| Primary Button Baseline |![#00703C](https://placehold.it/15/00703C/000000?text=+)|![#69B134](https://placehold.it/15/69B134/000000?text=+)| UIColor.Semantic.primaryButtonBaseline.raw
| Primary Button Disabled Background |![#6F777B](https://placehold.it/15/6F777B/000000?text=+)|![#B1B4B6](https://placehold.it/15/B1B4B6/000000?text=+)| UIColor.Semantic.primaryButtonDisableBackground.raw
| Primary Button Disabled Text |![#FFFFFF](https://placehold.it/15/0B0C0C/000000?text=+)|![#0B0C0C](https://placehold.it/15/0B0C0C/000000?text=+)| UIColor.Semantic.primaryButtonDisableText.raw
| Primary Button Highlighted Background |![#529D7A](https://placehold.it/15/529D7A/000000?text=+)|![#69B134](https://placehold.it/15/69B134/000000?text=+) 68% | UIColor.Semantic.primaryButtonHighlightedBackground.raw
| Primary Button Highlighted Baseline |![#52856D](https://placehold.it/15/52856D/000000?text=+)| Clear | UIColor.Semantic.primaryButtonHighlightedBaseline.raw
| Primary Button Text |![#FFFFFF](https://placehold.it/15/FFFFFF/000000?text=+)|![#0B0C0C](https://placehold.it/15/0B0C0C/000000?text=+)| UIColor.Semantic.primaryButtonText.raw
| Secondary Button Background |![#FFFFFF](https://placehold.it/15/FFFFFF/000000?text=+)|![#FFFFFF](https://placehold.it/15/FFFFFF/000000?text=+)| UIColor.Semantic.secondaryButtonBackground.raw
| Secondary Button Text |![#2C70B8](https://placehold.it/15/2C70B8/000000?text=+)|![#5BC0C6](https://placehold.it/15/5BC0C6/000000?text=+)| UIColor.Semantic.secondaryButtonText.raw
| Status Card Icon Default Tint |![#6F777B](https://placehold.it/15/6F777B/000000?text=+)|![#B1B4B6](https://placehold.it/15/B1B4B6/000000?text=+)| UIColor.Semantic.statusCardIconDefaultTint.raw
| Switch Tint |![#2C70B8](https://placehold.it/15/2C70B8/000000?text=+)|![#5BC0C6](https://placehold.it/15/5BC0C6/000000?text=+)| UIColor.Semantic.switchTint.raw
| Text Input Border |![#6F777B](https://placehold.it/15/6F777B/000000?text=+)|![#B1B4B6](https://placehold.it/15/B1B4B6/000000?text=+)| UIColor.Semantic.textInputBorder.raw
| Text Input Left View Tint |![#6F777B](https://placehold.it/15/6F777B/000000?text=+)|![#B1B4B6](https://placehold.it/15/B1B4B6/000000?text=+)| UIColor.Semantic.textInputLeftViewTint.raw
| Transparent Button Highlighted Background |![#EAEAEA](https://placehold.it/15/EAEAEA/000000?text=+)|![#EAEAEA](https://placehold.it/15/EAEAEA/000000?text=+)| UIColor.Semantic.transparentButtonHighlightedBackground.raw
| White Background |![#FFFFFF](https://placehold.it/15/FFFFFF/000000?text=+)|![#0B0C0C](https://placehold.it/15/0B0C0C/000000?text=+)| UIColor.Semantic.whiteBackground.raw

## Named Colours
| Name | Light Colour | Dark Colour | Usage |
| ------- | ------- | ------- | ------- |
| Black | ![#0B0C0C](https://placehold.it/15/0B0C0C/000000?text=+) | ![#0B0C0C](https://placehold.it/15/0B0C0C/000000?text=+) | UIColor.Named.black.raw |
| White| ![#FFFFFF](https://placehold.it/15/FFFFFF/000000?text=+) | ![#FFFFFF](https://placehold.it/15/FFFFFF/000000?text=+) | UIColor.Named.white.raw |
| Teal | ![#3AA196](https://placehold.it/15/3AA196/000000?text=+) | ![#3AA196](https://placehold.it/15/3AA196/000000?text=+) | UIColor.Named.teal.raw |
| Pink | ![#CA2B75](https://placehold.it/15/CA2B75/000000?text=+) | ![#BB94FF](https://placehold.it/15/BB94FF/000000?text=+) | UIColor.Named.pink.raw |
| Yellow | ![#FFDD00](https://placehold.it/15/FFDD00/000000?text=+) | ![#FDFF4E](https://placehold.it/15/FDFF4E/000000?text=+) | UIColor.Named.yellow.raw |

## Spacing

| Spacing  | Usage |
| ------- | ----- |
| 4 | CGFloat.spacer4 |
| 8 | CGFloat.spacer8 |
| 16 | CGFloat.spacer16 |
| 24 | CGFloat.spacer24 |
| 48 | CGFloat.spacer48 |

## Debug Overlays
Debug overlays for all components can be made visible by setting `Components.Debug.showOverlay` to true.

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
