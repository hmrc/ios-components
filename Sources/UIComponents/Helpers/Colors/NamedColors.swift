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
extension UIColor {
    convenience init(darkColour: UIColor, lightColour: UIColor) {
        if #available(iOS 13.0, *) {
            self.init { traitCollection in
                traitCollection.userInterfaceStyle == .dark ? darkColour : lightColour
            }
        } else {
            self.init(cgColor: lightColour.cgColor)
        }
    }
}
extension UIColor {
    open class Colors: NamedColors {
        
        public init() {}
        
        open var black = UIColor(darkColour: .init(hexString: "#FFFFFF"), lightColour: .init(hexString: "#0B0C0C"))
        open var white = UIColor(darkColour: .init(hexString: "#262626"), lightColour: .init(hexString: "#FFFFFF"))
        open var green1 = UIColor(darkColour: .init(hexString: "#69B134"), lightColour: .init(hexString: "#00703C"))
        open var green2 = UIColor(darkColour: .init(hexString: "#85994B"), lightColour: .init(hexString: "#85994B"))
        open var blue = UIColor(darkColour: .init(hexString: "#5BC0C6"), lightColour: .init(hexString: "#1D70B8"))
        open var teal = UIColor(darkColour: .init(hexString: "#28A197"), lightColour: .init(hexString: "#28A197"))
        open var red = UIColor(darkColour: .init(hexString: "#EB66CA"), lightColour: .init(hexString: "#D4351C"))
        open var grey1 = UIColor(darkColour: .init(hexString: "#B1B4B6"), lightColour: .init(hexString: "#505A5F"))
        open var grey2 = UIColor(darkColour: .init(hexString: "#B1B4B6"), lightColour: .init(hexString: "#B1B4B6"))
        open var grey3 = UIColor(darkColour: .init(hexString: "#0B0C0C"), lightColour: .init(hexString: "#F3F2F1"))
        open var pink = UIColor(darkColour: .init(hexString: "#BB94FF"), lightColour: .init(hexString: "#D53880"))
        open var yellow = UIColor(darkColour: .init(hexString: "#FEFF4F"), lightColour: .init(hexString: "#FFBF47"))
    }
}
