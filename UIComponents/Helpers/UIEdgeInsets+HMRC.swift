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

import Foundation

extension UIEdgeInsets {
    init(padding: CGFloat) {
        self.init(top: padding, left: padding, bottom: padding, right: padding)
    }

    static let standardCard = UIEdgeInsets(top: .spacer16, left: .spacer16, bottom: .spacer16, right: .spacer16)
    static let standardCardHorizontal = UIEdgeInsets(top: 0, left: .spacer16, bottom: 0, right: .spacer16)
    static let standardCardVertical = UIEdgeInsets(top: .spacer16, left: 0, bottom: .spacer16, right: 0)
}
