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

class OrganismScreenshots: ViewControllerTestCase {

    lazy var menuVC: OrganismsViewController = {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "OrganismsViewController") as! OrganismsViewController
    }()

    override func setUp() {
        super.setUp()
        load(viewController: menuVC)
    }

    func test_screenshot_HeadlineCardView() {
        //grabScreenshot(menuItem: "Headline Card View", filename: "HeadlineCardView.png")
        grabScreenshot(menuItem: "Headline Card View", screen: .headlineCardView)
    }

    func test_screenshot_PrimaryCardView() {
        grabScreenshot(menuItem: "Primary Card View", screen: .primaryCardView)
    }

    func test_ExpandingRowView() {
        grabScreenshot(menuItem: "Expanding Row View", screen: .expandingRowView)
    }

    func test_StatusCardView() {
        grabScreenshot(menuItem: "Status Card View", screen: .statusCardView, delayBeforeCapture: 5)
    }

    func test_IconButtonCardView() {
        grabScreenshot(menuItem: "Icon Button Card View", screen: .iconButtonCardView)
    }

    func test_SummaryRowView() {
        grabScreenshot(menuItem: "Summary Row View", screen: .summaryRowView)
    }

    func test_InformationMessageCard() {
        grabScreenshot(menuItem: "Information Message Card", screen: .informationMessageCard)
    }

    func test_MenuPanelRowView() {
        grabScreenshot(menuItem: "Menu Panel Row View", screen: .menuPanelRowView)
    }
}

// MARK: - Helpers

extension OrganismScreenshots {
    func grabScreenshot(menuItem: String, screen: Capture.Screen, delayBeforeCapture: TimeInterval? = nil) {
        menuVC.tableView.selectRow(text: menuItem)

        if let delayBeforeCapture = delayBeforeCapture {
            // Ensure layout sorts itself out before capture
            RunLoop.main.run(until: Date(timeIntervalSinceNow: delayBeforeCapture))
        }

        let expectation = expectation(description: "screenshot grabbed")
        ScreenCapture().captureScreen(filename: screen.rawValue + ".png") {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 60)
    }
}
