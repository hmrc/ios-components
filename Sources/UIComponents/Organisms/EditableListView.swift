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
            public let rowEditButtonTitle: String

            public init(
                title: String,
                rows: [UIView],
                startEditingButtonTitle: String,
                startEditingButtonIcon: UIImage? = nil,
                stopEditingButtonTitle: String,
                stopEditingButtonIcon: UIImage? = nil,
                rowEditButtonTitle: String
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
                self.rowEditButtonTitle = rowEditButtonTitle
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
                    updateButton()
                    rows.forEach { $0.setEditing(isEditing, animated: true) }
                }
            }
        }
        private var rows: [EditableRowView] = []

        // MARK: - Initialisation

        public required init(model: Model?) {
            super.init(components: [titleLabel])
            removePadding()
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
            updateButton()
            self.rows = model.rows.map { EditableRowView(content: $0, isEditing: isEditing, buttonText: "Edit") {
                print("Edit row")
            } }
            setComponents([titleLabel] + rows + [editButton])
        }

        public func updateButton() {
            guard let model = model else { return }
            editButton.updateUI(
                with: isEditing ? model.stopEditingButtonTitle : model.startEditingButtonTitle,
                icon: isEditing ? model.stopEditingButtonIcon : model.startEditingButtonIcon
            )
        }
    }

    private class EditableRowView: UIView {
        public private(set)var contentView = UIView()
        public private(set)var editButton: UIButton = .styled(style: .secondary)
        private var onTapEdit: VoidHandler?

//        init(content: UIView, buttonText: String, onTapEdit: @escaping VoidHandler) {
//            super.init(frame: CGRect.zero)
//
//            addSubview(stackView)
//            stackView.axis = .horizontal
//            stackView.distribution = .equalSpacing
//            stackView.alignment = .center
//            stackView.snp.makeConstraints { make in
//                make.edges.equalTo(self.snp.margins)
//            }
//
//            self.onTapEdit = onTapEdit
//            editButton = .styled(style: .secondary, string: buttonText)
//            editButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
//            editButton.setContentCompressionResistancePriority(.required, for: .horizontal)
//            editButton.setContentCompressionResistancePriority(.required, for: .vertical)
//            editButton.setContentHuggingPriority(.required, for: .horizontal)
//            editButton.setContentHuggingPriority(.required, for: .vertical)
//
//            content.setContentCompressionResistancePriority(.required, for: .horizontal)
//            content.setContentCompressionResistancePriority(.required, for: .vertical)
//            content.setContentHuggingPriority(.defaultLow, for: .horizontal)
//            content.setContentHuggingPriority(.defaultHigh, for: .vertical)
//
//            stackView.addArrangedSubviews([content, editButton])
//        }

        private var cnsContentRight: NSLayoutConstraint?

        init(content: UIView, isEditing: Bool, buttonText: String, onTapEdit: @escaping VoidHandler) {
            super.init(frame: CGRect.zero)

            self.onTapEdit = onTapEdit
            editButton = .styled(style: .secondary, string: buttonText)
            editButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            addSubview(editButton)

            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.backgroundColor = UIColor.Semantic.cardBackground
            addSubview(contentView)
            contentView.addSubview(content)

            self.cnsContentRight = content.rightAnchor.constraint(equalTo: rightAnchor, constant: inset(isEditing: isEditing))
            NSLayoutConstraint.activate([
                content.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: .spacer16),
                content.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -.spacer16),
                content.topAnchor.constraint(equalTo: contentView.topAnchor),
                content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                editButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -.spacer16),
                editButton.topAnchor.constraint(equalTo: topAnchor),
                editButton.bottomAnchor.constraint(equalTo: bottomAnchor),
                contentView.leftAnchor.constraint(equalTo: leftAnchor),
                contentView.topAnchor.constraint(equalTo: topAnchor),
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
                cnsContentRight!
            ])
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("Init With Coder not implemented")
        }

        @objc func didTapButton(_ sender: UIButton) {
            onTapEdit?()
        }

        private func inset(isEditing: Bool) -> CGFloat {
            return isEditing ? -(editButton.frame.width + .spacer16 + .spacer16) : -.spacer16
        }

        public func setEditing(_ isEditing: Bool, animated: Bool) {
            self.cnsContentRight?.constant = inset(isEditing: isEditing)
            UIView.animate(withDuration: animated ? 0.3 : 0) {
                self.layoutIfNeeded()
                self.contentView.layoutIfNeeded()
            }
        }
    }
}
