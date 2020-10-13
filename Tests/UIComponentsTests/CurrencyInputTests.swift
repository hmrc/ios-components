///*
// * Copyright 2018 HM Revenue & Customs
// *
// * Licensed under the Apache License, Version 2.0 (the "License");
// * you may not use this file except in compliance with the License.
// * You may obtain a copy of the License at
// *
// *     http://www.apache.org/licenses/LICENSE-2.0
// *
// * Unless required by applicable law or agreed to in writing, software
// * distributed under the License is distributed on an "AS IS" BASIS,
// * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// * See the License for the specific language governing permissions and
// * limitations under the License.
// */
//
//import Foundation
//import XCTest
//@testable import UIComponents
//
//class CurrencyInputTests: XCTestCase {
//    typealias CurrencyInputView = Components.Molecules.CurrencyInputView
//    typealias Model = CurrencyInputView.Model
//
//    var sut: CurrencyInputView!
//
//    override func setUp() {
//        super.setUp()
//        //dont waste time animating stuff
//        UIView.setAnimationsEnabled(false)
//        sut =  CurrencyInputView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
//    }
//
//    func test_shouldNotAcceptAlphabeticCharacters() {
//        sut.textView.text = ""
//        let result = sut.textView(
//            sut.textView,
//            shouldChangeTextIn: NSRange(location: 0, length: 0),
//            replacementText: "a"
//        )
//        XCTAssertFalse(result)
//    }
//
//    func test_shouldAcceptNoDecimalSeparator() {
//        sut.textView.text = "1"
//        sut.textViewDidEndEditing(sut.textView)
//        let result = sut.textView(
//            sut.textView,
//            shouldChangeTextIn: NSRange(location: 1, length: 0),
//            replacementText: "5"
//        )
//        XCTAssertTrue(result)
//    }
//
//    func test_shouldNotAcceptMoreThanOneDecimalSeparator() {
//        sut.textView.text = "1.5"
//        sut.textViewDidEndEditing(sut.textView)
//        let result = sut.textView(
//            sut.textView,
//            shouldChangeTextIn: NSRange(location: 3, length: 0),
//            replacementText: "."
//        )
//        XCTAssertFalse(result)
//    }
//
//    func test_shouldAcceptJustOneDecimalPlace() {
//        sut.textView.text = "1."
//        sut.textViewDidEndEditing(sut.textView)
//        let result = sut.textView(
//            sut.textView,
//            shouldChangeTextIn: NSRange(location: 2, length: 0),
//            replacementText: "5"
//        )
//        XCTAssertTrue(result)
//    }
//
//    func test_shouldAcceptTwoDecimalPlace() {
//        sut.textView.text = "1.5"
//        sut.textViewDidEndEditing(sut.textView)
//        let result = sut.textView(
//            sut.textView,
//            shouldChangeTextIn: NSRange(location: 3, length: 0),
//            replacementText: "6"
//        )
//        XCTAssertTrue(result)
//    }
//
//    func test_shouldNotAcceptMoreThanTwoDecimalPlaces() {
//        sut.textView.text = "1.56"
//        sut.textViewDidEndEditing(sut.textView)
//        let result = sut.textView(
//            sut.textView,
//            shouldChangeTextIn: NSRange(location: 4, length: 0),
//            replacementText: "7"
//        )
//        XCTAssertFalse(result)
//    }
//}
