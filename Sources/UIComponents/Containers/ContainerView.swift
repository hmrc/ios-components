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

extension Components {
    open class ContainerView: UIStackView {
        public let separationConfiguration: SeparatorConfiguration
        open func set(viewsToSeparate: [UIView]) {
            removeAllSubviews()

            let separatedViews = viewsToSeparate.separate(separationConfiguration)
            separatedViews.forEach { self.addArrangedSubview($0) }
        }

        open func removeAllSubviews() {
            self.arrangedSubviews.forEach { $0.removeFromSuperview() }
        }

        public init(config: SeparatorConfiguration, subviews: [UIView]?=nil) {
            separationConfiguration = config
            super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
            self.axis = .vertical
            if let subviews = subviews {
                set(viewsToSeparate: subviews)
            }
        }

        public required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
