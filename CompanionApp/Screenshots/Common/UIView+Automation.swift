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

extension UIView {
    public class func getNestedSubviews<T: UIView>(view: UIView) -> [T] {
        return view.subviews.flatMap { subView -> [T] in
            var result = getNestedSubviews(view: subView) as [T]
            if let view = subView as? T {
                result.append(view)
            }
            return result
        }
    }

    public func getNestedSubviews<T: UIView>(ofType: T.Type) -> [T] {
        return UIView.getNestedSubviews(view: self) as [T]
    }

    public func findFirstNestedView<T: UIView>(ofType type: T.Type,
                                               containingText text: String) -> T? {

        self.getNestedSubviews(ofType: type).first { (subview) -> Bool in
            subview.descendantLabelWith(text: text) != nil
        }
    }

    @discardableResult
    public func descendantLabelWith(text: String, allowPartialMatch: Bool=false) -> UILabel? {
        if let self = self as? UILabel {
            if allowPartialMatch {
                if self.text?.contains(text) ?? false { return self }
            } else if self.text == text { return self }
        } else {
            for subview in subviews {
                if let label = subview.descendantLabelWith(text: text, allowPartialMatch: allowPartialMatch) {
                    return label
                }
            }
        }
        return nil
    }

    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: safeAreaLayoutGuide.layoutFrame)
        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }
}
