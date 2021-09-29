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

import XCTest
@testable import CompanionApp

class ColourScreenshots: ViewControllerTestCase {

    lazy var menuVC: ColoursViewController = {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ColoursViewController") as! ColoursViewController
    }()

    override func setUp() {
        super.setUp()
        load(viewController: menuVC)
    }

    func test_screenshot_colours() {
        let expectation = expectation(description: "screenshot grabbed")
        ScreenCapture().captureScreen(filename: "Colours.png") {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 60)
    }
}
