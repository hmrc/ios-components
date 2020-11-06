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

extension String {

    static let decimalFormatter: Foundation.NumberFormatter = {
        let formatter = Foundation.NumberFormatter()
        formatter.allowsFloats = true
        formatter.locale = Locale.current
        return formatter
    }()

    func isCurrencyValue() -> Bool {
        guard String.decimalFormatter.number(from: self) != nil else { return false }

        let currencyRegex = "^[0-9]*\\.?[0-9]?[0-9]?$"
        let currencyTest = NSPredicate(format: "SELF MATCHES %@", currencyRegex)

        return currencyTest.evaluate(with: self)
    }
}
