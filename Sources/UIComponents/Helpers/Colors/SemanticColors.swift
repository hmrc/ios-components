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
    var darkText: UIColor { get }
    var lightText: UIColor { get }
    var linkText: UIColor { get }
    var errorText: UIColor { get }
    var infoText: UIColor { get }
    var expandableButtonText: UIColor { get }
    var cardBackground: UIColor { get }
    var cardShadow: UIColor { get }
    var pageBackground: UIColor { get }
    var menuCardBackground: UIColor { get }
    var menuPageBackground: UIColor { get }
    var divider: UIColor { get }
    var insetBar: UIColor { get }
    var primaryButtonBackground: UIColor { get }
    var primaryButtonDisabledBackground: UIColor { get }
    var primaryButtonDisabledText: UIColor { get }
    var primaryButtonHighlightedBackground: UIColor { get }
    var primaryButtonText: UIColor { get }
    var primaryButtonHighlightedBaseline: UIColor { get }
    var primaryButtonBaseline: UIColor { get }
    var statusCardIconDefaultTint: UIColor { get }
    var switchTint: UIColor { get }
    var switchTintSelected: UIColor { get }
    var textInputBorder: UIColor { get }
    var textInputLeftViewTint: UIColor { get }
    var secondaryButtonText: UIColor { get }
    var secondaryButtonBackground: UIColor { get }
    var secondaryButtonHighlightedBackground: UIColor { get }
    var whiteBackground: UIColor { get }
}

public extension UIColor {
    struct SemanticLightColors: SemanticColors {
        
        public init() {}
        
        public var darkText = UIColor.Named.black.raw
        public var lightText = UIColor.Named.white.raw
        public var linkText = UIColor.Named.blue.raw
        public var errorText = UIColor.Named.red.raw
        public var infoText = UIColor.Named.grey1.raw
        public var expandableButtonText = UIColor.Named.blue.raw
        public var cardBackground = UIColor.Named.white.raw
        public var cardShadow = UIColor.Named.grey3.raw.darken(0.08)
        public var pageBackground = UIColor.Named.grey3.raw
        public var menuCardBackground = UIColor.Named.grey3.raw
        public var menuPageBackground = UIColor.Named.white.raw
        public var divider = UIColor.Named.grey2.raw
        public var insetBar = UIColor.Named.grey2.raw
        public var primaryButtonBackground = UIColor.Named.green1.raw
        public var primaryButtonDisabledBackground = UIColor.Named.grey1.raw
        public var primaryButtonDisabledText = UIColor.Named.white.raw
        public var primaryButtonHighlightedBackground = UIColor.Named.green1.raw.lighten(0.16)
        public var primaryButtonText = UIColor.Named.white.raw
        public var primaryButtonHighlightedBaseline = UIColor.Named.green1.raw.darken(0.24)
        public var primaryButtonBaseline = UIColor.Named.green1.raw.darken(0.4)
        public var statusCardIconDefaultTint = UIColor.Named.grey1.raw
        public var switchTint = UIColor.Named.blue.raw
        public var switchTintSelected = UIColor.Named.blue.raw.lighten(0.16)
        public var textInputBorder = UIColor.Named.grey1.raw
        public var textInputLeftViewTint = UIColor.Named.grey1.raw
        public var secondaryButtonText = UIColor.Named.blue.raw
        public var secondaryButtonBackground = UIColor.clear
        public var secondaryButtonHighlightedBackground = UIColor.Named.blue.raw.lighten(0.84)
        public var whiteBackground = UIColor.Named.white.raw
    }
    
    struct SemanticDarkColors: SemanticColors {
        
        public init() {}
        
        public var darkText = UIColor.Named.black.raw
        public var lightText = UIColor.Named.white.raw
        public var linkText = UIColor.Named.blue.raw
        public var errorText = UIColor.Named.red.raw
        public var infoText = UIColor.Named.grey1.raw
        public var expandableButtonText = UIColor.Named.blue.raw
        public var cardBackground = UIColor.Named.white.raw
        public var cardShadow = UIColor.clear
        public var pageBackground = UIColor.Named.grey3.raw
        public var menuCardBackground = UIColor.Named.grey3.raw
        public var menuPageBackground = UIColor.Named.white.raw
        public var divider = UIColor.Named.grey2.raw
        public var insetBar = UIColor.Named.grey2.raw
        public var primaryButtonBackground = UIColor.Named.green1.raw
        public var primaryButtonDisabledBackground = UIColor.Named.grey1.raw
        public var primaryButtonDisabledText = UIColor.Named.white.raw
        public var primaryButtonHighlightedBackground = UIColor.Named.green1.raw.lighten(0.16)
        public var primaryButtonText = UIColor.Named.white.raw
        public var primaryButtonHighlightedBaseline = UIColor.Named.green1.raw.darken(0.24)
        public var primaryButtonBaseline = UIColor.Named.green1.raw.darken(0.4)
        public var statusCardIconDefaultTint = UIColor.Named.grey1.raw
        public var switchTint = UIColor.Named.blue.raw
        public var switchTintSelected = UIColor.Named.blue.raw.lighten(0.16)
        public var textInputBorder = UIColor.Named.grey1.raw
        public var textInputLeftViewTint = UIColor.Named.grey1.raw
        public var secondaryButtonText = UIColor.Named.blue.raw
        public var secondaryButtonBackground = UIColor.clear
        public var secondaryButtonHighlightedBackground = UIColor.Named.blue.raw.darken(0.84)
        public var whiteBackground = UIColor.Named.grey3.raw
    }
}
