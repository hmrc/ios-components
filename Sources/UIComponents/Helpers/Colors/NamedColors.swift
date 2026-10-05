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

public protocol NamedColors {
    var black: UIColor { get set }
    var white: UIColor { get set }
    var green1: UIColor { get set }
    var green2: UIColor { get set }
    var blue: UIColor { get set }
    var teal: UIColor { get set }
    var red: UIColor { get set }
    var grey1: UIColor { get set }
    var grey2: UIColor { get set }
    var grey3: UIColor { get set }
    var pink: UIColor { get set }
    var yellow: UIColor { get set }
}

public extension UIColor {

    enum Palette {

        public enum Primary: String, CaseIterable {
            case black,
                 white,
                 green,
                 red,
                 blue,
                 turquoise,
                 grey,
                 darkGrey,
                 midGrey,
                 lightGrey,
                 teal,
                 yellow,
                 lightBlue,
                 navy,
                 green2,
                 pink,
                 yellowLight

            public var hex: String {
                switch self {
                case .black: return "#0B0C0C"
                case .white: return "#FFFFFF"
                case .green: return "#00703C"
                case .red: return "#D4351C"
                case .blue: return "#1D70B8"
                case .turquoise: return "#28A197"
                case .grey: return "#282D30"
                case .darkGrey: return "#505A5F"
                case .midGrey: return "#B1B4B6"
                case .lightGrey: return "#F3F2F1"
                case .teal: return "#5BC0C6"
                case .yellow: return "#FFDD00"
                case .lightBlue: return "#D7E4F2"
                case .navy: return "#0A2740"
                case .green2: return "#85994B"
                case .pink: return "#D53880"
                case .yellowLight: return "#FFBF47"
                }
            }

            public var uiColour: UIColor {
                UIColor(hexString: hex)
            }
        }

        public enum DarkMode: String, CaseIterable {
            case primaryGreen,
                 primaryRed,
                 darkNavy,
                 darkNavy2,
                 darkNavy3,
                 whiteDark,
                 grey5,
                 pinkDark,
                 yellowDark

            public var hex: String {
                switch self {
                case .primaryGreen: return "#188659"
                case .primaryRed: return "#F26954"
                case .darkNavy: return "#0D1C29"
                case .darkNavy2: return "#061625"
                case .darkNavy3: return "#092537"
                case .whiteDark: return "#262626"
                case .grey5: return "#3B3838"
                case .pinkDark: return "#BB94FF"
                case .yellowDark: return "#FEFF4F"
                }
            }

            public var uiColour: UIColor {
                UIColor(hexString: hex)
            }
        }
    }
}

public extension UIColor {
    convenience init(darkColour: UIColor, lightColour: UIColor) {
        self.init { $0.userInterfaceStyle == .dark ? darkColour : lightColour }
    }

    convenience init(dark: Palette.Primary, light: Palette.Primary) {
        self.init(darkColour: dark.uiColour, lightColour: light.uiColour)
    }

    convenience init(dark: Palette.DarkMode, light: Palette.Primary) {
        self.init(darkColour: dark.uiColour, lightColour: light.uiColour)
    }

    convenience init(dark: Palette.Primary, light: Palette.DarkMode) {
        self.init(darkColour: dark.uiColour, lightColour: light.uiColour)
    }
}

extension UIColor {
    open class Colors: NamedColors {
        
        public init() {}
        
        open var black = UIColor(dark: Primary.white, light: Primary.black)
        open var white = UIColor(dark: DarkMode.whiteDark, light: Primary.white)
        open var green1 = UIColor(dark: DarkMode.primaryGreen, light: Primary.green)
        open var green2 = Primary.green2.uiColour
        open var blue = UIColor(dark: Primary.teal, light: Primary.blue)
        open var teal = Primary.turquoise.uiColour
        open var red = UIColor(dark: DarkMode.primaryRed, light: Primary.red)
        open var grey1 = UIColor(dark: Primary.midGrey, light: Primary.darkGrey)
        open var grey2 = Primary.midGrey.uiColour
        open var grey3 = UIColor(dark: Primary.black, light: Primary.lightGrey)
        open var pink = UIColor(dark: DarkMode.pinkDark, light: Primary.pink)
        open var yellow = UIColor(dark: DarkMode.yellowDark, light: Primary.yellowLight)
    }
}
