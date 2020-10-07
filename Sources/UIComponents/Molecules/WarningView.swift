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
    open class WarningView: DebugOverlayableView, Component {

        private struct Constants {
            static let itemSpacing: CGFloat = 24
            static let size: CGFloat = 36
        }

        public struct Model {
            public let text: String

            public init(text: String) {
                self.text = text
            }
        }

        public lazy var iconImageView: UIImageView = {
            let image = UIImage(
                named: "warning",
                in: Bundle(for: Components.Molecules.WarningView.self),
                compatibleWith: nil
            )
            let imageView = UIImageView(image: image)
            imageView.tintColor = UIColor.Semantic.darkText.raw
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()

        public lazy var bodyLabel: UILabel = {
            let label = UILabel.styled(style: .bold)
            label.textAlignment = .left
            label.textColor = UIColor.Semantic.darkText.raw
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

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
            addSubview(iconImageView)
            addSubview(bodyLabel)
        }

        public func updateUI(for model: Model) {
            bodyLabel.text = model.text
            bodyLabel.accessibilityLabel = "Warning; \(model.text)"
        }

        private func setupAccessibility() {
            accessibilityElements = [bodyLabel]
        }

        private func setupConstraints() {
            bodyLabel.setContentHuggingPriority(.required, for: .vertical)
            bodyLabel.setContentCompressionResistancePriority(.required, for: .vertical)

            NSLayoutConstraint.activate([
                iconImageView.leftAnchor.constraint(equalTo: leftAnchor),
                iconImageView.topAnchor.constraint(equalTo: topAnchor),
                iconImageView.widthAnchor.constraint(equalToConstant: Constants.size),
                iconImageView.heightAnchor.constraint(equalToConstant: Constants.size),

                bodyLabel.rightAnchor.constraint(equalTo: rightAnchor),
                bodyLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: .spacer8),
                bodyLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
                bodyLabel.heightAnchor.constraint(greaterThanOrEqualTo: iconImageView.heightAnchor),

                bottomAnchor.constraint(equalTo: bodyLabel.bottomAnchor)
            ])
        }
    }
}
