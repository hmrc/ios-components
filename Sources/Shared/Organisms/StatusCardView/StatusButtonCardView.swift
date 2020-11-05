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

extension Components {
    open class StatusButtonCardView: Components.StatusCardView {

        public class ButtonModel: Model {
            public let buttonDescriptor: ButtonDescriptor
            public let button: UIButton

            public init(icon: UIImage!,
                        title: String,
                        body: NSAttributedString? = nil,
                        iconTintColor: UIColor? = nil,
                        buttonDescriptor: ButtonDescriptor) {
                self.buttonDescriptor = buttonDescriptor
                self.button = UIButton.styled(style: buttonDescriptor.style)
                super.init(icon: icon, title: title, body: body, iconTintColor: iconTintColor, views: [button])
            }

            public init(icon: UIImage!,
                        title: String,
                        body: String,
                        iconTintColor: UIColor? = nil,
                        buttonDescriptor: ButtonDescriptor) {
                self.buttonDescriptor = buttonDescriptor
                self.button = UIButton.styled(style: buttonDescriptor.style)
                super.init(icon: icon, title: title, body: body, iconTintColor: iconTintColor, views: [button])
            }
        }

        // MARK: - Views & Outlets
        public var button: UIButton!

        // MARK: - Initialisation

        override open func commonInit() {
            super.commonInit()
            self.accessibilityIdentifier = "StatusButtonCardView"
        }

        public var didTapButton: ActionBlock? {
            didSet {
                guard let block = didTapButton else { return }
                button.componentAction(block: block)
            }
        }

        open override func setupStyle() {
            super.setupStyle()
        }

        open override func updateUI(for model: Model) {
            super.updateUI(for: model)
            guard let model = model as? ButtonModel else { return }
            button = model.button
            button.update(with: model.buttonDescriptor)
        }
    }
}
