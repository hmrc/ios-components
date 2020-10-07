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

private protocol SelectRowDelegate: class {
    func didTap(row: Components.Molecules.SelectRow)
}

extension Components.Molecules {
    public class SelectRowView: Components.Atoms.CardView, SelectRowDelegate {

        public struct Model {
            let showSeparators: Bool
            let selectedImage: UIImage?
            let deselectedImage: UIImage?
            let imageTintColor: UIColor

            let rows: [Row]

            public init(
                showSeparators: Bool = false,
                selectedImage: UIImage? = nil,
                deselectedImage: UIImage? = nil,
                imageTintColor: UIColor = UIColor.Semantic.darkText.raw,
                rows: [Row]
            ) {
                self.showSeparators = showSeparators
                if let selectedImage = selectedImage {
                    self.selectedImage = selectedImage
                } else {
                    self.selectedImage = UIImage(named: "FilledCircle", in: Bundle(for: SelectRowView.self), compatibleWith: nil)?
                        .withRenderingMode(.alwaysTemplate)
                }

                if let deselectedImage = deselectedImage {
                    self.deselectedImage = deselectedImage
                } else {
                    self.deselectedImage = UIImage(named: "EmptyCircle", in: Bundle(for: SelectRowView.self), compatibleWith: nil)?
                        .withRenderingMode(.alwaysTemplate)
                }

                self.imageTintColor = imageTintColor
                self.rows = rows
            }

            public struct Row {
                let isSelected: Bool
                let body: String
                let accessibilityId: String?

                public init(
                    isSelected: Bool = false,
                    body: String,
                    accessibilityId: String? = nil
                ) {
                    self.isSelected = isSelected
                    self.body = body
                    self.accessibilityId = accessibilityId
                }
            }
        }

        public var tapHandler: IntHandler?
        public private(set) var rows = [SelectRow]()

        public required init(model: Model) {
            super.init(components: [])
            if !model.showSeparators { stackView.spacing = 0 }
            let rows = configureRowView(for: model)
            addComponents(rows)
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("init coder not implemented")
        }

        private func configureRowView(for model: Model) -> [UIView] {
            var rows = model.rows.enumerated().map { (index, row) -> SelectRow in
                let model = SelectRow.Model(
                    isSelected: row.isSelected,
                    selectedImage: model.selectedImage,
                    deselectedImage: model.deselectedImage,
                    imageTintColor: model.imageTintColor,
                    body: row.body,
                    accessibilityHelper: .init(
                        accessibilityId: row.accessibilityId ?? "",
                        index: index + 1,
                        total: model.rows.count
                    ),
                    shouldAdjustForSeparators: model.showSeparators
                )

                let row = SelectRow(model: model)
                row.delegate = self
                self.rows.append(row)
                return row
            }.reduce([UIView]()) { (result: [UIView], next: SelectRow) -> [UIView] in
                var result = result
                result.append(next)
                if model.showSeparators {
                    result.append(createSeparator())
                }
                return result
            }

            if model.showSeparators {
                rows.removeLast()
            }

            return rows
        }

        private func createSeparator() -> UIView {
            return SeparatorView(config: .init(
                separatorFirst: true,
                includeMiddle: false,
                includeLast: false,
                backgroundColor: .clear,
                separatorColor: UIColor.Semantic.divider.raw,
                dividerLineThickness: 1.0,
                totalThickness: 1.0,
                layoutMargins: .zero,
                createSeparator: nil)
            )
        }

        fileprivate func didTap(row: SelectRow) {
            let rowViews = self.components.filter { $0 is SelectRow }

            guard let selectRows = rowViews as? [SelectRow] else { return }

            selectRows.forEach { $0.isSelected = false }
            row.isSelected = true

            guard let index = selectRows.firstIndex(of: row) else { return }
            tapHandler?(index)
        }
    }

    public class SelectRow: UIView {

        struct Model {
            let isSelected: Bool
            let selectedImage: UIImage?
            let deselectedImage: UIImage?
            let imageTintColor: UIColor
            let body: String
            let accessibilityHelper: AccessibilityHelper
            let shouldAdjustForSeparators: Bool

            struct AccessibilityHelper {
                let accessibilityId: String
                let index: Int
                let total: Int
            }
        }

        private struct Constants {
            static let touchMargin: CGFloat = 10
        }

        private lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

