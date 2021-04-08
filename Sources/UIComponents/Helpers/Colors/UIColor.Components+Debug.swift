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

public extension UIColor.Components {
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
