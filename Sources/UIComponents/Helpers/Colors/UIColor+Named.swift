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

public protocol NamedColors {
    var black: UIColor { get }
    var white: UIColor { get }
    var green1: UIColor { get }
    var green2: UIColor { get }
    var blue: UIColor { get }
    var teal: UIColor { get }
    var red: UIColor { get }
    var grey1: UIColor { get }
    var grey2: UIColor { get }
    var grey3: UIColor { get }
    var pink: UIColor { get }
    var yellow: UIColor { get }
}

public extension UIColor {
    internal typealias ColorConfig = UIComponents.Components.Helpers.ColorConfig
    
    enum Named: String, CaseIterable {
        case black,
             white,
             green1,
             green2,
             blue,
             teal,
             red,
             grey1,
             grey2,
             grey3,
             pink,
             yellow

        public static var allColors: [(String, UIColor)] {
            return allCases.map { ($0.rawValue, $0.raw) }
        }
        
        public var raw: UIColor {
            
            UIComponents.Components.Helpers.ColorConfig.shared.setup(semanticLightColors: MySemanticColors())
            
            let colorContainer: NamedColors
            if UIColor.useLightModeColors {
                colorContainer = ColorConfig.shared.lightColors
            } else {
                colorContainer = ColorConfig.shared.darkColors
            }

            switch self {
            case .black:
                return colorContainer.black
            case .white:
                return colorContainer.white
            case .green1:
                return colorContainer.green1
            case .green2:
                return colorContainer.green2
            case .blue:
                return colorContainer.blue
            case .teal:
                return colorContainer.teal
            case .red:
                return colorContainer.red
            case .grey1:
                return colorContainer.grey1
            case .grey2:
                return colorContainer.grey2
            case .grey3:
                return colorContainer.grey3
            case .pink:
                return colorContainer.pink
            case .yellow:
                return colorContainer.yellow
            }
        }
    }
}

struct MySemanticColors: SemanticColors {
    public var darkText = UIColor.SemanticLightColors().darkText
    public var lightText = UIColor.SemanticLightColors().lightText
    public var linkText = UIColor.SemanticLightColors().linkText
    public var errorText = UIColor.SemanticLightColors().errorText
    public var infoText = UIColor.SemanticLightColors().infoText
    public var expandableButtonText = UIColor.SemanticLightColors().expandableButtonText
    public var cardBackground = UIColor.SemanticLightColors().cardBackground
    public var cardShadow = UIColor.SemanticLightColors().cardShadow
    public var pageBackground = UIColor.SemanticLightColors().pageBackground
    public var menuCardBackground = UIColor.SemanticLightColors().menuCardBackground
    public var menuPageBackground = UIColor.SemanticLightColors().menuPageBackground
    public var divider = UIColor.SemanticLightColors().divider
    public var insetBar = UIColor.SemanticLightColors().insetBar
    public var primaryButtonBackground = UIColor.SemanticLightColors().primaryButtonBackground
    public var primaryButtonDisabledBackground = UIColor.SemanticLightColors().primaryButtonDisabledBackground
    public var primaryButtonDisabledText = UIColor.SemanticLightColors().primaryButtonDisabledText
    public var primaryButtonHighlightedBackground = UIColor.SemanticLightColors().primaryButtonHighlightedBackground
    public var primaryButtonText = UIColor.SemanticLightColors().primaryButtonText
    public var primaryButtonHighlightedBaseline = UIColor.SemanticLightColors().primaryButtonHighlightedBaseline
    public var primaryButtonBaseline = UIColor.SemanticLightColors().primaryButtonBaseline
    public var statusCardIconDefaultTint = UIColor.SemanticLightColors().statusCardIconDefaultTint
    public var switchTint = UIColor.SemanticLightColors().switchTint
    public var switchTintSelected = UIColor.SemanticLightColors().switchTintSelected
    public var textInputBorder = UIColor.SemanticLightColors().textInputBorder
    public var textInputLeftViewTint = UIColor.SemanticLightColors().textInputLeftViewTint
    public var secondaryButtonText = UIColor.SemanticLightColors().secondaryButtonText
    public var secondaryButtonBackground = UIColor.SemanticLightColors().secondaryButtonBackground
    public var secondaryButtonHighlightedBackground = UIColor.SemanticLightColors().secondaryButtonHighlightedBackground
    public var whiteBackground = UIColor.SemanticLightColors().whiteBackground
    
}
