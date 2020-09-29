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

enum ExampleImages {

    case coins
    case poundSign
    case maintenance
    case info
    case help
    case previewBackground
    case warning

    var image: UIImage {
        switch self {
        case .poundSign:
            return UIImage(named: "pound_sign")!
        case .help:
            return UIImage(named: "help")!
        case .coins:
            return UIImage(named: "coins")!
        case .info:
            return UIImage(named: "info")!
        case .maintenance:
            return UIImage(named: "maintenance")!
        case .previewBackground:
            return UIImage(named: "preview_background")!
        case .warning:
            return UIImage(named: "warning")!
        }
    }
}