        public lazy var bodyLabel: UILabel = {
            let label = UILabel.styled(style: .body)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        public lazy var backgroundButton: UIButton = {
            let button = UIButton.styled(style: .secondary)
            button.addTarget(self, action: #selector(backgroundButtonTapped), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        private let model: Model

        private var selectedImage: UIImage!
        private var deselectedImage: UIImage!

        fileprivate weak var delegate: SelectRowDelegate?

        var isSelected = false {
            didSet {
                self.update(selected: isSelected)
            }
        }

        required init(model: Model) {
            self.model = model
            super.init(frame: .zero)

            addSubviews()
            setupConstraints(shouldAdjustForSeparators: model.shouldAdjustForSeparators)
            setupAccessibility()
            configure(model: model)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("Not implemented")
        }

        private func addSubviews() {
            addSubview(backgroundButton)
            addSubview(imageView)
            addSubview(bodyLabel)
        }

        private func setupConstraints(shouldAdjustForSeparators: Bool) {
            bodyLabel.setContentHuggingPriority(.required, for: .vertical)
            bodyLabel.setContentCompressionResistancePriority(.required, for: .vertical)

            if shouldAdjustForSeparators {
                NSLayoutConstraint.activate([
                    backgroundButton.leftAnchor.constraint(equalTo: leftAnchor, constant: -(Constants.touchMargin)),
                    backgroundButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.touchMargin),
                    backgroundButton.topAnchor.constraint(equalTo: topAnchor, constant: -(Constants.touchMargin)),
                    backgroundButton.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.touchMargin),

                    imageView.widthAnchor.constraint(equalToConstant: .spacer24),
                    imageView.heightAnchor.constraint(equalToConstant: .spacer24),
                    imageView.topAnchor.constraint(equalTo: topAnchor),
                    imageView.leftAnchor.constraint(equalTo: leftAnchor),

                    bodyLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
                    bodyLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: .spacer8),
                    bodyLabel.heightAnchor.constraint(greaterThanOrEqualTo: imageView.heightAnchor),
                    bodyLabel.rightAnchor.constraint(equalTo: rightAnchor),

                    bottomAnchor.constraint(equalTo: bodyLabel.bottomAnchor)
                ])
            } else {
                NSLayoutConstraint.activate([
                    backgroundButton.leftAnchor.constraint(equalTo: leftAnchor),
                    backgroundButton.bottomAnchor.constraint(equalTo: bottomAnchor),
                    backgroundButton.topAnchor.constraint(equalTo: topAnchor),
                    backgroundButton.rightAnchor.constraint(equalTo: rightAnchor),

                    imageView.widthAnchor.constraint(equalToConstant: .spacer24),
                    imageView.heightAnchor.constraint(equalToConstant: .spacer24),
                    imageView.leftAnchor.constraint(equalTo: leftAnchor),

                    bodyLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
                    bodyLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: .spacer8),
                    bodyLabel.heightAnchor.constraint(greaterThanOrEqualTo: imageView.heightAnchor),
                    bodyLabel.rightAnchor.constraint(equalTo: rightAnchor),

                    topAnchor.constraint(equalTo: bodyLabel.topAnchor, constant: -(Constants.touchMargin)),
                    bottomAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: Constants.touchMargin)
                ])
            }
        }

        private func configure(model: Model) {
            bodyLabel.text = model.body
            isSelected = model.isSelected
            updateAccessibility(isSelected: isSelected)
            backgroundButton.accessibilityIdentifier = model.accessibilityHelper.accessibilityId

            self.selectedImage = model.selectedImage
            self.deselectedImage = model.deselectedImage

            imageView.tintColor = model.imageTintColor
            updateImage(isSelected: isSelected)
        }

        private func updateAccessibility(isSelected: Bool) {
            let suffix: String
            if model.accessibilityHelper.total > 1 {
                 suffix = ", \(model.accessibilityHelper.index) of \(model.accessibilityHelper.total)"
            } else {
                suffix = ""
            }

            let state = isSelected ? "selected" : "not selected"

            backgroundButton.accessibilityLabel = "\(model.body), \(state), radio button\(suffix)"
        }

        private func setupAccessibility() {
            accessibilityElements = [backgroundButton]
            backgroundButton.accessibilityTraits = .none
        }

        private func updateImage(isSelected: Bool) {
            if isSelected {
                imageView.image = selectedImage
            } else {
                imageView.image = deselectedImage
            }
        }

        private func update(selected: Bool) {
            updateImage(isSelected: isSelected)
            updateAccessibility(isSelected: isSelected)
        }

        @objc private func backgroundButtonTapped() {
            isSelected.toggle()
            delegate?.didTap(row: self)
        }
    }
}
