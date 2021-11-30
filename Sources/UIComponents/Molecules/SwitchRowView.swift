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

extension Components.Molecules {

    open class SwitchRowView: Components.Helpers.ViewWithCustomDisclosure, Component {

        // MARK: - Views
        public private(set)var switchView: UISwitch = .build {
            $0.onTintColor = UIColor.Semantic.switchTint
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 16.0
            $0.layer.borderColor = UIColor.Named.grey2.colour.cgColor
        }
        public private(set)var titleAndBodyView = BoldTitleBodyView(title: "Some Text", body: "Some Body")

        // MARK: - Variables

        public var isOn: Bool {
            return switchView.isOn
        }

        public struct Model {
            public let title: String
            public let body: String?
            public let isOn: Bool

            public init(title: String, body: String? = nil, isOn: Bool) {
                self.title = title
                self.body = body
                self.isOn = isOn
            }
        }

        public var valueChanged: BoolHandler?

        // MARK: - ViewWithCustomDisclosure Overrides

        open override func createContentView() -> UIView {
            return titleAndBodyView
        }

        open override func createDisclosureView() -> UIView {
            return switchView
        }

        public required init(model: Model?) {
            super.init(frame: .zero)
            if let model = model {
                updateUI(for: model)
            }
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("Not implemented")
        }

        override open func commonInit() {
            super.commonInit()
            switchView.addTarget(
                self,
                action: #selector(switchChanged(switchView:)),
                for: .valueChanged
            )
            titleAndBodyView.bodyLabel.setAppearance(for: .info)
            self.accessibilityElements = [titleAndBodyView.titleLabel!, titleAndBodyView.bodyLabel!, switchView]
        }

        public func updateUI(for model: Model) {
            titleAndBodyView.updateUI(title: model.title, body: model.body)
            switchView.isOn = model.isOn
        }

        @objc private func switchChanged(switchView: UISwitch) {
            valueChanged?(switchView.isOn)
        }
    }
}
