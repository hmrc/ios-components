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
import XCTest
@testable import UIComponents

class TextInputTests: XCTestCase {
    typealias TextInputView = Components.Molecules.TextInputView
    typealias Model = TextInputView.Model

    var sut: TextInputView!

    override func setUp() {
        super.setUp()
        //dont waste time animating stuff
        UIView.setAnimationsEnabled(false)
        sut =  TextInputView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    }

    private class ModelBuilder {
        var title: String? = "A Title"
        var initialText: String? = "Initial Text"
        var leftViewText: String? = "£"
        var maxLength: Int?
        var multiLine = true

        func set(title: String?) -> Self {
            self.title = title
            return self
        }

        func set(initialText: String?) -> Self {
            self.initialText = initialText
            return self
        }

        func set(leftViewText: String?) -> Self {
            self.leftViewText = leftViewText
            return self
        }

        func set(maxLength: Int?) -> Self {
            self.maxLength = maxLength
            return self
        }

        func set(multiLine: Bool) -> Self {
            self.multiLine = multiLine
            return self
        }

        func build() -> Model {
            let model = Components.Molecules.TextInputView.Model(
                title: title,
                leftViewText: leftViewText,
                initialText: initialText,
                maxLength: maxLength,
                multiLine: multiLine)

            return model
        }
    }

    func test_maxCountIsGreaterThanZero_thenCharacterCountLabelIsVisible() {
        let model = ModelBuilder().set(maxLength: 8).build()
        sut.updateUI(for: model)
        XCTAssertFalse(sut.charCountLabel.isHidden)
    }

    func test_maxCountIsZero_thenCharacterCountLabelIsHidden() {
        let model = ModelBuilder().set(maxLength: 0).build()
        sut.updateUI(for: model)
        XCTAssertTrue(sut.charCountLabel.isHidden)
    }

    func test_maxCountIsNil_thenCharacterCountLabelIsHidden() {
        let model = ModelBuilder().set(maxLength: nil).build()
        sut.updateUI(for: model)
        XCTAssertTrue(sut.charCountLabel.isHidden)
    }

    func test_maxCountIsLessThanZero_thenCharacterCountLabelIsHidden() {
        let model = ModelBuilder().set(maxLength: -1).build()
        sut.updateUI(for: model)
        XCTAssertTrue(sut.charCountLabel.isHidden)
    }

    func test_validationMessageIsNonNil_thenValidationLabelIsVisibleAndTextIsCorrect() {
        let model = ModelBuilder().build()
        sut.updateUI(for: model)
        let expectedValidationErrorText = "A Validation Error"
        sut.set(validationError: expectedValidationErrorText)
        XCTAssertFalse(sut.validationErrorLabel.isHidden)
        XCTAssertEqual(sut.validationErrorLabel.text, expectedValidationErrorText)
    }

    func test_validationMessageIsNil_andValidationMessageIsThenSetToAValue_thenValidationLabelIsVisibleAndTextIsCorrect() {
        let model = ModelBuilder().build()
        sut.updateUI(for: model)
        sut.set(validationError: nil)
        let expectedValidationErrorText = "A Validation Error"
        sut.set(validationError: expectedValidationErrorText)

        Test.waitUntil("Validation Label is shown") { () -> String? in
            let text = sut.validationErrorLabel.text ?? ""
            if sut.validationErrorLabel.isHidden {
                return "Validation label is still hidden"
            } else if text != expectedValidationErrorText {
                return "Expected validation text to be '\(expectedValidationErrorText)' got \(text)"
            } else {
                return nil
            }
        }
    }

    func test_leftViewTextIsNil_thenLeftViewIsHidden() {
        let model = ModelBuilder().set(leftViewText: nil).build()
        sut.updateUI(for: model)
        XCTAssertTrue(sut.leftView.isHidden)
    }

    func test_leftViewTextIsEmpty_thenLeftViewIsHidden() {
        let model = ModelBuilder().set(leftViewText: "").build()
        sut.updateUI(for: model)
        XCTAssertTrue(sut.leftView.isHidden)
    }

    func test_leftViewTextIsNotNilAndNotEmpty_thenLeftViewIsVisible() {
        let expected = "£"
        let model = ModelBuilder().set(leftViewText: expected).build()
        sut.updateUI(for: model)
        XCTAssertFalse(sut.leftView.isHidden)
        XCTAssertEqual(sut.leftView.label.text, expected)
    }

    func test_inputInitialTextSetToString_thenTextAreaTextIsCorrect() {
        let expected = "A string"
        let model = ModelBuilder().set(initialText: expected).build()
        sut.updateUI(for: model)
        XCTAssertEqual(sut.textView.text, expected)
    }

    func test_inputTextSetToString_thenContentOfCharacterCountLabelIsCorrect() {
        let text = "12345678"
        let model = ModelBuilder().set(initialText: text).set(maxLength: 10).build()
        sut.updateUI(for: model)
        XCTAssertEqual(sut.charCountLabel.text, "8/10")
    }

    func test_fontScaledAndMaxLengthLarge_thenContentOfCharacterCountLabelIsCorrect() {
        let text = "1234567891"
        let model = ModelBuilder().set(initialText: text).set(maxLength: 1000).build()
        sut.fontScale = 1.6
        sut.updateUI(for: model)
        XCTAssertEqual(sut.charCountLabel.text, "10/\n1000")
    }

    func test_titleIsSet_thenTitleLabelContentIsCorrect() {
        let expected = "A TITLE"
        let model = ModelBuilder().set(title: expected).build()
        sut.updateUI(for: model)
        XCTAssertEqual(sut.titleLabel.text, expected)
    }

}
