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

extension Components.Organisms {

    open class EditableListView: Components.Atoms.CardView, Component {

        // MARK: - Model

        public class Model {
            public let title: String
            public let rows: [UIView]
            public let startEditingButtonTitle: String
            public let startEditingButtonIcon: UIImage?
            public let stopEditingButtonTitle: String
            public let stopEditingButtonIcon: UIImage?

            public init(
                title: String,
                rows: [UIView],
                startEditingButtonTitle: String,
                startEditingButtonIcon: UIImage?,
                stopEditingButtonTitle: String,
                stopEditingButtonIcon: UIImage?
            ) {
                self.title = title
                self.rows = rows
                self.startEditingButtonTitle = startEditingButtonTitle
                self.startEditingButtonIcon = startEditingButtonIcon ?? UIImage(
                    named: "Edit",
                    in: Bundle.resource,
                    compatibleWith: nil
                )?.withRenderingMode(.alwaysTemplate)
                self.stopEditingButtonTitle = stopEditingButtonTitle
                self.stopEditingButtonIcon = stopEditingButtonIcon ?? UIImage(
                    named: "Tick",
                    in: Bundle.resource,
                    compatibleWith: nil
                )?.withRenderingMode(.alwaysTemplate)
            }
        }

        // MARK: - Views

        public let titleLabel = UILabel.buildH5Label()
        public let editButton = Components.Molecules.IconButtonView()

        // MARK: - Variables

        private var model: Model?
        private var isEditing: Bool = false {
            didSet {
                if let model = model {
                    updateUI(for: model)
                }
            }
        }

        // MARK: - Initialisation

        public required init(model: Model?) {
            super.init(components: [titleLabel])
            editButton.didTapButton = { [unowned self] _ in
                self.isEditing = !self.isEditing
            }
            if let model = model {
                updateUI(for: model)
            }
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("Init With Coder not implemented")
        }

        public func updateUI(for model: Model) {
            let hasChanged = self.model !== model
            self.model = model
            titleLabel.attributedText = NSMutableAttributedString.styled(
                style: .H5,
                string: model.title
            )
            editButton.updateUI(
                with: isEditing ? model.stopEditingButtonTitle : model.startEditingButtonTitle,
                icon: isEditing ? model.stopEditingButtonIcon : model.startEditingButtonIcon
            )
            setComponents([titleLabel] + model.rows + [editButton])
            if hasChanged {
                // animate
            }
        }
    }
}
