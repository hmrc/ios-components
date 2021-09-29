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

import UIKit

extension UITableView {
    func selectRow(text: String) {
        guard
            let dataSource = self.dataSource,
            let delegate = self.delegate,
            let numSections = dataSource.numberOfSections?(in: self) else { return }

        let indexPath: IndexPath? = {
            for sectionIndex in 0..<numSections {
                let numRows = dataSource.tableView(self, numberOfRowsInSection: sectionIndex)

                for rowIndex in 0..<numRows {
                    let rowText = dataSource.tableView(
                        self,
                        cellForRowAt: IndexPath(
                            row: rowIndex,
                            section: sectionIndex
                        )
                    ).textLabel?.text

                    if rowText == text {
                        return IndexPath(row: rowIndex, section: sectionIndex)
                    }
                }
            }
            return nil
        }()

        guard let indexPath = indexPath else { return }
        delegate.tableView?(self, didSelectRowAt: indexPath)
    }
}
