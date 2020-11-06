/*
 * Copyright 2018 HM Revenue & Customs
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

public extension UIColor {
    struct Components {
        public struct Named {
            public static var black: UIColor {
                return UIColor(hexString: "0B0C0C")
            }

            public static var white: UIColor {
                return UIColor(hexString: "FFFFFF")
            }

            public static var green1: UIColor {
                return UIColor(hexString: "00703C")
            }

            public static var green2: UIColor {
                return UIColor(hexString: "85994B")
            }

            public static var blue: UIColor {
                return UIColor(hexString: "1D70B8")
            }

            public static var teal: UIColor {
                return UIColor(hexString: "28A197")
            }

            public static var red: UIColor {
                return UIColor(hexString: "D4351C")
            }

            /// Dark Grey
            public static var grey1: UIColor {
                return UIColor(hexString: "6F777B")
            }

            /// Light Grey
            public static var grey2: UIColor {
                return UIColor(hexString: "B1B4B6")
            }

            /// Even Lighter Grey
            public static var grey3: UIColor {
                return UIColor(hexString: "F3F2F1")
            }

            public static var pink: UIColor {
                return UIColor(hexString: "CA2B75")
            }

            public static var yellow: UIColor {
                return UIColor(hexString: "FFDD00")
            }
        }

        struct Debug {
            public static var labelBackground: UIColor {
                return UIColor(hexString: "50ffdc54")
            }

            public static var buttonBackground: UIColor {
                return UIColor(hexString: "50008000")
            }

            public static var componentOrganismBorderColor: UIColor {
                return UIColor(hexString: "004D00")
            }

            public static var componentMoleculeBorderColor: UIColor {
                return UIColor(hexString: "008000")
            }

            public static var nonComponentBorderColor: UIColor {
                return UIColor.blue
            }

            public static var componentOrganismTextColor: UIColor {
                return UIColor(hexString: "004D00")
            }

            public static var componentMoleculeTextColor: UIColor {
                return UIColor(hexString: "008000")
            }

            public static var nonComponentTextColor: UIColor {
                return UIColor.blue
            }
        }
    }

    enum Named: String, CaseIterable {
        case black, pink, teal, white, yellow

        public var raw: UIColor {
            return UIColor(named: self.rawValue, in: Bundle.colourResource, compatibleWith: nil)!
        }
    }

    enum Semantic: String, CaseIterable {

        case darkText,
        cardBackground,
        cardShadow,
        divider,
        errorText,
        expandableButtonText,
        infoText,
        insetBar,
        lightText,
        linkText,
        pageBackground,
        primaryButtonBackground,
        primaryButtonDisabledBackground,
        primaryButtonDisabledText, // remove in favour of light text
        primaryButtonHighlightedBackground,
        primaryButtonText, // remove in favour of light text
        secondaryButtonText, // remove in favour of link text
        statusCardIconDefaultTint,
        switchTint,
        textInputBorder,
        textInputLeftViewTint,
        whiteBackground,
        transparentButtonHighlightedBackground,
        primaryButtonBaseline,
        primaryButtonHighlightedBaseline,
        secondaryButtonBackground,
        secondaryButtonHighlightedBackground,
        switchTintSelected

        public var raw: UIColor {
            return UIColor(named: self.rawValue, in: Bundle.colourResource, compatibleWith: nil)!
        }
    }
}
