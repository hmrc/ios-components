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

public protocol ContentSizeChangeable {
    var scrollView: UIScrollView { get }
    var stackView: UIStackView? { get }

    func willChangeSizeOfSubView(oldFrame: CGRect, newFrame: CGRect)
}

public extension ContentSizeChangeable {

    func willChangeSizeOfSubView(oldFrame: CGRect, newFrame: CGRect) {

        self.scrollView.contentSize = CGSize(
            width: scrollView.frame.width,
            height: stackView?.frame.height ?? 0
        )

        let scrollViewVisibleHeight: CGFloat = {
            self.scrollView.frame.height - self.scrollView.adjustedContentInset.bottom
        }()

        let offsetY = max(
            ((newFrame.minY + newFrame.height) - scrollViewVisibleHeight),
            self.scrollView.contentOffset.y)

        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset = CGPoint(x: self.scrollView.contentOffset.x, y: offsetY)
        }
    }
}
