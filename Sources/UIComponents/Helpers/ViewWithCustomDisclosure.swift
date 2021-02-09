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

extension Components.Helpers {
    /// View built out of contentView - space - Disclosure View
    open class ViewWithCustomDisclosure: UIView {
        // MARK: - Views & Outlets

        public private(set) lazy var stackView: TouchPassThroughStackView = .build()
        public private(set) var disclosureView: UIView!
        public private(set) var contentView: UIView!

        // MARK: - Subclassing

        open func createContentView() -> UIView {
            fatalError("Subclass needs to override createContentView()")
        }

        open func createDisclosureView() -> UIView {
            fatalError("Subclass needs to override createDisclosureView()")
        }

        // MARK: - Initialisation

        public convenience init(title: String, body: String? = nil) {
            self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        }

        override public init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }

        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }

        open func commonInit() {
            disclosureView = createDisclosureView()
            contentView = createContentView()

            addViews()
            setContraints()
            setContentPriority()
            disableTranslatesAutoresizingMaskIntoConstraints()
            layoutMargins = .zero

            setNeedsUpdateConstraints()
        }

        private func addViews() {
            addSubview(stackView)
            stackView.addArrangedSubview(contentView)
            stackView.addArrangedSubview(disclosureView)

            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.spacing = .spacer8
        }

        private func setContentPriority() {
            disclosureView.setContentHuggingPriority(.required, for: .horizontal)
            disclosureView.setContentCompressionResistancePriority(.required, for: .horizontal)
            contentView.setContentHuggingPriority(.defaultLow, for: .horizontal)
            contentView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }

        private func disableTranslatesAutoresizingMaskIntoConstraints() {
            translatesAutoresizingMaskIntoConstraints = false
            disclosureView.translatesAutoresizingMaskIntoConstraints = false
            contentView.translatesAutoresizingMaskIntoConstraints = false
        }

        private func setContraints() {
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
                stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
            ])
        }
    }
}
