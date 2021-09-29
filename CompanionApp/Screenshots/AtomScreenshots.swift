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

class AtomScreenshots: ViewControllerTestCase {

    lazy var menuVC: AtomsViewController = {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AtomsViewController") as! AtomsViewController
    }()

    override func setUp() {
        super.setUp()
        load(viewController: menuVC)
    }

    func test_screenshot_buttons() {
        menuVC.tableView.selectRow(text: "Buttons")
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 999999))
    }
}
