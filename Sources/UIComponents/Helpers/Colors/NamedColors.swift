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
    open class DarkColors: NamedColors {
        
        public init() {}
        
        open var black = UIColor(hexString: "#FFFFFF")
        open var white = UIColor(hexString: "#262626")
        open var green1 = UIColor(hexString: "#69B134")
        open var green2 = UIColor(hexString: "#85994B")
        open var blue = UIColor(hexString: "#5BC0C6")
        open var teal = UIColor(hexString: "#28A197")
        open var red = UIColor(hexString: "#EB66CA")
        open var grey1 = UIColor(hexString: "#B1B4B6")
        open var grey2 = UIColor(hexString: "#B1B4B6")
        open var grey3 = UIColor(hexString: "#0B0C0C")
        open var pink = UIColor(hexString: "#BB94FF")
        open var yellow = UIColor(hexString: "#FEFF4F")
    }
    
    open class LightColors: NamedColors {
        
        public init() {}
        
        open var black = UIColor(hexString: "#0B0C0C")
        open var white = UIColor(hexString: "#FFFFFF")
        open var green1 = UIColor(hexString: "#00703C")
        open var green2 = UIColor(hexString: "#85994B")
        open var blue = UIColor(hexString: "#1D70B8")
        open var teal = UIColor(hexString: "#28A197")
        open var red = UIColor(hexString: "#D4351C")
        open var grey1 = UIColor(hexString: "#505A5F")
        open var grey2 = UIColor(hexString: "#B1B4B6")
        open var grey3 = UIColor(hexString: "#F3F2F1")
        open var pink = UIColor(hexString: "#D53880")
        open var yellow = UIColor(hexString: "#FFBF47")
    }
}
