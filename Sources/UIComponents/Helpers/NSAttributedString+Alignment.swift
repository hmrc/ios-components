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

public extension NSAttributedString {
    func withAlignment(_ alignment: NSTextAlignment) -> NSAttributedString {
        let alignedString = NSMutableAttributedString(attributedString: self)
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = alignment
        alignedString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraph,
            range: NSRange(location: 0, length: self.length)
        )
        return alignedString
    }

    func getAlignment() -> NSTextAlignment? {
        let attributes = self.attributes(at: 0, effectiveRange: nil)
        return attributes.reduce(nil) { (alignment, attribute) -> NSTextAlignment? in
            if attribute.key == NSAttributedString.Key.paragraphStyle,
                let paragraph = attribute.value as? NSMutableParagraphStyle {
                return paragraph.alignment
            } else {
                return alignment
            }
        }
    }
}
