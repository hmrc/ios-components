/*
 * Copyright 2019 HM Revenue & Customs
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

extension Components.Atoms {

    open class BulletLabelView: UIView {

        override open class var requiresConstraintBasedLayout: Bool { return true }

        let bullet = UILabel.styled(style: .body)
        let bulletLabel = UILabel.styled(style: .body)

        public init(text: String) {
            bullet.text = "•"
            bulletLabel.text = text
            super.init(frame: CGRect.zero)

            commonInit()
        }

        open func commonInit() {
            addViews()
            disableTranslatesAutoresizingMaskIntoConstraints()
            setupAccessibility()
            setupConstraints()
            setNeedsUpdateConstraints()
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func addViews() {
            addSubview(bullet)
            addSubview(bulletLabel)
        }

        func disableTranslatesAutoresizingMaskIntoConstraints() {
            translatesAutoresizingMaskIntoConstraints = false
            bullet.translatesAutoresizingMaskIntoConstraints = false
            bulletLabel.translatesAutoresizingMaskIntoConstraints = false
        }

        func setupAccessibility() {
            self.isAccessibilityElement = true
            self.accessibilityTraits = .staticText
            self.accessibilityLabel = "\(bullet.text ?? ""); \(bulletLabel.text ?? "")"
        }

        func setupConstraints() {
            layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            bullet.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .spacer16)

            bullet.setContentHuggingPriority(.required, for: .horizontal)
            bullet.setContentCompressionResistancePriority(.required, for: .horizontal)

            bullet.snp.makeConstraints { (make) in
                make.left.equalTo(snp.leftMargin)
                make.lastBaseline.equalTo(bulletLabel.snp.firstBaseline)
            }

            bulletLabel.snp.makeConstraints { (make) in
                make.left.equalTo(bullet.snp.right).offset(CGFloat.spacer16)
                make.top.equalTo(snp.topMargin)
                make.bottom.equalTo(snp.bottomMargin)
                make.right.equalTo(snp.rightMargin).priority(999)
            }
        }
    }
}
