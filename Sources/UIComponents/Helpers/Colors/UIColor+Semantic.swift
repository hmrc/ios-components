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

extension UIColor {
    open class Semantic {
        public static var allColors: [(String, UIColor)] {
            var result: [(String, UIColor)] = []
            let mirror = Mirror(reflecting: semanticColors)
            for (property, value) in mirror.children {
                guard let property = property, let value = value as? UIColor else {
                    continue
                }
                result.append((property, value))
            }
            return result
        }
        
        private static var semanticColors: UIComponents.SemanticColors {
            let colorService: ColorService = UIComponents.Components.Injection.Service.colorService.injectedObject
            
            return colorService.semanticColors
        }
        
        public static var darkText = semanticColors.darkText
        public static var lightText = semanticColors.lightText
        public static var linkText = semanticColors.linkText
        public static var errorText = semanticColors.errorText
        public static var infoText = semanticColors.infoText
        public static var expandableButtonText = semanticColors.expandableButtonText
        public static var cardBackground = semanticColors.cardBackground
        public static var cardShadow = semanticColors.cardShadow
        public static var pageBackground = semanticColors.pageBackground
        public static var menuCardBackground = semanticColors.menuCardBackground
        public static var menuPageBackground = semanticColors.menuPageBackground
        public static var divider = semanticColors.divider
        public static var insetBar = semanticColors.insetBar
        public static var primaryButtonBackground = semanticColors.primaryButtonBackground
        public static var primaryButtonDisabledBackground = semanticColors.primaryButtonDisabledBackground
        public static var primaryButtonDisabledText = semanticColors.primaryButtonDisabledText
        public static var primaryButtonHighlightedBackground = semanticColors.primaryButtonHighlightedBackground
        public static var primaryButtonText = semanticColors.primaryButtonText
        public static var primaryButtonHighlightedBaseline = semanticColors.primaryButtonHighlightedBaseline
        public static var primaryButtonBaseline = semanticColors.primaryButtonBaseline
        public static var statusCardIconDefaultTint = semanticColors.statusCardIconDefaultTint
        public static var switchTint = semanticColors.switchTint
        public static var switchTintSelected = semanticColors.switchTintSelected
        public static var textInputBorder = semanticColors.textInputBorder
        public static var textInputLeftViewTint = semanticColors.textInputLeftViewTint
        public static var secondaryButtonText = semanticColors.secondaryButtonText
        public static var secondaryButtonBackground = semanticColors.secondaryButtonBackground
        public static var secondaryButtonHighlightedBackground = semanticColors.secondaryButtonHighlightedBackground
        public static var whiteBackground = semanticColors.whiteBackground
    }
}
