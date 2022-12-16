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
    var textInputBorder: UIColor { get set }
    var textInputLeftViewTint: UIColor { get set }
    var secondaryButtonText: UIColor { get set }
    var secondaryButtonBackground: UIColor { get set }
    var secondaryButtonHighlightedBackground: UIColor { get set }
    var whiteBackground: UIColor { get set }
    var textInputClearButtonTint: UIColor { get set }
}

extension UIColor {
    open class SemanticColors: UIComponents.SemanticColors {
        
        public init() {}
        
        open var darkText = UIColor(darkColour: UIColor.Named.black.colour, lightColour: UIColor.Named.black.colour)
        open var lightText = UIColor(darkColour: UIColor.Named.white.colour, lightColour: UIColor.Named.white.colour)
        open var linkText = UIColor(darkColour: UIColor.Named.blue.colour, lightColour: UIColor.Named.blue.colour)
        open var errorText = UIColor(darkColour: UIColor.Named.red.colour, lightColour: UIColor.Named.red.colour)
        open var infoText = UIColor(darkColour:  UIColor.Named.grey1.colour, lightColour: UIColor.Named.grey1.colour)
        open var expandableButtonText = UIColor(darkColour: UIColor.Named.blue.colour, lightColour: UIColor.Named.blue.colour)
        open var cardBackground = UIColor(darkColour: UIColor.Named.white.colour, lightColour: UIColor.Named.white.colour)
        open var cardShadow = UIColor(darkColour: UIColor.clear, lightColour: UIColor.Named.grey3.colour.darken(0.08))
        open var pageBackground = UIColor(darkColour: UIColor.Named.grey3.colour, lightColour: UIColor.Named.grey3.colour)
        
        
        open var menuCardBackground = UIColor(darkColour: UIColor.Named.grey3.colour, lightColour: UIColor.Named.grey3.colour)
        open var menuPageBackground = UIColor(darkColour: UIColor.Named.white.colour, lightColour: UIColor.Named.white.colour)
        open var divider = UIColor(darkColour: UIColor.Named.grey2.colour, lightColour: UIColor.Named.grey2.colour)
        open var insetBar = UIColor(darkColour: UIColor.Named.grey2.colour, lightColour: UIColor.Named.grey2.colour)
        open var primaryButtonBackground = UIColor(darkColour: UIColor.Named.green1.colour, lightColour: UIColor.Named.green1.colour)
        open var primaryButtonDisabledBackground = UIColor(darkColour: UIColor.Named.grey1.colour, lightColour: UIColor.Named.grey1.colour)
        
        open var primaryButtonDisabledText = UIColor(darkColour: UIColor.Named.white.colour, lightColour: UIColor.Named.white.colour)
        open var primaryButtonHighlightedBackground = UIColor(darkColour: UIColor.Named.green1.colour.lighten(0.16), lightColour: UIColor.Named.green1.colour.lighten(0.16))
        open var primaryButtonText = UIColor(darkColour: UIColor.Named.white.colour, lightColour: UIColor.Named.white.colour)
        
        open var primaryButtonHighlightedBaseline = UIColor(darkColour: UIColor.Named.green1.colour.darken(0.24), lightColour: UIColor.Named.green1.colour.darken(0.24))
        open var primaryButtonBaseline = UIColor(darkColour: UIColor.Named.green1.colour.darken(0.4), lightColour: UIColor.Named.green1.colour.darken(0.4))
        open var statusCardIconDefaultTint = UIColor(darkColour: UIColor.Named.grey1.colour, lightColour: UIColor.Named.grey1.colour)
        
        
        open var switchTint = UIColor(darkColour: UIColor.Named.blue.colour, lightColour: UIColor.Named.blue.colour)
        open var switchTintSelected = UIColor(darkColour: UIColor.Named.blue.colour.lighten(0.16), lightColour: UIColor.Named.blue.colour.lighten(0.16))
        open var textInputBorder = UIColor(darkColour: UIColor.Named.grey1.colour, lightColour: UIColor.Named.grey1.colour)
        open var textInputLeftViewTint = UIColor(darkColour: UIColor.Named.grey1.colour, lightColour: UIColor.Named.grey1.colour)
        open var secondaryButtonText = UIColor(darkColour: UIColor.Named.blue.colour, lightColour: UIColor.Named.blue.colour)
        open var secondaryButtonBackground = UIColor(darkColour: UIColor.clear, lightColour: UIColor.clear)
        open var secondaryButtonHighlightedBackground = UIColor(darkColour: UIColor.white.withAlphaComponent(0.4), lightColour: UIColor.Named.blue.colour.lighten(0.84))
        open var whiteBackground = UIColor(darkColour: UIColor.Named.grey3.colour, lightColour: UIColor.Named.white.colour)
        open var textInputClearButtonTint = UIColor(darkColour: UIColor.Named.grey1.colour, lightColour: UIColor.Named.grey1.colour)
    }
}
