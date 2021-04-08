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

    public class PrimaryCardView: Components.Atoms.CardView, Component {

        public class Model {
            public let title: String
            public let views: [UIView]

            public init(title: String, views: [UIView] = []) {
                self.title = title
                self.views = views
            }
        }

        // MARK: - Views

        public let titleLabel = UILabel.buildH5Label()

        // MARK: - Initialisation

        public required init(model: Model?) {
            super.init(components: [titleLabel])

            if let model = model {
                updateUI(for: model)
            }
        }

        override open func commonInit() {
            super.commonInit()
            self.accessibilityIdentifier = "PrimaryCardView"
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("Init With Coder not implemented")
        }

        public func updateUI(for model: Model) {
            titleLabel.attributedText = NSMutableAttributedString.styled(style: .H5, string: model.title)
            setComponents([titleLabel] + model.views)
        }

        public func removePadding(onViews views: [UIView]) {
            removePadding()

            components.filter { !views.contains($0) }.forEach {
                $0.snp.remakeConstraints { (make) in
                    make.left.equalTo(snp.left).inset(CGFloat.spacer16)
                    make.right.equalTo(snp.right).inset(CGFloat.spacer16)
                }
            }

            titleLabel.snp.remakeConstraints { (make) in
                make.left.equalTo(snp.left).inset(CGFloat.spacer16)
                make.right.equalTo(snp.right).inset(CGFloat.spacer16)
            }

            // Apply spacing above title without causing constraint conflicts
            stackView.layoutMargins.adjust([.top], margin: 16)
            stackView.isLayoutMarginsRelativeArrangement = true
        }
    }
}
