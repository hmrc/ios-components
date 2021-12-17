/*
 * Copyright 2020 HM Revenue & Customs
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
    open class MenuPanelRowView: Components.Helpers.ViewWithCustomDisclosure, Component {

        private var model: Model?

        // MARK: - Model
        public struct Model {
            public let title: String
            public let body: String
            public let notificationMode: Components.Molecules.NotificationBubbleView.NotificationMode
            public let accessibilityIdentifier: String?
            public let accessibilityHint: String?

            public init(title: String,
                        body: String,
                        notificationMode: Components.Molecules.NotificationBubbleView.NotificationMode,
                        accessibilityIdentifier: String? = nil,
                        accessibilityHint: String? = nil) {
                self.title = title
                self.body = body
                self.notificationMode = notificationMode
                self.accessibilityIdentifier = accessibilityIdentifier
                self.accessibilityHint = accessibilityHint
            }
        }

        public var action: VoidHandler? {
            didSet {
                button.isEnabled = action != nil
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
            backgroundColor = UIColor.Semantic.menuCardBackground
            stackView.isUserInteractionEnabled = false

            disclosureImageView.tintColor = UIColor.Semantic.darkText
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
                    highlightColour: UIColor.Semantic.secondaryButtonHighlightedBackground,
                    disabledColour: .clear
                )
                button.action = { [weak self] in
                    self?.action?()
                }
            }

            let margin = CGFloat.spacer24
            self.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        public func updateUI(for model: Model) {
            self.model = model
            self.titleLabel.text = model.title
            self.bodyLabel.text = model.body
            self.notificationBubble.updateUI(for: .init(notificationMode: model.notificationMode))

            isAccessibilityElement = true
            accessibilityTraits = .button
            accessibilityLabel = {
                switch model.notificationMode {
                case .hidden:
                    return model.title
                case .circle:
                    return model.title + "; new item"
                case .text(let text):
                    return model.title + "; " + text
                case .number(let count, _, let hideWhenZero):
                    if count == 0 && hideWhenZero {
                        return model.title
                    }
                    return model.title + "; \(count) new item\(count > 1 ? "s" : "")"
                }
            }()
            accessibilityHint = {
                if let hint = model.accessibilityHint, !hint.isEmpty {
                    return model.body + "; " + hint
                } else {
                    return model.body
                }
            }()
            accessibilityIdentifier = model.accessibilityIdentifier

            horizontalStackView.addArrangedSubview(titleLabel)
            horizontalStackView.addArrangedSubview(notificationBubble)
            horizontalStackView.addArrangedSubview(UIView())
            contentViewStack.addArrangedSubview(horizontalStackView)
            contentViewStack.addArrangedSubview(bodyLabel)
            contentViewStack.axis = .vertical
            contentViewStack.spacing = .spacer24
        }

        // MARK: - Views
        // MARK: Used as disclosure view
        public private(set)var disclosureImageView = UIImageView(
            image: UIImage(
                named: "ChevronRight",
                in: Bundle.resource,
                compatibleWith: nil
            )
        )

        public private(set)var button: UIButton = TransparentButton()
        public private(set)var titleStack = UIStackView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        public private(set)var contentViewStack = UIStackView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        public private(set)var notificationBubble = Components.Molecules.NotificationBubbleView(model: .init(notificationMode: .hidden))
        public private(set)var bodyLabel = UILabel.styled(style: .body)

        public lazy var titleLabel = UILabel.buildLabel(style: .H5) {
            $0.textColor = UIColor.Semantic.expandableButtonText
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
            $0.setContentHuggingPriority(.required, for: .horizontal)
        }

        private lazy var horizontalStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = FontMetrics.scaler > 1 ? .vertical : .horizontal
            stackView.spacing = .spacer8
            stackView.alignment = .leading
            stackView.setContentCompressionResistancePriority(.required, for: .vertical)
            return stackView
        }()

        // MARK: - ViewWithCustomDisclosure Overrides

        open override func createContentView() -> UIView {
            return contentViewStack
        }

        open override func createDisclosureView() -> UIView {
            disclosureImageView.accessibilityTraits = .none
            return disclosureImageView
        }
    }
}
