/*
* Copyright 2020 HM Revenue & Customs
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

/*
 * FlexibleButton resizes correctly when using large dynamic text which spans more than one line
 */

open class FlexibleButton: UIButton {

    var heightConstraint: NSLayoutConstraint?

    var padding = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12) {
        didSet {
            contentEdgeInsets = padding
            updateConstraints()
        }
    }

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    open func commonInit() {
        titleLabel?.adjustsFontForContentSizeCategory = true
        titleLabel?.textAlignment = .center
        titleLabel?.numberOfLines = 0
        titleLabel?.lineBreakMode = .byWordWrapping
    }

    public override func updateConstraints() {
        super.updateConstraints()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            let padding = self.padding.top + self.padding.bottom
            let labelWidth = self.bounds.width - padding
            if let size = self.titleLabel?.sizeThatFits(CGSize(width: labelWidth, height: 1000)) {
                if let heightConstraint = self.heightConstraint {
                    heightConstraint.constant = size.height + padding
                } else {
                    self.heightConstraint = self.heightAnchor.constraint(greaterThanOrEqualToConstant: size.height + padding)
                    self.heightConstraint?.isActive = true
                }
            }
        }
    }
}
