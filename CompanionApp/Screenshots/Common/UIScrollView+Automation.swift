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

extension UIScrollView {
    func fullContentSizeImage(backgroundColor: UIColor? = nil) -> UIImage? {
        guard let contentView = subViewsExcludingScrollBars().first else {
            return nil
        }

        //let captureFrame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height) // ??
        let captureFrame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height)
        let renderer = UIGraphicsImageRenderer(size: contentView.bounds.size)
        let image = renderer.image { context in
            if let color = backgroundColor {
                color.setFill()
                context.fill(captureFrame)
            }
            contentView.drawHierarchy(in: captureFrame, afterScreenUpdates: true)
        }
        return image
    }

    func subViewsExcludingScrollBars() -> [UIView] {
        subviews.filter { !String(describing: $0.self).contains("_UIScrollViewScrollIndicator") }
    }
}
