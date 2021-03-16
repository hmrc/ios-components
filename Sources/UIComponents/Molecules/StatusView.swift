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

extension Components.Molecules {

    open class StatusView: DebugOverlayableView {

        private struct Constants {
            static let itemSpacing: CGFloat = 24
        }

        open class Model {
            public let icon: UIImage
            public let title: String
            public let body: NSAttributedString?
            public let buttonModel: ButtonModel?
            public let iconTintColor: UIColor?

            public init(icon: UIImage!,
                        title: String,
                        body: NSAttributedString? = nil,
                        buttonModel: ButtonModel? = nil,
                        iconTintColor: UIColor? = nil) {
                self.icon = icon
                self.title = title
                self.body = body
                self.buttonModel = buttonModel
                self.iconTintColor = iconTintColor
            }

            public init(icon: UIImage!,
                        title: String,
                        body: String?,
                        buttonModel: ButtonModel? = nil,
                        iconTintColor: UIColor? = nil) {
                self.icon = icon
                self.title = title
                if let body = body {
                    self.body = NSMutableAttributedString.styled(
                        style: .body,
                        string: body
                    )
                } else {
                    self.body = nil
                }
                self.buttonModel = buttonModel
                self.iconTintColor = iconTintColor
            }

            public struct ButtonModel {
                public let title: String
                public let accessibilityIdentifier: String?
                public var actionBlock: ActionBlock

                public init(title: String,
                            accessibilityIdentifier: String? = nil,
                            actionBlock: @escaping ActionBlock) {
                    self.title = title
                    self.accessibilityIdentifier = accessibilityIdentifier
                    self.actionBlock = actionBlock
                }
            }
        }

        // MARK: - Views

        public let stackView = UIStackView()

        public let iconContainerView = UIView()
        public let iconImageView = UIImageView()
        public let titleLabel = UILabel.styled(style: .H5)
        public let bodyTextView = UILabel.styled(style: .body)
        public var button: UIButton?

        // MARK: - Initialisation

        public required init() {
            super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
            commonInit()
        }

        public required init(model: Model) {
            super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
            commonInit(model: model)
            updateUI(for: model)
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("Init With Coder not implemented")
        }

        open func commonInit(model: Model? = nil) {
            setupStackView()
            setupStyle()
            addViews(model: model)
            disableTranslatesAutoresizingMaskIntoConstraints()
            setupConstraints()
        }

        func addViews(model: Model? = nil) {
            var components = [
                iconContainerView,
                titleLabel,
                bodyTextView
            ]
            if let model = model,
                model.buttonModel != nil {
                button = UIButton.styled(style: .secondary)
                button!.translatesAutoresizingMaskIntoConstraints = false
                button!.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: .spacer12, right: 0)
                components.append(button!)
            }
            addSubview(stackView)
            iconContainerView.addSubview(iconImageView)
            components.forEach { component in
                stackView.addArrangedSubview(component)
                NSLayoutConstraint.activate([
                    component.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                    component.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
                ])
            }
        }

        private func setupStackView() {
            stackView.spacing = Constants.itemSpacing
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.alignment = .center
        }

        private func disableTranslatesAutoresizingMaskIntoConstraints() {
            translatesAutoresizingMaskIntoConstraints = false
        }

        private func setupStyle() {
            titleLabel.textAlignment = .center
            bodyTextView.textAlignment = .center
            iconImageView.contentMode = .scaleAspectFit
            bodyTextView.backgroundColor = UIColor.clear
        }

        private func setupConstraints() {
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
                stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
                stackView.heightAnchor.constraint(equalTo: heightAnchor),
                stackView.widthAnchor.constraint(equalTo: widthAnchor)
            ])
            iconContainerView.translatesAutoresizingMaskIntoConstraints = false
            iconImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                iconImageView.topAnchor.constraint(equalTo: iconContainerView.topAnchor),
                iconImageView.bottomAnchor.constraint(equalTo: iconContainerView.bottomAnchor),
                iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
                iconImageView.heightAnchor.constraint(equalToConstant: 100),
                iconImageView.widthAnchor.constraint(equalToConstant: 100)
            ])
        }

        public func updateUI(for model: Model) {
            titleLabel.text = model.title
            if let body = model.body {
                bodyTextView.attributedText = body.withAlignment(body.getAlignment() ?? .center)
            }
            bodyTextView.isHidden = (model.body == nil)
            iconImageView.image = model.icon

            iconImageView.tintColor = model.iconTintColor ?? UIColor.Semantic.statusCardIconDefaultTint.raw
            if let button = self.button,
                let buttonModel = model.buttonModel {
                button.update(with: .init(
                    style: .secondary,
                    visible: true,
                    title: buttonModel.title,
                    alignment: .center,
                    accessibilityIdentifier: buttonModel.accessibilityIdentifier)
                )
                button.componentAction(block: buttonModel.actionBlock)
            }
        }
    }
}
