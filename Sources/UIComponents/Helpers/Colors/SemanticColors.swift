/*
 * Copyright 2021 HM Revenue & Customs
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit

private typealias Primary = UIColor.Palette.Primary
private typealias DarkMode = UIColor.Palette.DarkMode

public protocol SemanticColors {
    var darkText: UIColor { get set }
    var lightText: UIColor { get set }
    var linkText: UIColor { get set }
    var errorText: UIColor { get set }
    var infoText: UIColor { get set }
    var expandableButtonText: UIColor { get set }
    var cardBackground: UIColor { get set }
    var cardShadow: UIColor { get set }
    var pageBackground: UIColor { get set }
    var menuCardBackground: UIColor { get set }
    var menuPageBackground: UIColor { get set }
    var divider: UIColor { get set }
    var insetBar: UIColor { get set }
    var primaryButtonBackground: UIColor { get set }
    var primaryButtonDisabledBackground: UIColor { get set }
    var primaryButtonDisabledText: UIColor { get set }
    var primaryButtonHighlightedBackground: UIColor { get set }
    var primaryButtonText: UIColor { get set }
    var primaryButtonHighlightedBaseline: UIColor { get set }
    var primaryButtonBaseline: UIColor { get set }
    var statusCardIconDefaultTint: UIColor { get set }
    var switchTint: UIColor { get set }
    var switchTintSelected: UIColor { get set }
    var switchBorder: UIColor { get set }
    var textInputBorder: UIColor { get set }
    var textInputLeftViewTint: UIColor { get set }
    var secondaryButtonText: UIColor { get set }
    var secondaryButtonBackground: UIColor { get set }
    var secondaryButtonHighlightedBackground: UIColor { get set }
    var whiteBackground: UIColor { get set }
    var textInputClearButtonTint: UIColor { get set }
    var infoMessageWarningBackground: UIColor { get set }
}

public extension SemanticColors {
    var switchBorder: UIColor {
        get { Primary.midGrey.uiColour }
        set {} // swiftlint:disable:this unused_setter_value
    }

    var infoMessageWarningBackground: UIColor {
        get { UIColor(dark: DarkMode.yellowDark, light: Primary.yellowLight) }
        set {} // swiftlint:disable:this unused_setter_value
    }
}

extension UIColor {
    open class SemanticColors: UIComponents.SemanticColors {
        
        public init() {}
        
        open var darkText = UIColor(dark: Primary.white, light: Primary.black)
        open var lightText = UIColor(dark: DarkMode.whiteDark, light: Primary.white)
        open var linkText = UIColor(dark: Primary.teal, light: Primary.blue)
        open var errorText = UIColor(dark: DarkMode.primaryRed, light: Primary.red)
        open var infoText = UIColor(dark: Primary.midGrey, light: Primary.darkGrey)
        open var expandableButtonText = UIColor(dark: Primary.teal, light: Primary.blue)
        open var cardBackground = UIColor(dark: DarkMode.darkNavy3, light: Primary.white)
        open var cardShadow = UIColor(darkColour: .clear, lightColour: Primary.lightGrey.uiColour.darken(0.08))
        open var pageBackground = UIColor(dark: DarkMode.darkNavy2, light: Primary.lightGrey)
        open var menuCardBackground = UIColor(dark: Primary.black, light: Primary.lightGrey)
        open var menuPageBackground = UIColor(dark: DarkMode.whiteDark, light: Primary.white)
        open var divider = Primary.midGrey.uiColour
        open var insetBar = Primary.midGrey.uiColour
        open var primaryButtonBackground = UIColor(dark: DarkMode.primaryGreen, light: Primary.green)
        open var primaryButtonDisabledBackground = UIColor(dark: Primary.midGrey, light: Primary.darkGrey)
        open var primaryButtonDisabledText = UIColor(dark: DarkMode.whiteDark, light: Primary.white)
        open var primaryButtonHighlightedBackground = UIColor(
            darkColour: DarkMode.primaryGreen.uiColour.lighten(0.16),
            lightColour: Primary.green.uiColour.lighten(0.16)
        )
        open var primaryButtonText = Primary.white.uiColour
        open var primaryButtonHighlightedBaseline = UIColor(
            darkColour: DarkMode.primaryGreen.uiColour.darken(0.24),
            lightColour: Primary.green.uiColour.darken(0.24)
        )
        open var primaryButtonBaseline = UIColor(
            darkColour: DarkMode.primaryGreen.uiColour.darken(0.4),
            lightColour: Primary.green.uiColour.darken(0.4)
        )
        open var statusCardIconDefaultTint = UIColor(dark: Primary.midGrey, light: Primary.darkGrey)
        open var switchTint = UIColor(dark: Primary.teal, light: Primary.blue)
        open var switchTintSelected = UIColor(
            darkColour: Primary.teal.uiColour.lighten(0.16),
            lightColour: Primary.blue.uiColour.lighten(0.16)
        )
        open var switchBorder = Primary.midGrey.uiColour
        open var textInputBorder = UIColor(dark: Primary.white, light: Primary.darkGrey)
        open var textInputLeftViewTint = UIColor(dark: Primary.white, light: Primary.darkGrey)
        open var secondaryButtonText = UIColor(dark: Primary.white, light: Primary.blue)
        open var secondaryButtonBackground = UIColor.clear
        open var secondaryButtonHighlightedBackground = UIColor(
            darkColour: Primary.midGrey.uiColour.darken(0.4),
            lightColour: Primary.blue.uiColour.lighten(0.84)
        )
        open var whiteBackground = UIColor(dark: Primary.black, light: Primary.white)
        open var textInputClearButtonTint = UIColor(dark: Primary.midGrey, light: Primary.darkGrey)
        open var infoMessageWarningBackground = UIColor(dark: DarkMode.yellowDark, light: Primary.yellowLight)
    }
}
