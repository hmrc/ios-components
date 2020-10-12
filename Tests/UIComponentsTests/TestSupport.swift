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

struct Test {

    static let Timeout: Double = 10
    typealias AssertionBlock = (() -> String?)

    static func assertAccessibilityIsOff() {
        let fontScale = UIFont.preferredFont(forTextStyle: .body).pointSize / 17.0
        assert(fontScale == 1, "Large text (accessibility) is enabled. Please disable it in the simulator.")
    }

    @discardableResult static func waitUntil(
        _ description: String,
        timeout: TimeInterval=Test.Timeout,
        _ assertionBlock: AssertionBlock) -> Bool {

        let finishTime = Date().addingTimeInterval(timeout)
        var timedOut = false
        var counter = 0

        while !timedOut {
            RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.1))

            let failReason = assertionBlock()

            if failReason == nil {
                break
            }

            timedOut = Date() >= finishTime
            counter += 1
            if counter == 9 {
                print("- Fail reason: \(failReason!)")
                print("Waiting for '\(description)'")

                counter = 0
            }
        }

        if timedOut {
            XCTFail("Timed out waiting for: '\(description)'")
            return false
        } else {
            return true
        }
    }
}
