/*
 * Copyright 2019 HM Revenue & Customs
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

extension Components.Molecules {
    public struct SelectableRowContent {
        let label: String
        let accessibilityIdentifier: String

        public init(label: String, accessibilityIdentifier: String) {
            self.label = label
            self.accessibilityIdentifier = accessibilityIdentifier
        }
    }

    public class SelectRowGroupView: Components.Atoms.CardView {

        public let titleLabel = UILabel.styled(style: .H5)
        public let subTitleLabel = UILabel.styled(style: .body)
        public var selectableRowGroup: Components.Molecules.SelectRowView!
        public let validationErrorLabel = UILabel.styled(style: .body)

        public private(set) var selectedIndex: Int?

        public required init(title: String, subTitle: String, rowContent: [SelectableRowContent], selectedIndex: Int?) {
            titleLabel.text = title
            subTitleLabel.text = subTitle
            self.selectedIndex = selectedIndex

            super.init(components: [])

            backgroundColor = UIColor.Semantic.cardBackground
            layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: .spacer16, right: 0)

            var components = [UIView]()
            if !title.isEmpty { components.append(titleLabel)}
            if !subTitle.isEmpty { components.append(subTitleLabel)}

            components.append(contentsOf: [
                validationErrorLabel,
                makeSelectableRowGroup(
                    rowContent: rowContent,
                    selectedIndex: selectedIndex
                )
            ])

            super.addComponents(components)

            stackView.setCustomSpacing(0, after: validationErrorLabel)
        }

        private func makeSelectableRowGroup(rowContent: [SelectableRowContent], selectedIndex: Int?) -> Components.Molecules.SelectRowView {
            let rows = rowContent.enumerated().map { (index, singleRowContent) -> Components.Molecules.SelectRowView.Model.Row in

                return Components.Molecules.SelectRowView.Model.Row(
                    isSelected: (index == selectedIndex),
                    body: singleRowContent.label,
                    accessibilityId: singleRowContent.accessibilityIdentifier
                )
            }
            let selectableRowGroupModel = Components.Molecules.SelectRowView.Model(rows: rows)
            selectableRowGroup = Components.Molecules.SelectRowView(
                model: selectableRowGroupModel
            )
            selectableRowGroup.tapHandler = { [unowned self] (index) in
                self.set(validationError: "")
                self.selectedIndex = index
            }
            selectableRowGroup.layoutMargins = .zero
            return selectableRowGroup
        }

        public func set(validationError: String?, changeVisibilityIfNeeded: Bool = true) {
            if changeVisibilityIfNeeded {
                if let error = validationError, !error.isEmpty {
                    set(validationErrorVisible: true, animate: true)
                } else {
                    set(validationErrorVisible: false, animate: true)
                }
            }

            validationErrorLabel.text = validationError

            UIAccessibility.post(notification: .layoutChanged, argument: validationErrorLabel)

            updateColors()
        }

        private func set(validationErrorVisible: Bool, animate: Bool = true) {
            let duration = animate ? 0.3 : 0
            let alpha: CGFloat = validationErrorVisible ? 1.0 : 0.0

            UIView.animate(withDuration: duration, animations: {
                self.validationErrorLabel.alpha = alpha
            }, completion: { (done) in
                if done {
                    self.validationErrorLabel.alpha = alpha
                }
            })
        }

        private func updateColors() {
            validationErrorLabel.textColor = UIColor.Semantic.errorText
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
