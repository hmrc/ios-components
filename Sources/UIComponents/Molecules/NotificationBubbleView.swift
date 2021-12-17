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

extension Components.Molecules {
    open class NotificationBubbleView: DebugOverlayableView, Component {

        private struct Consts {
            static let defaultSize: CGSize = .init(width: 48, height: 24)
        }

        public enum NotificationMode {
            /// Specifies that the notification will display a number in the notification bubble.
            case number(count: Int, max: Int = 99, hideWhenZero: Bool = true)

            /// Specifies that the notification will display the notification bubble alone
            case circle
            
            /// Specifies that the notification will display the notification bubble with the text provided
            case text(_ text: String)

            /// Specifies that the notification bubble will be hidden
            case hidden
        }

        public struct Model {
            public let notificationMode: NotificationMode

            public init(notificationMode: NotificationMode) {
                self.notificationMode = notificationMode
            }
        }

        public lazy var countLabel = UILabel.buildLabel(style: .bold) {
            $0.textAlignment = .center
            $0.textColor = UIColor.Semantic.lightText
            $0.numberOfLines = 0
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        private var cnsWidth: NSLayoutConstraint?

        public required init(model: Model?) {
            super.init(frame: .zero)
            commonInit()
            if let model = model {
                updateUI(for: model)
            }
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("Init With Coder not implemented")
        }

        private func commonInit() {
            translatesAutoresizingMaskIntoConstraints = false
            addSubviews()
            setupConstraints()
            setupAccessibility()
        }

        private func addSubviews() {
            addSubview(countLabel)
        }

        public func updateUI(for model: Model) {
            backgroundColor = UIColor.Semantic.errorText
            layer.masksToBounds = true
            layer.cornerRadius = FontMetrics.scaledValue(for: Consts.defaultSize.height / 2)

            switch model.notificationMode {
            case .number(let count, let max, let hideWhenZero):
                if hideWhenZero && count == 0 {
                    isHidden = true
                    return
                } else if count == 1 {
                    countLabel.text = "1"
                    countLabel.accessibilityLabel = "1 new item"
                } else if count <= max {
                    countLabel.text = "\(count)"
                    countLabel.accessibilityLabel = "\(count) new items"
                } else {
                    countLabel.text = "\(max)+"
                    countLabel.accessibilityLabel = "\(count) new items"
                }
                cnsWidth?.constant = FontMetrics.scaledValue(for: Consts.defaultSize.width)
            case .circle:
                countLabel.text = ""
                countLabel.accessibilityLabel = "New item"
                cnsWidth?.constant = FontMetrics.scaledValue(for: Consts.defaultSize.height)
            case .text(let text):
                countLabel.text = text
                countLabel.accessibilityLabel = text
                cnsWidth?.constant = FontMetrics.scaledValue(for: Consts.defaultSize.width)
            case .hidden:
                isHidden = true
                return
            }
            isHidden = false
        }

        private func setupAccessibility() {
            accessibilityElements = [countLabel]
        }

        private func setupConstraints() {
            countLabel.setContentHuggingPriority(.required, for: .vertical)
            countLabel.setContentHuggingPriority(.required, for: .horizontal)
            countLabel.setContentCompressionResistancePriority(.required, for: .vertical)

            cnsWidth = widthAnchor.constraint(equalToConstant: FontMetrics.scaledValue(for: Consts.defaultSize.width))

            NSLayoutConstraint.activate([
                countLabel.rightAnchor.constraint(equalTo: rightAnchor),
                countLabel.leftAnchor.constraint(equalTo: leftAnchor),
                countLabel.topAnchor.constraint(equalTo: topAnchor),
                countLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                countLabel.heightAnchor.constraint(equalToConstant: FontMetrics.scaledValue(for: Consts.defaultSize.height)),
                cnsWidth!
            ])
        }
    }
}
