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

class OrganismsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "organismReuse")
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    var organisms: [(named: String, vc: UIViewController)] = [
        (named: "Headline Card View", vc: SingleComponentViewController<Components.Organisms.HeadlineCardView>()),
        (named: "Primary Card View", vc: SingleComponentViewController<Components.Organisms.PrimaryCardView>()),
        (named: "Expanding Row View", vc: SingleComponentViewController<Components.Organisms.ExpandingRowView>()),
        (named: "Status Card View", vc: SingleComponentViewController<Components.StatusCardView>()),
        (named: "Icon Button Card View", vc: SingleComponentViewController<Components.Organisms.IconButtonCardView>()),
        (named: "Summary Row View", vc: SingleComponentViewController<Components.Organisms.SummaryRowView>()),
        (named: "Information Message Card", vc: SingleComponentViewController<Components.Organisms.InformationMessageCard>()),
        (named: "Menu Panel Row View", vc: SingleComponentViewController<Components.Organisms.MenuPanelRowView>())
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.tintColor = UIColor.Components.Named.blue
        print(tabBarController ?? "Nope")
        navigationItem.title = "App: \(appVersion) - Lib: \(Components.Info.libraryVersion)"
    }

    var appVersion: String {
        guard let dict = Bundle.main.infoDictionary,
              let version = dict["CFBundleShortVersionString"] as? String else {
            fatalError("Couldnt get app info from bundle")
        }
        return version
    }

    private func showOrganism(at indexPath: IndexPath) {
        let data = organisms[indexPath.row]
        let viewController = data.vc
        viewController.title = data.named
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension OrganismsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organisms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "organismReuse")!
        cell.textLabel?.text = organisms[indexPath.row].named
        return cell
    }
}

extension OrganismsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showOrganism(at: indexPath)
    }
}
