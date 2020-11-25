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

extension Components.Molecules {
    open class TextInputView: DebugOverlayableView, DisplaysValidationError, UITextViewDelegate {
        // MARK: - Nested

        public class LeftView: UIView {
            lazy var label = UILabel.buildLabel(style: .body) {
                $0.text = ""
                $0.isAccessibilityElement = false
                $0.textColor = UIColor.Semantic.textInputLeftViewTint.raw
                $0.setContentHuggingPriority(.required, for: .vertical)
                $0.setContentCompressionResistancePriority(.required, for: .vertical)
                $0.setContentHuggingPriority(.required, for: .horizontal)
            }

            required init?(coder _: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }

            init() {
                super.init(frame: CGRect.zero)
                translatesAutoresizingMaskIntoConstraints = false
                isAccessibilityElement = false
                addViews()
                setupConstraints()
                setNeedsUpdateConstraints()
            }

            func set(text: String?) {
                label.text = text
                isHidden = text == nil || text?.isEmpty ?? false
            }

            func addViews() {
                addSubview(label)
            }

            func setupConstraints() {
                layoutMargins = .init(
                    top: 0,
                    left: .spacer8,
                    bottom: 0,
                    right: .spacer4
                )
                NSLayoutConstraint.activate([
                    label.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                    label.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
                    label.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                    label.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
                ])
            }
        }

        // MARK: - Local Vars

        public class Model {
            public let title: String?
            public let initialText: String?
            public let leftViewText: String?
            public let maxLength: Int?
            public let multiLine: Bool
            public let keyboardType: UIKeyboardType

            public init(
                title: String? = nil,
                leftViewText: String? = nil,
                initialText: String? = nil,
                maxLength: Int? = nil,
                multiLine: Bool = false,
                keyboardType: UIKeyboardType = .default
            ) {
                self.title = title
                self.leftViewText = leftViewText
                self.initialText = initialText
                self.maxLength = maxLength
                self.multiLine = multiLine
                self.keyboardType = keyboardType
            }
        }

        override open var accessibilityIdentifier: String? {
            get {
                // Do not pass back textView.accessibilityIdentifier as it causes confusion in accesibility
                // element tree (due to other 'Other' and 'TextView' elements being reported with same name)
                return nil
            }
            set {
                textView.accessibilityIdentifier = newValue
            }
        }

        var fontScale = FontMetrics.scaler

        private var model: Model!

        private var editing = false

        // MARK: - Public Vars

        public var enforceMaxLength: Bool = true

        // MARK: - Handlers

        public var didChangeInput: VoidHandler?
        public var didEndInput: VoidHandler?
        public var didClearInput: VoidHandler?
        public var didTapReturn: VoidHandler?

        // MARK: - Views

        public lazy var stackView: UIStackView = .build {
            $0.axis = .vertical
            $0.spacing = 5
        }

        public lazy var leftView: LeftView = .build {
            $0.isAccessibilityElement = false
            $0.setContentHuggingPriority(.required, for: .horizontal)
        }

        public lazy var titleLabel = UILabel.buildBodyLabel {
            $0.isAccessibilityElement = false
            $0.adjustsFontForContentSizeCategory = true
            $0.setContentHuggingPriority(.required, for: .vertical)
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
        }

        public lazy var textView: UITextView = .build {
            $0.delegate = self
            $0.font = UIFont.body()
            $0.isScrollEnabled = false
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
            $0.isAccessibilityElement = true
            $0.adjustsFontForContentSizeCategory = true
            $0.textContainer.heightTracksTextView = true
        }

        public lazy var validationErrorLabel = UILabel.buildBodyLabel {
            $0.isAccessibilityElement = false
            $0.adjustsFontForContentSizeCategory = true
            $0.setContentHuggingPriority(.required, for: .vertical)
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
        }

        public lazy var charCountLabel = UILabel.buildBodyLabel {
            $0.isAccessibilityElement = false
            $0.adjustsFontForContentSizeCategory = true
            $0.textAlignment = .right
            $0.setContentHuggingPriority(.required, for: .horizontal)
        }

        public lazy var clearButton: UIButton = .build {
            $0.accessibilityLabel = String.Accessibility.string(for: "TextInputView.clear")
            $0.setContentHuggingPriority(.required, for: .horizontal)
            $0.setImage(UIImage(
                named: "clear_icon",
                in: Bundle.resource,
                compatibleWith: nil
            ), for: .normal)
            $0.tintColor = UIColor.Components.Named.grey2
        }

        public let validationErrorAndCharCountStackView: UIStackView = .build {
            $0.alignment = .top
        }

        public let borderView: UIView = UIView(
            frame: .init(
                x: 0,
                y: 0,
                width: 1,
                height: 1
            )
        )

        // MARK: - Subclassing

        // MARK: - Initialisation

        public required init() {
            super.init(frame: .zero)
            commonInit()
        }

