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

extension Components.Organisms {
    open class SummaryRowView: Components.Helpers.ViewWithCustomDisclosure, Component {
        public enum ReaderTrait {
            //Specifies that the row will be read out as one element by screen reader
            case simple
            //Specifies that the row will be read out element by element when read by screen reader
            case info
            //Specifies that the row will be read out title, button, row view labels by screen reader
            case menu
        }

        private var model: Model?

        // MARK: - Model
        public struct Model {
            public let title: String
            public let rowViews: [Components.Molecules.MultiColumnRowView]
            public let icon: UIImage?
            public let accessibilityIdentifier: String?
            public let accessibilityLabel: String?
            public let accessibilityHint: String?

            public init(
                title: String,
                rowViews: [Components.Molecules.MultiColumnRowView],
                icon: UIImage? = nil,
                accessibilityIdentifier: String? = nil,
                accessibilityLabel: String? = nil,
                accessibilityHint: String? = nil
            ) {
                self.title = title
                self.rowViews = rowViews
                self.icon = icon
                self.accessibilityIdentifier = accessibilityIdentifier
                self.accessibilityLabel = accessibilityLabel
                self.accessibilityHint = accessibilityHint
            }
        }

        public var action: VoidHandler? {
            didSet {
                button.isEnabled = action != nil
                disclosureImageView.tintColor = action != nil ? UIColor.Semantic.darkText.raw : .clear

                updateForReaderTrait()
            }
        }

        public var suppressDisclosureView: Bool = false {
            didSet {
                self.disclosureView?.isHidden = suppressDisclosureView
            }
        }

        private var accessibilityLabelSuffix = ""
        public func suffixAccessibilityLabel(rowIndex: Int, rowCount: Int) {
            accessibilityLabelSuffix = ", row \(rowIndex + 1) of \(rowCount)"
            updateForReaderTrait()
        }

        ///Controls how screen reader interacts with this row
        public var readerTrait: ReaderTrait = .info {
            didSet {
                updateForReaderTrait()
            }
        }

        public func setReader(trait: ReaderTrait) -> Self {
            self.readerTrait = trait
            return self
        }

        private func updateForReaderTrait() {
            switch readerTrait {
            case .simple:
                accessibilityElements = [button]

                if let model = model {
                    let rows = model.rowViews.map {
                        $0.labels.compactMap { $0.text }.joined(separator: " ")
                    }
                    let labels = [model.title] + rows
                    let accessibilityLabel = labels.joined(separator: "\n") + accessibilityLabelSuffix

                    button.accessibilityLabel = model.accessibilityLabel ?? accessibilityLabel

                    button.accessibilityHint = model.accessibilityHint
                }
            case .info:
                if action != nil {
                    accessibilityElements = [titleLabel, rowContainerView, button]
                    if let accessibilityLabel = model?.accessibilityLabel {
                        button.accessibilityLabel = accessibilityLabel + accessibilityLabelSuffix
                    }
                    button.accessibilityHint = model?.accessibilityHint
                } else {
                    accessibilityElements = [titleLabel, rowContainerView]
                }
            case .menu:
                accessibilityElements = [button]
                if let model = model {
                    let rows = model.rowViews.map {
                        $0.labels.compactMap { $0.text }.joined(separator: " ")
                    }

                    let labels = [model.title, "button"] + rows

                    let accessibilityLabel = labels.joined(separator: "\n") + accessibilityLabelSuffix

                    button.accessibilityLabel = model.accessibilityLabel ?? accessibilityLabel
                    button.accessibilityTraits = [.none]
                }
            }
        }

        public required init(model: Model?) {
            super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
            translatesAutoresizingMaskIntoConstraints = false
            if let model = model {
                self.updateUI(for: model)
            }
        }

        open override func commonInit() {
            self.addSubview(button)
            super.commonInit()

            stackView.isUserInteractionEnabled = false
            NSLayoutConstraint.activate([
                disclosureImageView.heightAnchor.constraint(equalToConstant: .spacer24),
                disclosureImageView.widthAnchor.constraint(equalToConstant: .spacer24),

                button.topAnchor.constraint(equalTo: topAnchor),
                button.leadingAnchor.constraint(equalTo: leadingAnchor),
                button.widthAnchor.constraint(equalTo: widthAnchor),
                button.heightAnchor.constraint(equalTo: heightAnchor)
            ])
            button.action = { [unowned self] in
                self.action?()
            }

            self.layoutMargins = UIEdgeInsets(padding: .spacer16)
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        public func updateUI(for model: Model) {
            self.model = model
            self.titleLabel.text = model.title
            self.rowContainerView.set(viewsToSeparate: model.rowViews)
            self.accessibilityIdentifier = model.accessibilityIdentifier

            if let icon = model.icon {
                iconImageView.image = icon
                iconImageView.tintColor = UIColor.Semantic.linkText.raw
                imageContainerView.addSubview(iconImageView)
                NSLayoutConstraint.activate([
                    iconImageView.widthAnchor.constraint(equalToConstant: 28),
                    iconImageView.heightAnchor.constraint(equalToConstant: 28),
                    iconImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
                    iconImageView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor)
                ])
                verticalStackView.addArrangedSubview(titleLabel)
                verticalStackView.addArrangedSubview(rowContainerView)
                contentViewStack.addArrangedSubview(imageContainerView)
                contentViewStack.addArrangedSubview(verticalStackView)
                contentViewStack.axis = .horizontal
            } else {
                contentViewStack.addArrangedSubview(titleLabel)
                contentViewStack.addArrangedSubview(rowContainerView)
                contentViewStack.axis = .vertical
                contentViewStack.spacing = .spacer8
            }

            updateForReaderTrait()
        }

        // MARK: - Views
        // MARK: Used as disclosure view
        public private(set)var disclosureImageView: UIImageView = .build {
            $0.image = UIImage(
                named: "ChevronRight",
                in: Bundle.resource,
                compatibleWith: nil
            )
            $0.tintColor = .clear
        }

        public private(set)var button: TransparentButton = .build {
            $0.isEnabled = false
            $0.config = TransparentButton.StateConfig(
                normalColour: .clear,
                highlightColour: UIColor.Semantic.transparentButtonHighlightedBackground.raw,
                disabledColour: .clear
            )
        }
        public private(set)var contentViewStack: UIStackView = .build()
        public private(set)var titleLabel = UILabel.buildBoldLabel()
        public lazy var rowContainerView: Components.ContainerView = {
            let view = Components.ContainerView(config: .noLines)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.spacing = .spacer8
            return view
        }()

        private let imageContainerView: UIView = .build {
            $0.widthAnchor.constraint(equalToConstant: 44).isActive = true
            $0.backgroundColor = .clear
            $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
            $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        }

        private let verticalStackView: UIStackView = .build {
            $0.axis = .vertical
            $0.spacing = .spacer8
            $0.setContentHuggingPriority(.defaultLow, for: .vertical)
            $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
            $0.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
            $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }
        private let iconImageView: UIImageView = .build {
            $0.contentMode = .scaleAspectFit
            $0.tintColor = UIColor.Components.Named.blue
        }

        // MARK: - ViewWithCustomDisclosure Overrides

        open override func createContentView() -> UIView {
            return contentViewStack
        }

        open override func createDisclosureView() -> UIView {
            return disclosureImageView
        }
    }
}
