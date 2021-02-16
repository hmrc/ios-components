/*
 * Copyright 2018 HM Revenue & Customs
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

extension Components.Molecules {
    open class InsetView: DebugOverlayableView {
        let insetView = UIView()
        public let textView = UITextView(frame: .zero, textContainer: nil)

        public convenience init(text: String) {
            self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            updateUI(text: text)
        }

        public convenience init(text: NSAttributedString? = nil) {
            self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            updateUI(text: text)
        }

        public convenience init(views: [UIView]) {
            self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            updateUI(views: views)
        }

        public override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("Dont call this.")
        }

        open func commonInit() {
            isAccessibilityElement = true
            textView.backgroundColor = .clear
            insetView.backgroundColor = UIColor.Semantic.insetBar.raw
            addViews()
            setupStyle()
            setContraints()
            setContentPriority()
            setupAccessibility()
            disableTranslatesAutoresizingMaskIntoConstraints()
        }

        private func addViews() {
            addSubview(insetView)
        }

        private func setupStyle() {
            textView.isSelectable = true
            textView.isEditable = false
            textView.isScrollEnabled = false
        }

        private func setContraints() {
            NSLayoutConstraint.activate([
                insetView.leftAnchor.constraint(equalTo: leftAnchor),
                insetView.topAnchor.constraint(equalTo: topAnchor),
                insetView.bottomAnchor.constraint(equalTo: bottomAnchor),
                insetView.widthAnchor.constraint(equalToConstant: 4)
            ])
        }

        private func setContentPriority() {
            insetView.setContentHuggingPriority(.required, for: .horizontal)
            insetView.setContentCompressionResistancePriority(.required, for: .horizontal)
            textView.setContentHuggingPriority(.defaultLow, for: .horizontal)
            textView.setContentCompressionResistancePriority(.required, for: .horizontal)
        }

        private func setupAccessibility() {
            accessibilityTraits = .staticText
        }

        private func disableTranslatesAutoresizingMaskIntoConstraints() {
            translatesAutoresizingMaskIntoConstraints = false
            insetView.translatesAutoresizingMaskIntoConstraints = false
            textView.translatesAutoresizingMaskIntoConstraints = false
        }

        public func updateUI(text: String?) {
            setupTextView()

            textView.attributedText = NSMutableAttributedString.styled(
                style: .body,
                string: text
            )

            setupAccessibilityLabelsForEachParagraph(usingText: text)
        }

        public func updateUI(text: NSAttributedString?) {
            setupTextView()
            textView.attributedText = text
            setupAccessibilityLabelsForEachParagraph(usingText: text?.string)
            textView.textColor = UIColor.Semantic.darkText.raw
        }

        private func setupTextView() {
            addSubview(textView)

            NSLayoutConstraint.activate([
                textView.leftAnchor.constraint(equalTo: insetView.rightAnchor, constant: 18),
                textView.rightAnchor.constraint(equalTo: rightAnchor),
                textView.topAnchor.constraint(equalTo: insetView.topAnchor, constant: 8),
                textView.bottomAnchor.constraint(equalTo: insetView.bottomAnchor, constant: -8)
            ])
        }

        public func updateUI(views: [UIView]) {

            views.forEach { addSubview($0) }
            views.enumerated().forEach { index, view in

                NSLayoutConstraint.activate([
                    view.leftAnchor.constraint(equalTo: insetView.rightAnchor, constant: 18),
                    view.rightAnchor.constraint(equalTo: rightAnchor)
                ])

                if index == 0 {
                    view.topAnchor.constraint(equalTo: insetView.topAnchor, constant: 8).isActive = true
                    if views.count == 1 {
                        view.bottomAnchor.constraint(equalTo: insetView.bottomAnchor, constant: -8).isActive = true
                    }
                } else if index == views.count - 1 {
                    NSLayoutConstraint.activate([
                        view.topAnchor.constraint(equalTo: views[index - 1].bottomAnchor, constant: 8),
                        insetView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8)
                    ])
                } else {
                    view.topAnchor.constraint(equalTo: views[index - 1].bottomAnchor, constant: 8).isActive = true
                }
            }
        }
    }
}

// MARK: - UIAccessibilityContainer

extension Components.Molecules.InsetView {
    func setupAccessibilityLabelsForEachParagraph(usingText text: String?) {
        guard let text = text else {
            isAccessibilityElement = true
            accessibilityLabel = nil
            return
        }

        isAccessibilityElement = false

        textView.accessibilityElements = text.paragraphs().map {
            let label = UILabel(frame: .zero)
            label.text = $0
            return label
        }
    }
}