        override public init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }

        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }

        open func commonInit() {
            addViews()
            translatesAutoresizingMaskIntoConstraints = false
            updateUI()
        }

        private func updateColours() {
            var titleColour = UIColor.Semantic.darkText.raw
            var borderColour = UIColor.Semantic.textInputBorder.raw.cgColor

            if let validationError = validationErrorLabel.text, !validationError.isEmpty {
                titleColour = UIColor.Semantic.errorText.raw
                borderColour = UIColor.Semantic.errorText.raw.cgColor
            }

            borderView.layer.borderWidth = 1.0
            borderView.layer.cornerRadius = 4.0

            textView.textColor = UIColor.Semantic.darkText.raw
            textView.backgroundColor = .clear

            titleLabel.textColor = titleColour

            borderView.layer.borderColor = borderColour

            validationErrorLabel.textColor = UIColor.Semantic.errorText.raw
        }

        @objc public func clearTextView() {
            textView.text = ""
            updateCharCount()
            didClearInput?()
        }

        private func addViews() {
            addSubview(stackView)

            clearButton.addTarget(self, action: #selector(clearTextView), for: .touchUpInside)

            let textRowStack: UIStackView = .build {
                $0.axis = .horizontal
                $0.distribution = .fill
                $0.alignment = .center
                $0.addArrangedSubviews([
                    self.leftView,
                    self.textView,
                    self.clearButton
                ]
                )
            }

            borderView.addSubview(textRowStack)

            validationErrorAndCharCountStackView.addArrangedSubview(validationErrorLabel)
            validationErrorAndCharCountStackView.addArrangedSubview(charCountLabel)

            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(borderView)
            stackView.addArrangedSubview(validationErrorAndCharCountStackView)

            NSLayoutConstraint.activate([
                textRowStack.topAnchor.constraint(equalTo: borderView.topAnchor),
                textRowStack.bottomAnchor.constraint(equalTo: borderView.bottomAnchor),
                textRowStack.leadingAnchor.constraint(equalTo: borderView.leadingAnchor),
                textRowStack.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -5),

                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])

            // Hide validation label
            set(validationErrorVisible: false, animate: false)

            updateColours()
        }

        private func set(validationErrorVisible: Bool, animate: Bool = true) {
            let duration = animate ? 0.3 : 0
            let alpha: CGFloat = validationErrorVisible ? 1.0 : 0.0

            UIView.animate(withDuration: duration, animations: {
                self.validationErrorLabel.alpha = alpha
            }, completion: { done in
                if done {
                    self.validationErrorLabel.alpha = alpha
                }
            })
        }

        public func set(validationError: String?, changeVisibliltyIfNeeded: Bool = true) {
            if changeVisibliltyIfNeeded {
                if let error = validationError, !error.isEmpty {
                    set(validationErrorVisible: true, animate: true)
                } else {
                    set(validationErrorVisible: false, animate: true)
                }
            }

            if validationErrorLabel.frame.width > 0 {
                validationErrorLabel.preferredMaxLayoutWidth = validationErrorLabel.frame.width
            }
            validationErrorLabel.text = validationError

            if let validationError = validationError {
                textView.accessibilityLabel =
                    "Error: \(validationError) - \(model.title ?? "")"
            } else {
                textView.accessibilityLabel = model.title ?? ""
            }

            updateColours()
        }

        override open func layoutSubviews() {
            // We need to set the preferredMaxLayoutWidth to avoid unwanted padding
            // at top & bottom of the label when displaying long validation messages
            super.layoutSubviews()
            validationErrorLabel.preferredMaxLayoutWidth = frame.width - charCountLabel.frame.width
            super.layoutSubviews()
        }

        public func updateUI(for model: Model = Model()) {
            self.model = model
            leftView.set(text: model.leftViewText)
            textView.text = model.initialText
            validationErrorLabel.text = ""
            charCountLabel.isHidden = !shouldShowCharCountLabel()
            titleLabel.text = model.title
            textView.accessibilityLabel = model.title ?? ""
            textView.keyboardType = model.keyboardType

            updateCharCount()
        }

        open func shouldShowCharCountLabel() -> Bool {
            return model.maxLength != nil && model.maxLength! > 0
        }

        private func updateCharCount() {
            let count = textView.text?.count ?? 0
            // swiftlint:disable:next empty_count
            clearButton.isHidden = !editing || count == 0

            if let maxLength = model.maxLength {
                let separator = fontScale > 1.5 && maxLength > 999 ? "/\n" : "/"
                charCountLabel.text = "\(count)\(separator)\(maxLength)"
                let formatString = String.Accessibility.string(for: "TextInputView.characterCount")
                textView.accessibilityHint = String(format: formatString, count, maxLength)
            }
        }

        // MARK: - DisplaysValidationError

        public func focusValidationError() {
            textView.becomeFirstResponder()
        }

        // MARK: - TextViewDelegate

        open func textViewDidBeginEditing(_ textView: UITextView) {
            editing = true
            updateCharCount()
        }

        open func textViewDidEndEditing(_ textView: UITextView) {
            editing = false
            clearButton.isHidden = true
            didEndInput?()
        }

        open func textView(
            _ textView: UITextView,
            shouldChangeTextIn range: NSRange,
            replacementText text: String
        ) -> Bool {
            if let multiLine = model?.multiLine, !multiLine, text == "\n" {
                textView.resignFirstResponder()
                didTapReturn?()
                return false
            }

            if let maxLength = model.maxLength, enforceMaxLength {
                return textView.text.count + (text.count - range.length) <= maxLength
            }

            return true
        }

        open func textViewDidChange(_ textView: UITextView) {
            updateCharCount()
            didChangeInput?()
        }
    }
}
