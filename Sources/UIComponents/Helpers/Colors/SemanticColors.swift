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

open class SemanticColors {

    public init() {}

    open var darkText: UIColor { UIColor.Named.black.raw }
    open var lightText: UIColor { UIColor.Named.white.raw }
    open var linkText: UIColor { UIColor.Named.blue.raw }
    open var errorText: UIColor { UIColor.Named.red.raw }
    open var infoText: UIColor { UIColor.Named.grey1.raw }
    open var expandableButtonText: UIColor { UIColor.Named.blue.raw }
    open var cardBackground: UIColor { UIColor.Named.white.raw }
    open var cardShadow: UIColor {
        UIColor.useLightModeColors ? UIColor(hexString: "#EC") : .clear
    }
    open var pageBackground: UIColor { UIColor.Named.grey3.raw }
    open var menuCardBackground: UIColor { UIColor.Named.grey3.raw }
    open var menuPageBackground: UIColor {
        UIColor.useLightModeColors ? UIColor.Named.white.raw : UIColor(hexString: "#262626")
    }
    open var divider: UIColor { UIColor.Named.grey2.raw }
    open var insetBar: UIColor { UIColor.Named.grey2.raw }
    open var primaryButtonBackground: UIColor { UIColor.Named.green1.raw }
    open var primaryButtonDisabledBackground: UIColor { UIColor.Named.grey1.raw }
    open var primaryButtonDisabledText: UIColor { UIColor.Named.white.raw }
    open var primaryButtonHighlightedBackground: UIColor { UIColor.Named.green2.raw }
    open var primaryButtonText: UIColor { UIColor.Named.white.raw }
    open var primaryButtonHighlightedBaseline: UIColor {
        UIColor.useLightModeColors ? UIColor(hexString: "#52856C") : .clear
    }
    open var primaryButtonBaseline: UIColor {
        UIColor.useLightModeColors ? UIColor(hexString: "#004C29") : .clear
    }
    open var statusCardIconDefaultTint: UIColor { UIColor.Named.grey1.raw }
    open var switchTint: UIColor { UIColor.Named.blue.raw }
    open var switchTintSelected: UIColor {
        UIColor.useLightModeColors ? UIColor(hexString: "#1862A2") : UIColor(hexString: "#6DD4D6")
    }
    open var textInputBorder: UIColor { UIColor.Named.grey1.raw }
    open var textInputLeftViewTint: UIColor { UIColor.Named.grey1.raw }
    open var transparentButtonHighlightedBackground: UIColor {
        UIColor.useLightModeColors ? UIColor(hexString: "#004C29") : .clear
    }
    open var secondaryButtonText: UIColor { UIColor.Named.blue.raw }
    open var secondaryButtonBackground: UIColor { UIColor.clear }
    open var secondaryButtonHighlightedBackground: UIColor { UIColor.clear }
    open var whiteBackground: UIColor {
        UIColor.useLightModeColors ? UIColor.Named.white.raw : UIColor(hexString: "#0A0B0B")
    }
}
