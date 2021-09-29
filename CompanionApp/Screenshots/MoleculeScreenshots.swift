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
        grabScreenshot(menuItem: "Text Input View", filename: "TextInputView.png")
    }

    func test_screenshot_CurrencyInputView() {
        grabScreenshot(menuItem: "Currency Input View", filename: "CurrencyInputView.png")
    }

    func test_screenshot_H4TitleBodyView() {
        grabScreenshot(menuItem: "H4 Title Body View", filename: "H4TitleBodyView.png")
    }

    func test_screenshot_H5TitleBodyView() {
        grabScreenshot(menuItem: "H5 Title Body View", filename: "H5TitleBodyView.png")
    }

    func test_screenshot_BoldTitleBodyView() {
        grabScreenshot(menuItem: "H6 Title Body View", filename: "BoldTitleBodyView.png")
    }

    func test_screenshot_InsetView() {
        grabScreenshot(menuItem: "Inset View", filename: "InsetView.png")
    }

    func test_screenshot_MultiColumnRowView() {
        grabScreenshot(menuItem: "Multi Column Row View", filename: "MultiColumnRowView.png")
    }

    func test_screenshot_SwitchRowView() {
        grabScreenshot(menuItem: "Switch Row View", filename: "SwitchRowView.png")
    }

    func test_screenshot_IconButtonView() {
        grabScreenshot(menuItem: "Icon Button View", filename: "IconButtonView.png")
    }

    func test_screenshot_StatusView() {
        grabScreenshot(menuItem: "Status View", filename: "StatusView.png")
    }

    func test_screenshot_WarningView() {
        grabScreenshot(menuItem: "Warning View", filename: "WarningView.png")
    }

    func test_screenshot_TabBarView() {
        grabScreenshot(menuItem: "Tab Bar View", filename: "TabBarView.png")
    }

    func test_screenshot_SelectRowView() {
        grabScreenshot(menuItem: "Select Row View", filename: "SelectRowView.png")
    }

    func test_screenshot_SelectRowGroupView() {
        grabScreenshot(menuItem: "Select Row Group View", filename: "SelectRowGroupView.png")
    }
}

// MARK: - Helpers

extension MoleculeScreenshots {
    func grabScreenshot(menuItem: String, filename: String) {
        menuVC.tableView.selectRow(text: menuItem)

        let expectation = expectation(description: "screenshot grabbed")
        ScreenCapture().captureScreen(filename: "Molecule_\(filename)") {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 60)
    }
}
