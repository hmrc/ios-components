/*
 * Copyright 2023 HM Revenue & Customs
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
    open class MiniAdvertCardView: Components.Atoms.CardView, Component {
        
        // MARK: - Model
        public struct Model {
            public let title: String
            public let accessibilityHint: String?
            public let accessibilityIdentifier: String?
            public let icon: UIImage?
            
            public init(title: String,
                        accessibilityHint: String? = nil,
                        accessibilityIdentifier: String? = nil,
                        icon: UIImage? = UIImage(systemName: "chevron.right")) {
                self.title = title
                self.accessibilityHint = accessibilityHint
                self.accessibilityIdentifier = accessibilityIdentifier
                self.icon = icon
            }
        }
        
        // MARK: - Views & Outlets
        
        public let miniAdvertButton = Components.Molecules.MiniAdvertButtonView(frame: .zero)
        
        public var didTapButton: ActionBlock? {
            get {
                return miniAdvertButton.didTapButton
            }
            set (newVal) {
                miniAdvertButton.didTapButton = newVal
            }
        }
        
        required public init(model: Components.Organisms.MiniAdvertCardView.Model?) {
            super.init(components: [miniAdvertButton])
            self.removePadding()
            if let model = model {
                updateUI(for: model)
            }
        }
        
        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public func updateUI(for model: Components.Organisms.MiniAdvertCardView.Model) {
            miniAdvertButton.updateUI(
                with: model.title,
                accessibilityHint: model.accessibilityHint,
                accessibilityIdentifier: model.accessibilityIdentifier,
                icon: model.icon
            )
        }
        
    }
}
