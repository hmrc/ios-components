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

extension Components.Molecules {
    open class CurrencyInputView: TextInputView {

        public class CurrencyInputViewModel: Model {

            public init(
                title: String? = nil,
                initialText: String? = nil,
                maxLength: Int? = nil) {

                super.init(
                    title: title,
                    leftViewText: "£",
                    initialText: initialText,
                    maxLength: maxLength,
                    multiLine: false,
                    keyboardType: .decimalPad
                )
            }
        }

        override open func shouldShowCharCountLabel() -> Bool {
            return false
        }

        open override func textView(
            _ textView: UITextView,
            shouldChangeTextIn range: NSRange,
            replacementText text: String) -> Bool {

            let result = super.textView(textView, shouldChangeTextIn: range, replacementText: text)
            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)

            return result && (text.isEmpty || newText.isCurrencyValue())
        }
    }
}
