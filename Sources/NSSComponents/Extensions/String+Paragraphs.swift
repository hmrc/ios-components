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

import Foundation
import UIKit

extension String {

    public func buildStackViewFromParagraphs(textAlignment: NSTextAlignment = .natural) -> UIStackView {
        let container: UIStackView = UIStackView.build {
            $0.axis = .vertical
            $0.spacing = .spacer8
        }

        let views: [UIView] = self.paragraphs().map { paragraph in
            if paragraph.starts(with: "•") {
                let bulletText = String(paragraph.dropFirst(1)).trimmingCharacters(in: .whitespaces)
                return Components.Atoms.BulletLabelView(text: bulletText)
            } else {
                return UILabel.buildBodyLabel {
                    $0.text = paragraph
                    $0.textAlignment = textAlignment
                }
            }
        }

        container.addArrangedSubviews(views)

        return container
    }

    func paragraphs() -> [String] {
        var paragraphs: [String] = []
        self.enumerateSubstrings(in: self.startIndex..., options: [.localized, .byParagraphs]) { (paragraph, _, _, _) in
            paragraphs.append(paragraph ?? "")
        }
        return paragraphs.filter { !$0.isEmpty }
    }
}
