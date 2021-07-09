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

extension UIColor {
    open class SemanticLightColors: SemanticColors {
        
        public init() {}
        
        open var darkText = UIColor.Named.black.raw
        open var lightText = UIColor.Named.white.raw
        open var linkText = UIColor.Named.blue.raw
        open var errorText = UIColor.Named.red.raw
        open var infoText = UIColor.Named.grey1.raw
        open var expandableButtonText = UIColor.Named.blue.raw
        open var cardBackground = UIColor.Named.white.raw
        open var cardShadow = UIColor.Named.grey3.raw.darken(0.08)
        open var pageBackground = UIColor.Named.grey3.raw
        open var menuCardBackground = UIColor.Named.grey3.raw
        open var menuPageBackground = UIColor.Named.white.raw
        open var divider = UIColor.Named.grey2.raw
        open var insetBar = UIColor.Named.grey2.raw
        open var primaryButtonBackground = UIColor.Named.green1.raw
        open var primaryButtonDisabledBackground = UIColor.Named.grey1.raw
        open var primaryButtonDisabledText = UIColor.Named.white.raw
        open var primaryButtonHighlightedBackground = UIColor.Named.green1.raw.lighten(0.16)
        open var primaryButtonText = UIColor.Named.white.raw
        open var primaryButtonHighlightedBaseline = UIColor.Named.green1.raw.darken(0.24)
        open var primaryButtonBaseline = UIColor.Named.green1.raw.darken(0.4)
        open var statusCardIconDefaultTint = UIColor.Named.grey1.raw
        open var switchTint = UIColor.Named.blue.raw
        open var switchTintSelected = UIColor.Named.blue.raw.lighten(0.16)
        open var textInputBorder = UIColor.Named.grey1.raw
        open var textInputLeftViewTint = UIColor.Named.grey1.raw
        open var secondaryButtonText = UIColor.Named.blue.raw
        open var secondaryButtonBackground = UIColor.clear
        open var secondaryButtonHighlightedBackground = UIColor.Named.blue.raw.lighten(0.84)
        open var whiteBackground = UIColor.Named.white.raw
    }
    
    open class SemanticDarkColors: SemanticColors {
        
        public init() {}
        
        open var darkText = UIColor.Named.black.raw
        open var lightText = UIColor.Named.white.raw
        open var linkText = UIColor.Named.blue.raw
        open var errorText = UIColor.Named.red.raw
        open var infoText = UIColor.Named.grey1.raw
        open var expandableButtonText = UIColor.Named.blue.raw
        open var cardBackground = UIColor.Named.white.raw
        open var cardShadow = UIColor.clear
        open var pageBackground = UIColor.Named.grey3.raw
        open var menuCardBackground = UIColor.Named.grey3.raw
        open var menuPageBackground = UIColor.Named.white.raw
        open var divider = UIColor.Named.grey2.raw
        open var insetBar = UIColor.Named.grey2.raw
        open var primaryButtonBackground = UIColor.Named.green1.raw
        open var primaryButtonDisabledBackground = UIColor.Named.grey1.raw
        open var primaryButtonDisabledText = UIColor.Named.white.raw
        open var primaryButtonHighlightedBackground = UIColor.Named.green1.raw.lighten(0.16)
        open var primaryButtonText = UIColor.Named.white.raw
        open var primaryButtonHighlightedBaseline = UIColor.Named.green1.raw.darken(0.24)
        open var primaryButtonBaseline = UIColor.Named.green1.raw.darken(0.4)
        open var statusCardIconDefaultTint = UIColor.Named.grey1.raw
        open var switchTint = UIColor.Named.blue.raw
        open var switchTintSelected = UIColor.Named.blue.raw.lighten(0.16)
        open var textInputBorder = UIColor.Named.grey1.raw
        open var textInputLeftViewTint = UIColor.Named.grey1.raw
        open var secondaryButtonText = UIColor.Named.blue.raw
        open var secondaryButtonBackground = UIColor.clear
        open var secondaryButtonHighlightedBackground = UIColor.Named.blue.raw.darken(0.84)
        open var whiteBackground = UIColor.Named.grey3.raw
    }
}
