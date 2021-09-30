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

class MoleculeScreenshots: ViewControllerTestCase {

    lazy var menuVC: MoleculesViewController = {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MoleculesViewController") as! MoleculesViewController
    }()

    override func setUp() {
        super.setUp()
        load(viewController: menuVC)
    }

    func test_screenshot_TextInputView() {
        grabScreenshot(menuItem: "Text Input View", screen: .textInputView)
    }

    func test_screenshot_CurrencyInputView() {
        grabScreenshot(menuItem: "Currency Input View", screen: .currencyInputView)
    }

    func test_screenshot_H4TitleBodyView() {
        grabScreenshot(menuItem: "H4 Title Body View", screen: .h4TitleBodyView)
    }

    func test_screenshot_H5TitleBodyView() {
        grabScreenshot(menuItem: "H5 Title Body View", screen: .h5TitleBodyView)
    }

    func test_screenshot_BoldTitleBodyView() {
        grabScreenshot(menuItem: "H6 Title Body View", screen: .boldTitleBodyView)
    }

    func test_screenshot_InsetView() {
        grabScreenshot(menuItem: "Inset View", screen: .insetView)
    }

    func test_screenshot_MultiColumnRowView() {
        grabScreenshot(menuItem: "Multi Column Row View", screen: .multiColumnRowView)
    }

    func test_screenshot_SwitchRowView() {
        grabScreenshot(menuItem: "Switch Row View", screen: .switchRowView)
    }

    func test_screenshot_IconButtonView() {
        grabScreenshot(menuItem: "Icon Button View", screen: .iconButtonView)
    }

    func test_screenshot_StatusView() {
        grabScreenshot(menuItem: "Status View", screen: .statusView)
    }

    func test_screenshot_WarningView() {
        grabScreenshot(menuItem: "Warning View", screen: .warningView)
    }

    func test_screenshot_TabBarView() {
        grabScreenshot(menuItem: "Tab Bar View", screen: .tabBarView)
    }

    func test_screenshot_SelectRowView() {
        grabScreenshot(menuItem: "Select Row View", screen: .selectRowView)
    }

    func test_screenshot_SelectRowGroupView() {
        grabScreenshot(menuItem: "Select Row Group View", screen: .selectRowGroupView)
    }
}

// MARK: - Helpers

extension MoleculeScreenshots {
    func grabScreenshot(menuItem: String, screen: Capture.Screen) {
        menuVC.tableView.selectRow(text: menuItem)

        let expectation = expectation(description: "screenshot grabbed")
        ScreenCapture().captureScreen(filename: screen.rawValue + ".png") {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 60)
    }
}
