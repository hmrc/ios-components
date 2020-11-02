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
    public class ExpandingRowView: DebugOverlayableView, Component {
        public struct Model {
            public let title: String
            public let subtitle: String?
            public let icon: UIImage?
            public let expanded: Bool
            public let expandedView: UIView?
            public let accessibilityLabel: String?
            public let shouldAnimateExpansion: Bool
            public let accessibilityExpandHint: String?
            public let accessibilityCollapseHint: String?

            public init(title: String,
                        subtitle: String? = nil,
                        icon: UIImage? = nil,
                        expanded: Bool = false,
                        expandedView: UIView? = nil,
                        accessibilityLabel: String? = nil,
                        shouldAnimateExpansion: Bool = true,
                        accessibilityExpandHint: String? = nil,
                        accessibilityCollapseHint: String? = nil) {
                self.title = title
                self.subtitle = subtitle
                self.icon = icon
                self.expanded = expanded
                self.expandedView = expandedView
                self.accessibilityLabel = accessibilityLabel
                self.shouldAnimateExpansion = shouldAnimateExpansion
                self.accessibilityExpandHint = accessibilityExpandHint
                self.accessibilityCollapseHint = accessibilityCollapseHint
            }
        }

        // MARK: - Views & Outlets

        let mainStackView = UIStackView()
        public let iconButtonView = Components.Molecules.IconButtonView(title: "", icon: nil)
        public let subtitleLabel = UILabel.styled(style: .body)
        let chevronImageView = UIImageView()
        let contentContainerView = UIView()
        var containerView: UIView?
        public let expansionButton = UIButton()
        public var expandedView: UIView?

        // MARK: - Variables

        public var isExpanded: Bool = false
        public var expansionAccessibilityLabel: String?
        public var accessibilityExpandHint: String?
        public var accessibilityCollapseHint: String?

        public var onToggleStateWillChange: BoolHandler?
        public var onToggleStateDidChange: BoolHandler?
        private var shouldAnimateExpansion: Bool!

        // MARK: - Initialisation

        public required convenience init(model: Model?) {
            self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))

            self.isExpanded = model?.expanded ?? false
            self.shouldAnimateExpansion = model?.shouldAnimateExpansion ?? true
            setupUI()

            if let model = model {
                updateUI(for: model)
            }
        }

        open func setupUI() {
            setupStackViews()
            addViews()
            setContraints()
            setContentViewExpanded(isExpanded: isExpanded, duration: 0.0)
            disableTranslatesAutoresizingMaskIntoConstraints()
            updateStyling()
            setupGestures()
            setupAccessibility()
            setContentPriority()
        }

        private func setupGestures() {
            addSubview(expansionButton)
            expansionButton.translatesAutoresizingMaskIntoConstraints = false
            expansionButton.snp.makeConstraints { (make) in
                make.top.equalTo(snp.top)
                make.left.equalTo(snp.left)
                make.right.equalTo(snp.right)
                make.bottom.equalTo(mainStackView.snp.bottom)
            }
            expansionButton.addTarget(self, action: #selector(toggleExpansion), for: .touchUpInside)
        }

        private func addContentView(_ view: UIView?) {
            guard let view = view else { return }
            if let existingView = containerView {
                existingView.removeFromSuperview()
            }
            containerView = view
            contentContainerView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(contentContainerView)
            }
        }

        private func addViews() {
            addSubview(mainStackView)
            mainStackView.addArrangedSubview(iconButtonView)
            mainStackView.addArrangedSubview(subtitleLabel)
            addSubview(chevronImageView)
            addSubview(contentContainerView)
        }

        private func setupStackViews() {
            mainStackView.axis = FontMetrics.scaler > 1 ? .vertical : .horizontal
            mainStackView.distribution = .fill
            mainStackView.spacing = 12
            mainStackView.alignment = .leading
        }

        private func updateStyling() {
            subtitleLabel.textAlignment = FontMetrics.scaler > 1 ? .left : .right
            chevronImageView.image = UIImage(
                named: "chevron_down",
                in: Bundle.resource,
                compatibleWith: nil
            )
            chevronImageView.contentMode = .center
            chevronImageView.tintColor = UIColor.Semantic.darkText.raw
        }

        private func setContraints() {
            mainStackView.snp.makeConstraints { (make) in
                make.top.equalTo(snp.top)
                make.left.equalTo(snp.left)
                make.right.equalTo(chevronImageView.snp.left).inset(-12)
            }
            chevronImageView.snp.makeConstraints { (make) in
                make.height.equalTo(24)
                make.width.equalTo(24)
                make.centerY.equalTo(iconButtonView.iconImageView.snp.centerY)
                make.right.equalTo(snp.right)
            }
            if FontMetrics.scaler > 1 {
                iconButtonView.snp.makeConstraints { (make) in
                    make.left.equalTo(mainStackView.snp.left)
                    make.right.equalTo(mainStackView.snp.right)
                }
            } else {
                iconButtonView.snp.makeConstraints { (make) in
                    make.bottom.equalTo(mainStackView.snp.bottom)
                }
                subtitleLabel.snp.makeConstraints { (make) in
                    make.top.equalTo(iconButtonView.snp.top)
                    make.bottom.equalTo(iconButtonView.snp.bottom)
                }
            }
            iconButtonView.containerView.snp.remakeConstraints { (make) in
                make.edges.equalTo(iconButtonView.snp.edges)
            }
        }

        private func updateSubtitleConstraints() {
            if FontMetrics.scaler > 1 && !iconButtonView.iconImageView.isHidden {
                subtitleLabel.snp.remakeConstraints { (make) in
                    make.left.equalTo(mainStackView.snp.left)
                        .offset(36)
                }
            }
        }

        private func setContentPriority() {
            iconButtonView.setContentHuggingPriority(.required, for: .vertical)
            iconButtonView.setContentCompressionResistancePriority(.required, for: .vertical)
            iconButtonView.setContentHuggingPriority(.defaultLow, for: .horizontal)
            iconButtonView.setContentCompressionResistancePriority(.required, for: .horizontal)

            subtitleLabel.setContentHuggingPriority(.required, for: .horizontal)
            subtitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        }

        private func disableTranslatesAutoresizingMaskIntoConstraints() {
            translatesAutoresizingMaskIntoConstraints = false
            mainStackView.translatesAutoresizingMaskIntoConstraints = false
            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            chevronImageView.translatesAutoresizingMaskIntoConstraints = false
            contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        }

        private func setupAccessibility() {
            //TENDAI-FIX.com
            var title = iconButtonView.titleLabel.text ?? ""
            if let subtitle = subtitleLabel.text {
                title += ", " + subtitle
            }
            expansionButton.accessibilityLabel = expansionAccessibilityLabel ?? title
            //END OF TENDAI-fix.com
            accessibilityElements = [expansionButton, contentContainerView]
            if isExpanded {
                expansionButton.accessibilityHint =
                    accessibilityCollapseHint ?? String.Accessibility.string(for: "ExpandingRowComponent.collapseHint")
            } else {
                expansionButton.accessibilityHint =
                    accessibilityExpandHint ?? String.Accessibility.string(for: "ExpandingRowComponent.expandHint")
            }
        }

        public func updateUI(for model: Model) {
            expansionAccessibilityLabel = model.accessibilityLabel
            accessibilityCollapseHint = model.accessibilityCollapseHint
            accessibilityExpandHint = model.accessibilityExpandHint
            iconButtonView.updateUI(with: model.title, icon: model.icon)
            subtitleLabel.text = model.subtitle
            subtitleLabel.isHidden = model.subtitle?.isEmpty != false
            updateSubtitleConstraints()
            guard let expandedView = model.expandedView else { return }
            self.expandedView = expandedView
            addContentView(expandedView)
            setContentViewExpanded(isExpanded: model.expanded, duration: 0.0)
            setupAccessibility()
        }

        // MARK: - Functionality

        public func setContentViewExpanded(isExpanded: Bool, duration: TimeInterval = 0.3) {
            contentContainerView.snp.remakeConstraints { (make) in
                make.left.equalTo(snp.left)
                make.right.equalTo(snp.right)
                make.top.equalTo(mainStackView.snp.bottom).offset(8)
                make.bottom.equalTo(snp.bottom)
            }
            if isExpanded {
                contentContainerView.isHidden = false
                contentContainerView.alpha = 0
            }
            onToggleStateWillChange?(isExpanded)
            if shouldAnimateExpansion {
                UIView.animate(withDuration: duration, animations: { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.prepareExpansion(isExpanded: isExpanded)
                }, completion: { [weak self] (_) in
                    guard let self = self else {
                        return
                    }
                    self.completeExpansion(isExpanded: isExpanded)
                })
            } else {
                prepareExpansion(isExpanded: isExpanded)
                completeExpansion(isExpanded: isExpanded)
            }
        }

        private func prepareExpansion(isExpanded: Bool) {
            let transform = isExpanded ? CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
            self.chevronImageView.transform = transform
            self.contentContainerView.alpha = isExpanded ? 1 : 0
        }

        private func completeExpansion(isExpanded: Bool) {
            if !isExpanded {
                contentContainerView.snp.makeConstraints({ (make) in
                    make.height.equalTo(0)
                })
                contentContainerView.snp.updateConstraints({ (make) in
                    make.top.equalTo(self.mainStackView.snp.bottom).offset(0)
                })
                contentContainerView.isHidden = true
            }
            DispatchQueue.main.async {
                self.onToggleStateDidChange?(isExpanded)
            }
        }

        // MARK: - Touch Handlers

        @objc func toggleExpansion() {
            isExpanded = !isExpanded
            setContentViewExpanded(isExpanded: isExpanded)
            setupAccessibility()
            if !isExpanded {
                UIAccessibility.post(
                    notification: UIAccessibility.Notification.screenChanged,
                    argument: expansionButton
                )
            }
        }
    }
}
