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
        let contentViews = subViewsExcludingScrollBars()
        if contentViews.isEmpty { return nil }

        let maxContentWidth = contentViews.reduce(contentSize.width) { max($0, $1.frame.width)}
        let maxContentHeight = contentViews.reduce(contentSize.height) { max($0, $1.frame.height)}

        let captureFrame = CGRect(x: 0, y: 0, width: maxContentWidth, height: maxContentHeight)

        let format = UIGraphicsImageRendererFormat()
        format.preferredRange = .standard
        format.scale = 1

        let renderer = UIGraphicsImageRenderer(
            size: CGSize(width: maxContentWidth, height: maxContentHeight),
            format: format
        )

        let image = renderer.image { context in
            if let color = backgroundColor {
                color.setFill()
                context.fill(captureFrame)
            }

            contentViews.forEach {
                if  $0.frame.height < 2048 {
                    $0.drawHierarchy(in: $0.frame, afterScreenUpdates: true)
                } else {
                    if let cgImage = $0.asImage().cgImage {
                        context.cgContext.translateBy(x: 0, y: maxContentHeight)
                        context.cgContext.scaleBy(x: 1.0, y: -1.0)
                        context.cgContext.draw(cgImage, in: $0.frame)
                        context.cgContext.scaleBy(x: 1.0, y: -1.0)
                        context.cgContext.translateBy(x: 0, y: -maxContentHeight)
                    }
                }
            }
        }

        return image
    }

    func subViewsExcludingScrollBars() -> [UIView] {
        subviews.filter { !String(describing: $0.self).contains("_UIScrollViewScrollIndicator") }
    }
}
