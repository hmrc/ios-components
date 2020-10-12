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

public class IconButtonWithDisclosure: Components.Helpers.ViewWithCustomDisclosure, Component {
    private var model: Model?

    // MARK: - Model

    public struct Model {
        public let title: String
        public let icon: UIImage?
        public let textColor: UIColor
        public let iconColor: UIColor?
        public let disclosureColor: UIColor
        public let customSelectedStateColor: UIColor?
        public let buttonContentInsets: UIEdgeInsets
        public let accessibilityIdentifier: String?

        public init(
            title: String,
            icon: UIImage? = nil,
            textColor: UIColor,
            iconColor: UIColor? = nil,
            disclosureColor: UIColor,
            customSelectedStateColor: UIColor? = nil,
            buttonContentInsets: UIEdgeInsets = .init(
                top: .spacer8,
                left: 0,
                bottom: .spacer8,
                right: 0
            ),
            accessibilityIdentifier: String? = nil
        ) {
            self.title = title
            self.icon = icon
            self.textColor = textColor
            self.iconColor = iconColor
            self.disclosureColor = disclosureColor
            self.customSelectedStateColor = customSelectedStateColor
            self.buttonContentInsets = buttonContentInsets
            self.accessibilityIdentifier = accessibilityIdentifier
        }
    }

    public var action: VoidHandler? {
        didSet {
            disclosureImageView.tintColor = action != nil ? model?.disclosureColor : .clear
        }
    }

    required public init(model: Model?) {
        self.model = model
        super.init(frame: .zero)
        if let model = self.model {
            updateUI(for: model)
        }
    }

    public override func commonInit() {
        addSubview(button)
        super.commonInit()

        isAccessibilityElement = true
        accessibilityTraits = [.button]

        if hasIcon {
            let iconImageViewContainer: UIView = .build()
            NSLayoutConstraint.activate([
                iconImageViewContainer.widthAnchor.constraint(equalToConstant: 24)
            ])

            let iconImageView: UIImageView = .build {
                $0.contentMode = .scaleAspectFit
            }
            iconImageViewContainer.addSubview(iconImageView)
            NSLayoutConstraint.activate([
                iconImageView.heightAnchor.constraint(equalToConstant: 24),
                iconImageView.widthAnchor.constraint(equalToConstant: 24),
                iconImageView.centerXAnchor.constraint(equalTo: iconImageViewContainer.centerXAnchor),
                iconImageView.centerYAnchor.constraint(equalTo: iconImageViewContainer.centerYAnchor)
            ])
            contentViewStack.addArrangedSubviews([iconImageViewContainer, titleLabel])
            self.iconImageViewContainer = iconImageViewContainer
            self.iconImageView = iconImageView
        } else {
            contentViewStack.addArrangedSubviews([titleLabel])
        }

        NSLayoutConstraint.activate([
            disclosureImageView.heightAnchor.constraint(equalToConstant: 24),
            disclosureImageView.widthAnchor.constraint(equalToConstant: 24)
        ])

        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: leftAnchor),
            button.rightAnchor.constraint(equalTo: rightAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        button.action = { [unowned self] in
            self.action?()
        }
        button.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside)
        translatesAutoresizingMaskIntoConstraints = false

        setNeedsUpdateConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateUI(for model: Model) {
        self.model = model
        titleLabel.textColor = model.textColor
        disclosureImageView.tintColor = .clear
        iconImageView?.image = model.icon
        iconImageView?.tintColor = model.iconColor
        titleLabel.text = model.title
        accessibilityLabel = model.title
        layoutMargins = model.buttonContentInsets
        accessibilityIdentifier = model.accessibilityIdentifier
        button.config = .init(
            normalColour: .clear,
            highlightColour: model.customSelectedStateColor ?? UIColor.Semantic.secondaryButtonHighlightedBackground.raw,
            disabledColour: .clear
        )
    }

    private var hasIcon: Bool {
        model?.icon != nil
    }

    // MARK: - Views

    public private(set) var button: TransparentButton = .build()
    public private(set)var disclosureImageView = UIImageView(
        image: UIImage(
            named: "ChevronRight",
            in: Bundle(
                for: IconButtonWithDisclosure.self
            ),
            compatibleWith: nil
        )
    )
    public private(set) var contentViewStack: TouchPassThroughStackView = .build {
        $0.isUserInteractionEnabled = false
        $0.axis = .horizontal
        $0.spacing = .spacer8
    }
    public private(set) var titleLabel = TouchPassThroughLabel.styled(style: .body)
    public private(set) var iconImageView: UIImageView?
    public private(set) var iconImageViewContainer: UIView?

    // MARK: - ViewWithCustomDisclosure Overrides

    public override func createContentView() -> UIView {
        return contentViewStack
    }

    public override func createDisclosureView() -> UIView {
        return disclosureImageView
    }

    // MARK: - Button handlers

    @objc private func buttonTouchDown() {
        resetButtonState()
    }

    @objc private func buttonTouchUp() {
        resetButtonState()
    }

    private func resetButtonState() {
        iconImageView?.tintColor = model?.iconColor
        titleLabel.textColor = model?.textColor
        disclosureImageView.tintColor = model?.disclosureColor
    }
}
