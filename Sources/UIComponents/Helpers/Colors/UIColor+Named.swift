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

public extension UIColor {

    enum ColorMode {
        case userSpecified
        case light
        case dark
    }
    
    enum Named: String, CaseIterable, ColorServiceInjected {
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
            rawColor(colorMode: .userSpecified)
        }

        public var rawInLightMode: UIColor {
            rawColor(colorMode: .light)
        }

        public var rawInDarkMode: UIColor {
            rawColor(colorMode: .dark)
        }

        private func rawColor(colorMode: ColorMode = .userSpecified) -> UIColor {
            let colorContainer: NamedColors = {
                switch colorMode {
                case .userSpecified:
                    if UIColor.useLightModeColors {
                        return colorService.lightColors
                    } else {
                        return colorService.darkColors
                    }
                case .light:
                    return colorService.lightColors
                case .dark:
                    return colorService.darkColors
                }
            }()

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
