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

import UIKit
import UIComponents

class MoleculesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "moleculeReuse")
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    let molecules: [(named: String, vc: UIViewController)] = [
        (named: "Text Input View", vc: SingleComponentViewController<Components.Molecules.TextInputView>()),
        (named: "Currency Input View", vc: SingleComponentViewController<Components.Molecules.CurrencyInputView>()),
        (named: "H4 Title Body View", vc: SingleComponentViewController<Components.Molecules.H4TitleBodyView>()),
        (named: "H5 Title Body View", vc: SingleComponentViewController<Components.Molecules.H5TitleBodyView>()),
        (named: "Bold Title Body View", vc: SingleComponentViewController<Components.Molecules.BoldTitleBodyView>()),
        (named: "Inset View", vc: SingleComponentViewController<Components.Molecules.InsetView>()),
        (named: "Multi Column Row View", vc: SingleComponentViewController<Components.Molecules.MultiColumnRowView>()),
        (named: "Switch Row View", vc: SingleComponentViewController<Components.Molecules.SwitchRowView>()),
        (named: "Icon Button View", vc: SingleComponentViewController<Components.Molecules.IconButtonView>()),
        (named: "Status View", vc: SingleComponentViewController<Components.Molecules.StatusView>()),
        (named: "Warning View", vc: SingleComponentViewController<Components.Molecules.WarningView>()),
        (named: "Tab Bar View", vc: SingleComponentViewController<Components.Molecules.TabBarView>()),
        (named: "Select Row View", vc: SingleComponentViewController<Components.Molecules.SelectRowView>()),
        (named: "Select Row Group View", vc: SingleComponentViewController<Components.Molecules.SelectRowGroupView>())
    ]

    private func showMolecule(at indexPath: IndexPath) {
        let data = molecules[indexPath.row]
        let viewController = data.vc
        viewController.title = data.named
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MoleculesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return molecules.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moleculeReuse")!
        cell.textLabel?.text = molecules[indexPath.row].named
        return cell
    }
}

extension MoleculesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showMolecule(at: indexPath)
    }
}
