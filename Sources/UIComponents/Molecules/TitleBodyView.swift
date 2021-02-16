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
    open class TitleBodyView: DebugOverlayableView {

        // MARK: - Views & Outlets

        public private(set)var titleLabel: UILabel!
        public private(set)var bodyLabel: UILabel!

        var stackView: UIStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))

        // MARK: - Subclassing

        func createTitleLabel() -> UILabel {
            fatalError("Subclass needs to override createTitleLabel()")
        }

        func createBodyLabel() -> UILabel {
            fatalError("Subclass needs to override createSubTitleLabel()")
        }

        // MARK: - Initialisation

        public convenience init(title: NSAttributedString, body: String? = nil) {
            self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            updateUI(title: title, body: body)
        }

        public convenience init(title: String, body: String? = nil) {
            self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            updateUI(title: title, body: body)
        }

        public override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }

        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }

        open func commonInit() {
            self.titleLabel = createTitleLabel()
            self.bodyLabel = createBodyLabel()

            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(bodyLabel)
            stackView.axis = .vertical
            stackView.spacing = .spacer16
            stackView.distribution = .fill
            addViews()
            disableTranslatesAutoresizingMaskIntoConstraints()
        }

        private func addViews() {
            addSubview(stackView)
        }
        
        open override func didMoveToSuperview() {
            guard let superview = superview else { return }
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: superview.topAnchor),
                stackView.leftAnchor.constraint(equalTo: superview.leftAnchor),
                stackView.rightAnchor.constraint(equalTo: superview.rightAnchor),
                stackView.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ])
        }

        private func setContentPriority() {
            titleLabel.setContentHuggingPriority(.required, for: .vertical)
            titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            bodyLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
            bodyLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        }

        private func disableTranslatesAutoresizingMaskIntoConstraints() {
            translatesAutoresizingMaskIntoConstraints = false
            stackView.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        }

        open func leftAlignText() {
            titleLabel.textAlignment = .left
            bodyLabel.textAlignment = .left
        }

        public func updateUI(title: String, body: String? = nil) {
            titleLabel.text = title
            bodyLabel.text = body
            bodyLabel.isHidden = body == nil
        }

        public func updateUI(title: NSAttributedString, body: String? = nil) {
            titleLabel.attributedText = title
            bodyLabel.text = body
            bodyLabel.isHidden = body == nil
        }

        public func updateUI(title: String, body: NSAttributedString? = nil) {
            titleLabel.text = title
            bodyLabel.attributedText = body
            bodyLabel.isHidden = body == nil
        }
    }
}
