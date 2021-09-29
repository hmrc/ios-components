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

class ScreenCapture {
    func captureScreen(filename: String) {
        guard let viewController = self.findScrollViewController(),
              let scrollView = primaryScrollViewIn(viewController: viewController) else { return }

        let filePath = filePathFor(filename)

        DispatchQueue.main.async {
            let capturedImage: UIImage? = {
                let scrollViewImage = scrollView.fullContentSizeImage(
                    backgroundColor: viewController.view.backgroundColor
                )

                if let scrollViewImage = scrollViewImage, scrollViewImage.size.height > UIScreen.main.bounds.height {
                    return scrollViewImage
                }

                return viewController.view.asImage()
            }()

            guard let pngData = capturedImage?.pngData() else { return }
            try? pngData.write(to: filePath)
        }
    }
}

private extension ScreenCapture {
    func filePathFor(_ filename: String) -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.appendingPathComponent(filename)
    }

    func findScrollViewController() -> UIViewController? {
        guard let viewController = topViewController(),
              primaryScrollViewIn(viewController: viewController) != nil else { return nil }

        return viewController
    }

    func primaryScrollViewIn(viewController: UIViewController) -> UIScrollView? {
        if let scrollView = viewController.view as? UIScrollView {
            return scrollView
        }

        if let scrollView = viewController.view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView {
            return scrollView
        }

        let actualSubviews = viewController.view.subViewsExcludingLayoutGuides()
        if actualSubviews.count == 1, let scrollView = actualSubviews[0] as? UIScrollView {
            return scrollView
        }

        let actualSubviewsWithinView = actualSubviews[0].subViewsExcludingLayoutGuides()
        if actualSubviewsWithinView.count == 1, let scrollView = actualSubviewsWithinView[0] as? UIScrollView {
            return scrollView
        }

        return nil
    }

    private func topViewController(
        _ base: UIViewController? = nil
    ) -> UIViewController? {
        let baseVC: UIViewController? = base ?? UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        if let nav = baseVC as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }

        if let tab = baseVC as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController

            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(top)
            } else if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }

        if let presented = baseVC?.presentedViewController {
            return topViewController(presented)
        }

        baseVC?.view.endEditing(true) // ensure that there are no flashing carats

        return baseVC
    }
}

extension UIView {
     func subViewsExcludingLayoutGuides() -> [UIView] {
         subviews.filter { !String(describing: $0.self).contains("_UILayoutGuide") }
     }
 }

// class PrimaryScrollView: UIScrollView {}
