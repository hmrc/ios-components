/*
 * Copyright 2021 HM Revenue & Customs
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

extension Components.Molecules {
    open class MiniAdvertButtonView: DebugOverlayableView {

        public var didTapButton: ActionBlock?

        public struct Constants {
            public static let edgeSpacing: CGFloat = .spacer16
            public static let itemSpacing: CGFloat = .spacer8
            public static let iconSize: CGFloat = .spacer8
        }

        let containerView = UIView()
        public let titleLabel = UILabel.styled(style: .link)
        public let iconImageView = UIImageView()
        public let actionButton: UIButton = TransparentButton()

        private var bottomConstraint: Constraint?
        private var iconHeightConstraint: Constraint?
        private var iconWidthConstraint: Constraint?
        private var boundsObservation: NSKeyValueObservation?

        public convenience init(title: String,
                                accessibilityHint: String? = nil,
                                accessibilityIdentifier: String? = nil,
                                icon: UIImage? = nil) {
            self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            updateUI(
                with: title,
                accessibilityHint: accessibilityHint,
                accessibilityIdentifier: accessibilityIdentifier,
                icon: icon)
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
            iconImageView.tintColor = UIColor.Semantic.linkText
        }

        private func setupViews() {
            addSubview(actionButton)
            containerView.backgroundColor = .clear
            addSubview(containerView)
            containerView.addSubview(iconImageView)
            containerView.addSubview(titleLabel)
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
            let container = self.containerView
            actionButton.snp.makeConstraints { (make) in
                make.edges.equalTo(self)
            }
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(container.snp.left).offset(Constants.edgeSpacing)
                make.top.equalTo(iconImageView.snp.top).offset(Constants.edgeSpacing)
                make.right.equalTo(iconImageView.snp.left).offset(-Constants.itemSpacing)
                make.bottom.greaterThanOrEqualTo(iconImageView.snp.bottom)
                make.bottom.equalTo(container.snp.bottom)
            }
            iconImageView.snp.makeConstraints { (make) in
                make.right.equalTo(container.snp.right).offset(CGFloat.spacer16)
                make.top.equalTo(container.snp.top)
                bottomConstraint = make.bottom.equalTo(container.snp.bottom).constraint
                iconHeightConstraint = make.height.equalTo(FontMetrics.scaledValue(for: Constants.iconSize)).constraint
//                iconWidthConstraint = make.width.equalTo(FontMetrics.scaledValue(for: Constants.iconSize)).constraint
            }
            
            containerView.snp.makeConstraints { (make) in
                make.edges.equalTo(self.snp.margins)
            }
            iconHeightConstraint?.activate()
        }

        private func disableTranslatesAutoresizingMaskIntoConstraints() {
            translatesAutoresizingMaskIntoConstraints = false
            actionButton.translatesAutoresizingMaskIntoConstraints = false
            containerView.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            iconImageView.translatesAutoresizingMaskIntoConstraints = false
        }

        private func setContentPriority() {
            setContentCompressionResistancePriority(.required, for: .horizontal)
            setContentHuggingPriority(.required, for: .vertical)
            setContentHuggingPriority(.required, for: .vertical)
            setContentCompressionResistancePriority(.required, for: .vertical)
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
                    if label.numberOfVisibleLines > 1 {
                        self?.bottomConstraint?.deactivate()
                    } else {
                        self?.bottomConstraint?.activate()
                    }
                }
            } else {
                boundsObservation?.invalidate()
            }
        }

        open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            iconHeightConstraint?.deactivate()
            iconImageView.snp.makeConstraints { (make) in
                iconHeightConstraint = make.height.equalTo(FontMetrics.scaledValue(for: 24)).constraint
//                iconWidthConstraint = make.height.equalTo(FontMetrics.scaledValue(for: 24)).constraint
            }
            iconHeightConstraint?.activate()
//            iconWidthConstraint?.activate()
        }

        public func updateUI(with title: String,
                             accessibilityHint: String? = nil,
                             accessibilityIdentifier: String? = nil,
                             icon: UIImage? = nil) {
            titleLabel.text = title

            self.accessibilityLabel = title
            self.accessibilityHint = accessibilityHint
            self.accessibilityIdentifier = accessibilityIdentifier

            if let icon = icon {
                iconImageView.image = icon.withRenderingMode(.alwaysTemplate)
                iconImageView.isHidden = false
//                iconImageView.snp.updateConstraints { (make) in
//                    make.width.equalTo(Constants.iconSize)
//                }
                titleLabel.snp.updateConstraints { (make) in
                    make.right.equalTo(iconImageView.snp.left).offset(Constants.itemSpacing)
                }
            }

            self.setNeedsUpdateConstraints()
        }
    }
}
