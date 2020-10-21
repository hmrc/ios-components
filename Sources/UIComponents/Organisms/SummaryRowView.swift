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
import SnapKit

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

            public init(title: String,
                        rowViews: [Components.Molecules.MultiColumnRowView],
                        icon: UIImage? = nil,
                        accessibilityIdentifier: String? = nil,
                        accessibilityLabel: String? = nil,
                        accessibilityHint: String? = nil) {
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
            if let model = model {
                self.updateUI(for: model)
            }
        }

        open override func commonInit() {
            self.addSubview(button)
            super.commonInit()

            stackView.isUserInteractionEnabled = false

            rowContainerView.spacing = .spacer8

            disclosureImageView.tintColor = .clear
            disclosureImageView.snp.makeConstraints { (make) in
                make.height.equalTo(24)
                make.width.equalTo(24)
            }

            button.isEnabled = false
            button.snp.makeConstraints { (make) in
                make.edges.equalTo(self)
            }

            if let button = button as? TransparentButton {
                button.config = TransparentButton.StateConfig(
                    normalColour: .clear,
                    highlightColour: UIColor.Semantic.transparentButtonHighlightedBackground.raw,
                    disabledColour: .clear
                )
                button.action = { [weak self] in
                    self?.action?()
                }
            }

            let margin = CGFloat.spacer16
            self.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
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
        public private(set)var disclosureImageView = UIImageView(
            image: UIImage(
                named: "ChevronRight",
                in: Bundle.module,
                compatibleWith: nil
            )
        )

        public private(set)var button: UIButton = TransparentButton()
        public private(set)var contentViewStack = UIStackView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        public private(set)var titleLabel = UILabel.styled(style: .bold)
        public private(set)var rowContainerView = Components.ContainerView(config: .noLines)

        private lazy var imageContainerView: UIView = {
            let view = UIView(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.widthAnchor.constraint(equalToConstant: 44).isActive = true
            view.backgroundColor = .clear
            view.setContentHuggingPriority(.defaultHigh, for: .vertical)
            view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
            view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
            return view
        }()

        private lazy var verticalStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = .spacer8
            stackView.setContentHuggingPriority(.defaultLow, for: .vertical)
            stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
            stackView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
            stackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            return stackView
        }()

        private lazy var iconImageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = UIColor.Components.Named.blue
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

        // MARK: - ViewWithCustomDisclosure Overrides

        open override func createContentView() -> UIView {
            return contentViewStack
        }

        open override func createDisclosureView() -> UIView {
            return disclosureImageView
        }
    }
}
