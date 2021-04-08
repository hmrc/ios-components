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

extension Components.Organisms {
    open class IconButtonCardView: Components.Atoms.CardView, Component {

        // MARK: - Model
        public struct Model {
            public let title: String
            public let accessibilityHint: String?
            public let accessibilityIdentifier: String?
            public let icon: UIImage?

            public init(title: String,
                        accessibilityHint: String? = nil,
                        accessibilityIdentifier: String? = nil,
                        icon: UIImage? = nil) {
                self.title = title
                self.accessibilityHint = accessibilityHint
                self.accessibilityIdentifier = accessibilityIdentifier
                self.icon = icon
            }
        }

        // MARK: - Views & Outlets

        public let iconButton = Components.Molecules.IconButtonView(frame: .zero)

        public var didTapButton: ActionBlock? {
            get {
                return iconButton.didTapButton
            }
            set (newVal) {
                iconButton.didTapButton = newVal
            }
        }

        required public init(model: Components.Organisms.IconButtonCardView.Model?) {
            super.init(components: [iconButton])
            self.removePadding()
            if let model = model {
                updateUI(for: model)
            }
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("Init With Coder not implemented")
        }

        public func updateUI(for model: Components.Organisms.IconButtonCardView.Model) {
            iconButton.updateUI(
                with: model.title,
                accessibilityHint: model.accessibilityHint,
                accessibilityIdentifier: model.accessibilityIdentifier,
                icon: model.icon
            )
        }
    }
}
