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

    public class PageHeaderCardView: Components.Atoms.CardView, Component {

        public class Model {
            public let title: String
            public let subtitle: String?
            public let views: [UIView]

            public init(title: String, subtitle: String? = nil, views: [UIView] = []) {
                self.title = title
                self.subtitle = subtitle
                self.views = views
            }
        }

        // MARK: - Views

        public let titleLabel = UILabel.styled(style: .H4)
        public let subtitleLabel: UILabel?

        // MARK: - Initialisation

        public required init(model: Model?) {
            if model?.subtitle != nil {
                subtitleLabel = UILabel.styled(style: .H5)
                super.init(components: [titleLabel, subtitleLabel!])
            } else {
                subtitleLabel = nil
                super.init(components: [titleLabel])
            }

            if let model = model {
                updateUI(for: model)
            }
        }

        override open func commonInit() {
            super.commonInit()
            self.accessibilityIdentifier = "PageHeaderCardView"
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("Init With Coder not implemented")
        }

        public func updateUI(for model: Model) {
            titleLabel.attributedText = NSMutableAttributedString.styled(style: .H4, string: model.title)
            if let subtitle = model.subtitle,
                let label = subtitleLabel {
                label.attributedText = NSMutableAttributedString.styled(style: .H5, string: subtitle)
                setComponents([titleLabel, label] + model.views)
            } else {
                setComponents([titleLabel] + model.views)
            }
        }
    }
}
