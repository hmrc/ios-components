/*
 * Copyright 2022 HM Revenue & Customs
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
import SnapKit

extension Components.Organisms {
    open class EditableListView: Components.Atoms.CardView, Component {
        
        // NOTE: As this is just a spike for now (HMA-6131) the tap action
        //       for individual rows has not been implemented yet
        public enum Mode {
            case view
            case edit
        }
        
        public struct Model {
            public let title: String
            public let rowModels: [RowModel]
            public let viewButtonTitle: String
            public let editButtonTitle: String
            public let mode: Mode
            
            public init(title: String,
                        rowModels: [RowModel],
                        viewButtonTitle: String,
                        editButtonTitle: String,
                        mode: Mode = .view) {
                self.title = title
                self.rowModels = rowModels
                self.viewButtonTitle = viewButtonTitle
                self.editButtonTitle = editButtonTitle
                self.mode = mode
            }
        }
        
        public struct RowModel {
            public let label: String
            public let value: String
            
            public init(label: String,
                        value: String) {
                self.label = label
                self.value = value
            }
        }
        
        private var model: Model?
        
        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public required init(model: Model?) {
            super.init(components: [titleLabel, rowContainerView, button])
            
            rowContainerView.spacing = .spacer8
            rowContainerView.backgroundColor = UIColor(hexString: "#FDEF19")
            stackView.setCustomSpacing(.spacer24, after: rowContainerView)
            
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
            editButton.backgroundColor = UIColor(hexString: "#C3E8DE")

            NSLayoutConstraint.activate([

            ])

            editButton.setTitle("Edit", for: .normal)
            
            if let model = model {
                updateUI(for: model)
            }
        }
        
        public func updateUI(for model: Model) {
            self.model = model
            titleLabel.text = model.title

            editButton.backgroundColor = UIColor(hexString: "#C3E8DE")

            let rowViews: [Components.Molecules.MultiColumnRowView] = {
                model.rowModels.map {
                    Components.Molecules.MultiColumnRowView(
                        labels: [$0.label, $0.value],
                        attributes: [LabelColumn(style: .body), LabelColumn(style: .body)]
                    )
                }
            }()

            rowContainerView.distribution = .equalSpacing

            NSLayoutConstraint.activate([
//                editButton.rightAnchor.constraint(equalTo: rowContainerView.rightAnchor)
            ])

            switch model.mode {
            case .view:
                rowContainerView.set(viewsToSeparate: rowViews)
                button.setTitle(model.viewButtonTitle, for: .normal)
            case .edit:
                rowContainerView.set(viewsToSeparate: rowViews.map {
                    $0.addSubview(editButton)
                    return $0
                })
                button.setTitle(model.editButtonTitle, for: .normal)
            }
        }
        
        @objc private func buttonTapped() {
            guard let model = self.model else { return }
            
            let newModel = Model(
                title: model.title,
                rowModels: model.rowModels,
                viewButtonTitle: model.viewButtonTitle,
                editButtonTitle: model.editButtonTitle,
                mode: model.mode == .view ? .edit : .view
            )
            
            updateUI(for: newModel)
        }

        @objc private func editButtonTapped() {
            print("Tapping...")
            if let url = URL(string: "https://www.hackingwithswift.com") {
                UIApplication.shared.open(url)
            }
        }
        
        // MARK: - Views
        public private(set)var titleLabel = UILabel.styled(style: .bold)
        public private(set)var rowContainerView = Components.ContainerView(config: .noLines)
        public private(set)var button = UIButton.styled(style: .secondary)
        public private(set)var editButton = UIButton.styled(style: .secondary)
    }
}
