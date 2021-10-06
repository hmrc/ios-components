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

extension Components.Organisms {

    open class HeadlineCardView: Components.Atoms.CardView, Component {

        open class TitleHeadlineView: UIView {

            open class Model {
                public let title: String
                public let headline: NSAttributedString

                public init(title: String, headline: String) {
                    self.title = title
                    self.headline = NSMutableAttributedString.styled(style: .H3, string: headline)
                }

                public init(title: String, headline: NSAttributedString) {
                    self.title = title
                    self.headline = headline
                }
            }

            // MARK: - Views & Outlets 

            public let titleLabel = UILabel.buildH5Label()
            public let headlineLabel = UILabel.buildH3Label()

            // MARK: - Initialisation

            public convenience init(model: Model) {
                self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
                commonInit()
                updateUI(for: model)
            }

            public override init(frame: CGRect) {
                super.init(frame: frame)
                commonInit()
            }

            public required init?(coder aDecoder: NSCoder) {
                fatalError("Dont call this.")
            }

            open func commonInit() {
                addViews()
                setContraints()
                disableTranslatesAutoresizingMaskIntoConstraints()
                self.accessibilityIdentifier = "H3"
                self.headlineLabel.accessibilityTraits = []
            }

            func addViews() {
                addSubview(titleLabel)
                addSubview(headlineLabel)
            }

            func createAccessoryView() -> UIView? {
                return nil
            }

            func setContraints() {
                titleLabel.snp.makeConstraints { (make) in
                    make.left.equalTo(snp.left)
                    make.right.equalTo(snp.right)
                    make.top.equalTo(snp.top)
                }
                headlineLabel.snp.makeConstraints { (make) in
                    make.left.equalTo(snp.left)
                    make.right.equalTo(snp.right)
                    make.top.equalTo(titleLabel.snp.bottom).offset(12)
                    make.bottom.equalTo(snp.bottom)
                }
            }

            func setContentPriority() {
                titleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
                titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
                headlineLabel.setContentHuggingPriority(.required, for: .vertical)
                headlineLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            }

            func disableTranslatesAutoresizingMaskIntoConstraints() {
                translatesAutoresizingMaskIntoConstraints = false
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                headlineLabel.translatesAutoresizingMaskIntoConstraints = false
            }

            public func updateUI(for model: Model) {
                titleLabel.text = model.title
                headlineLabel.attributedText = model.headline
            }
        }

        open class Model: TitleHeadlineView.Model {
            public let views: [UIView]
            public let buttonAccessibilityLabel: String?
            public let buttonAccessibilityHint: String?

            public init(title: String, headline: String, views: [UIView] = [], buttonAccessibilityLabel: String? = nil, buttonAccessibilityHint: String? = nil) {
                self.views = views
                self.buttonAccessibilityLabel = buttonAccessibilityLabel
                self.buttonAccessibilityHint = buttonAccessibilityHint
                super.init(title: title, headline: headline)
            }

            public init(title: String, headline: NSAttributedString, views: [UIView] = [], buttonAccessibilityLabel: String? = nil, buttonAccessibilityHint: String? = nil) {
                self.views = views
                self.buttonAccessibilityLabel = buttonAccessibilityLabel
                self.buttonAccessibilityHint = buttonAccessibilityHint
                super.init(title: title, headline: headline)
            }
        }

        // MARK: - Views & Outlets

        public let titleHeadlineComponent = TitleHeadlineView()

        // MARK: - Initialisation

        public required init(model: Model?) {
            super.init(components: [titleHeadlineComponent])

            if let model = model {
                updateUI(for: model)
            }
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("Init With Coder not implemented")
        }

        override open func commonInit() {
            super.commonInit()
            self.accessibilityIdentifier = "HeadlineCardView"
        }

        public func updateUI(for model: Model) {
            titleHeadlineComponent.updateUI(for: model)
            setComponents([titleHeadlineComponent] + model.views)
            disclosureButton.accessibilityLabel = model.buttonAccessibilityLabel
            disclosureButton.accessibilityHint = model.buttonAccessibilityHint
        }

        @discardableResult public func removePadding(onViews views: [UIView]) -> Self {
            removePadding()

//            components.filter { !views.contains($0) }.forEach {
//                $0.snp.remakeConstraints { (make) in
//                    make.left.equalTo(snp.left).inset(CGFloat.spacer16)
//                    make.right.equalTo(snp.right).inset(CGFloat.spacer16)
//                }
//            }
//
//            titleHeadlineComponent.snp.remakeConstraints { (make) in
//                make.left.equalTo(snp.left).inset(CGFloat.spacer16)
//                make.right.equalTo(snp.right).inset(CGFloat.spacer16)
//            }

            // Apply spacing above titleHeadlineComponent without causing constraint conflicts
            stackView.layoutMargins.adjust([.top], margin: 16)
            stackView.isLayoutMarginsRelativeArrangement = true

            return self
        }
    }
}
