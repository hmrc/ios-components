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

extension Components {
    open class StatusCardView: Atoms.CardView, Component, UITextViewDelegate {

        open class Model: Components.Molecules.StatusView.Model {
            let views: [UIView]
            let journeyId: String?

            public init(icon: UIImage!,
                        title: String,
                        body: NSAttributedString?,
                        buttonModel: ButtonModel? = nil,
                        iconTintColor: UIColor? = nil,
                        views: [UIView] = [],
                        journeyId: String? = nil) {
                self.views = views
                self.journeyId = journeyId
                super.init(icon: icon,
                           title: title,
                           body: body,
                           buttonModel: buttonModel,
                           iconTintColor: iconTintColor
                )
            }

            public init(icon: UIImage!,
                        title: String,
                        body: String? = nil,
                        buttonModel: ButtonModel? = nil,
                        iconTintColor: UIColor? = nil,
                        views: [UIView] = [],
                        journeyId: String? = nil) {
                self.views = views
                self.journeyId = journeyId
                super.init(icon: icon,
                           title: title,
                           body: body,
                           buttonModel: buttonModel,
                           iconTintColor: iconTintColor
                )
            }
        }
        // MARK: - Views

        public let statusView = Components.Molecules.StatusView()

        // MARK: - Initialisation

        public required init(model: Model?) {
            super.init(components: [statusView])

            if let model = model {
                updateUI(for: model)
            }
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("Init With Coder not implemented")
        }

        override open func commonInit() {
            super.commonInit()
            setupStyle()
        }

        // MARK: - Overridable

        open func setupStyle() { }

        open func updateUI(for model: Model) {
            statusView.updateUI(for: model)

            var views = model.views

            if let journeyId = model.journeyId {
                let journeyIdLabel = UILabel.styled(style: .debug)
                journeyIdLabel.textAlignment = .center
                journeyIdLabel.numberOfLines = 0
                journeyIdLabel.translatesAutoresizingMaskIntoConstraints = false
                journeyIdLabel.text = journeyId
                views.append(journeyIdLabel)
            }

            setComponents([statusView] + views)
        }
    }
}
