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
import SnapKit

extension Components.Organisms {
    open class EditRowCardView: Components.Atoms.CardView, Component {

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
            stackView.setCustomSpacing(.spacer24, after: rowContainerView)

            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

            if let model = model {
                updateUI(for: model)
            }
        }

        public func updateUI(for model: Model) {
            self.model = model
            titleLabel.text = model.title

            let rowViews: [Components.Molecules.MultiColumnRowView] = {
                switch model.mode {
                case .view:
                    return model.rowModels.map {
                        Components.Molecules.MultiColumnRowView(
                            labels: [$0.label, $0.value, ""],
                            attributes: [LabelColumn(style: .body), LabelColumn(style: .body), LabelColumn(style: .body)]
                        )
                    }
                case .edit:
                    return model.rowModels.map {
                        Components.Molecules.MultiColumnRowView(
                            labels: [$0.label, $0.value, "Edit"],
                            attributes: [LabelColumn(style: .body), LabelColumn(style: .body), LabelColumn(style: .link)]
                        )
                    }
                }
            }()
            rowContainerView.set(viewsToSeparate: rowViews)

            switch model.mode {
            case .view:
                button.setTitle(model.viewButtonTitle, for: .normal)
            case .edit:
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

        // MARK: - Views

        public private(set)var titleLabel = UILabel.styled(style: .bold)
        public private(set)var rowContainerView = Components.ContainerView(config: .noLines)
        public private(set)var button = UIButton.styled(style: .primary(true))
    }
}
