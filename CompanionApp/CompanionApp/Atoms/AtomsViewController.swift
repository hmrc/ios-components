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
import UIComponents

private enum AtomGroupType: String {
    case text = "Text"
    case button = "Buttons"
    case cardView = "CardView"

    func atoms() -> [UIView] {
        switch self {
        case .button:
            return [
                UIButton.styled(style: .primary(true), string: "Primary button"),
                UIButton.styled(style: .primary(false), string: "Disabled primary button"),
                UIButton.styled(style: .secondary, string: "Secondary button")
            ]
        case .text:
            let textStyleVariants = [
                UILabel.styled(style: .H3, string: "H3 text"),
                UILabel.styled(style: .H4, string: "H4 text"),
                UILabel.styled(style: .H5, string: "H5 text"),
                UILabel.styled(style: .bold, string: "Bold text"),
                UILabel.styled(style: .body, string: "Body text"),
                UILabel.styled(style: .info, string: "Info text"),
                UILabel.styled(style: .link, string: "Link text"),
                UILabel.styled(style: .error, string: "Error text")
            ]

            // swiftlint:disable:next line_length
            let bulletedLabel1 = Components.Atoms.BulletLabelView(text: "Bulleted Text without newline characters that extends over multiple lines in order to demonstate indenting. Bulleted Text without newline characters that extends over multiple lines in order to demonstate indenting.")

            // swiftlint:disable:next line_length
            let bulletedLabel2 = Components.Atoms.BulletLabelView(text: "Bulleted Text with newline characters\nthat extends over multiple lines\nin order to demonstate indenting.")

            return textStyleVariants + [bulletedLabel1, bulletedLabel2]
        case .cardView:
            return [
                Components.Atoms.CardView(components: [])
            ]
        }
    }
}

class AtomsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "atomReuse")
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    fileprivate let atomGroups = [
        AtomGroupType.text,
        AtomGroupType.button
    ]

    private func showAtomGroup(at indexPath: IndexPath) {
        let type = atomGroups[indexPath.row]
        let viewController = AtomGroupViewController()
        viewController.title = type.rawValue
        viewController.atoms = type.atoms()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension AtomsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return atomGroups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "atomReuse")!
        cell.textLabel?.text = atomGroups[indexPath.row].rawValue
        return cell
    }
}

extension AtomsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAtomGroup(at: indexPath)
    }
}
