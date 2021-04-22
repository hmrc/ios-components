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

    open var darkText = UIColor.Named.black.raw
    open var lightText = UIColor.Named.white.raw
    open var linkText = UIColor.Named.blue.raw
    open var errorText = UIColor.Named.red.raw
    open var infoText = UIColor.Named.grey1.raw
    open var expandableButtonText = UIColor.Named.blue.raw
    open var cardBackground = UIColor.Named.white.raw
    open var cardShadow = UIColor.useLightModeColors ? UIColor(hexString: "#ECECEC") : .clear
    open var pageBackground = UIColor.Named.grey3.raw
    open var menuCardBackground = UIColor.Named.grey3.raw
    open var menuPageBackground: UIColor = UIColor.Named.white.raw
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
    open var secondaryButtonHighlightedBackground = UIColor.useLightModeColors
        ? UIColor.Named.blue.raw.lighten(0.84)
        : UIColor.Named.blue.raw.darken(0.84)
    open var whiteBackground = UIColor.useLightModeColors
        ? UIColor.Named.white.raw
        : UIColor.Named.grey3.raw
}
