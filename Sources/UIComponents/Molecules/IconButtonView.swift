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
    open class IconButtonView: DebugOverlayableView {

        public var didTapButton: ActionBlock?

        public struct Constants {
            public static let itemSpacing: CGFloat = 12
        }

        let containerView = UIView.build()
        public let titleLabel = UILabel.buildLinkLabel()
        public let iconImageView: UIImageView = .build()
        public let actionButton: UIButton = TransparentButton.build()

        private var iconImageViewBottomConstraint: NSLayoutConstraint?
        private var iconImageViewWidthConstraint: NSLayoutConstraint?
        private var titleLabelLeftConstraint: NSLayoutConstraint?

        private var boundsObservation: NSKeyValueObservation?

        public convenience init(
            title: String,
            accessibilityHint: String? = nil,
            accessibilityIdentifier: String? = nil,
            icon: UIImage? = nil
        ) {
            self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            updateUI(
                with: title,
                accessibilityHint: accessibilityHint,
                accessibilityIdentifier: accessibilityIdentifier,
                icon: icon
            )
        }

        public override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("Dont call this.")
        }

        deinit {
            setObserveLabelBoundsChange(false)
        }

        open func commonInit() {
            self.layoutMargins = .standardCard
            setupViews()
            setupStyle()
            setupAccessibility()
            setContraints()
            setupTouchHandlers()
            disableTranslatesAutoresizingMaskIntoConstraints()
            setObserveLabelBoundsChange(true)
        }

        private func setupStyle() {
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = UIColor.Semantic.linkText.raw
        }

        private func setupViews() {
            containerView.backgroundColor = .clear
            addSubview(containerView)
            containerView.addSubview(iconImageView)
            containerView.addSubview(titleLabel)
            addSubview(actionButton)
            containerView.isUserInteractionEnabled = false
        }

        private func setupTouchHandlers() {
            (actionButton as? TransparentButton)?.action = {[weak self] in
                guard let self = self else { return }
                self.didTapButton?(self.actionButton)
            }
        }

        private func setupAccessibility() {
            self.isAccessibilityElement = true
            self.accessibilityTraits = UIAccessibilityTraits.button
        }

        private func setContraints() {
            iconImageViewWidthConstraint = iconImageView.widthAnchor.constraint(equalToConstant: .spacer24)
            iconImageViewBottomConstraint = iconImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            titleLabelLeftConstraint = titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: Constants.itemSpacing)
            
            let titleLabelContainerViewBottomConstraint = titleLabel.bottomAnchor.constraint(greaterThanOrEqualTo: iconImageView.bottomAnchor)
            titleLabelContainerViewBottomConstraint.priority = UILayoutPriority(250)
            
            let containerHeightConstraint = containerView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
            containerHeightConstraint.priority = UILayoutPriority(1000)

            NSLayoutConstraint.activate([
                actionButton.leftAnchor.constraint(equalTo: leftAnchor),
                actionButton.rightAnchor.constraint(equalTo: rightAnchor),
                actionButton.topAnchor.constraint(equalTo: topAnchor),
                actionButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
                
                iconImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
                iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
                iconImageView.heightAnchor.constraint(equalToConstant: FontMetrics.scaledValue(for: .spacer24)),
                iconImageViewWidthConstraint!,
                
                titleLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
                titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
                titleLabelContainerViewBottomConstraint,
                titleLabelLeftConstraint!,
                containerHeightConstraint,
                
                containerView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
                containerView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                containerView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
                containerView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            ])
        }

        private func disableTranslatesAutoresizingMaskIntoConstraints() {
            translatesAutoresizingMaskIntoConstraints = false
        }

        private func setContentPriority() {
            containerView.setContentHuggingPriority(.required, for: .horizontal)
            containerView.setContentCompressionResistancePriority(.required, for: .horizontal)
            containerView.setContentHuggingPriority(.required, for: .vertical)
            containerView.setContentCompressionResistancePriority(.required, for: .vertical)
            titleLabel.setContentHuggingPriority(.required, for: .vertical)
            titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            titleLabel.setContentHuggingPriority(.required, for: .horizontal)
            titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        }

        private func setObserveLabelBoundsChange(_ observe: Bool) {
            if observe {
                boundsObservation = titleLabel.observe(\.bounds) { [weak self] (label, _) in
                    self?.iconImageViewBottomConstraint?.isActive = !(label.numberOfLines > 1)
                }
            } else {
                boundsObservation?.invalidate()
            }
        }

        public func updateUI(
            with title: String,
            accessibilityHint: String? = nil,
            accessibilityIdentifier: String? = nil,
            icon: UIImage? = nil
        ) {
            titleLabel.text = title

            self.accessibilityLabel = title
            self.accessibilityHint = accessibilityHint
            self.accessibilityIdentifier = accessibilityIdentifier

            iconImageViewWidthConstraint?.isActive = false
            titleLabelLeftConstraint?.isActive = false

            if let icon = icon {
                iconImageView.image = icon.withRenderingMode(.alwaysTemplate)
                iconImageView.isHidden = false

                iconImageViewWidthConstraint = iconImageView.widthAnchor.constraint(equalToConstant: .spacer24)
                titleLabelLeftConstraint = titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: Constants.itemSpacing)
            } else {
                iconImageView.isHidden = true

                iconImageViewWidthConstraint = iconImageView.widthAnchor.constraint(equalToConstant: .zero)
                titleLabelLeftConstraint = titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor)
            }
            NSLayoutConstraint.activate([
                iconImageViewWidthConstraint!,
                titleLabelLeftConstraint!
            ])
            self.setNeedsUpdateConstraints()
        }
    }
}
