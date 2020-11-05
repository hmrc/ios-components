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

import SnapKit
import UIKit

// MARK: - HMRCStyle

public enum ButtonStyle: Style {
    case primary(_ enabled: Bool, baseline: Bool = true)
    case secondary

    public var font: UIFont {
        return UIFont.body()
    }

    public var textColor: UIColor {
        switch self {
        case let .primary(enabled, _):
            return enabled ?
                UIColor.Semantic.primaryButtonText.raw : UIColor.Semantic.primaryButtonDisabledText.raw
        case .secondary:
            return UIColor.Semantic.secondaryButtonText.raw
        }
    }

    public var backgroundColor: UIColor {
        if Components.Debug.showOverlay { return UIColor.Components.Debug.buttonBackground }
        switch self {
        case .primary:
            return UIColor.Semantic.primaryButtonBackground.raw
        case .secondary:
            return UIColor.Semantic.secondaryButtonBackground.raw
        }
    }

    public var disabledBackgroundColor: UIColor {
        switch self {
        case .primary:
            return UIColor.Semantic.primaryButtonDisabledBackground.raw
        case .secondary:
            return UIColor.Semantic.secondaryButtonBackground.raw
        }
    }

    public var highlightedBackgroundColor: UIColor {
        switch self {
        case .primary:
            return UIColor.Semantic.primaryButtonHighlightedBackground.raw
        case .secondary:
            return UIColor.Semantic.secondaryButtonHighlightedBackground.raw
        }
    }

    public var baselineColor: UIColor {
        switch self {
        case let .primary(_, baseline):
            return baseline ? UIColor.Semantic.primaryButtonBaseline.raw : UIColor.clear
        default:
            return UIColor.clear
        }
    }

    public var highlightedBaselineColor: UIColor {
        switch self {
        case let .primary(_, baseline):
            return baseline ? UIColor.Semantic.primaryButtonHighlightedBaseline.raw : UIColor.clear
        default:
            return UIColor.clear
        }
    }

    public var disabledBaselineColor: UIColor {
        return UIColor.clear
    }

    public var padding: UIEdgeInsets {
        switch self {
        case .secondary:
            return UIEdgeInsets(top: 12, left: 4, bottom: 12, right: 4)
        default:
            return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        }
    }
}

// MARK: - Button Descriptor

public struct ButtonDescriptor {
    public let style: UIButton.StyleType
    public let visible: Bool
    public let title: String
    public let alignment: UIControl.ContentHorizontalAlignment
    public let accessibilityIdentifier: String?
    public let accessibilityHint: String?
    public var actionBlock: ActionBlock?

    public init(
        style: UIButton.StyleType,
        visible: Bool,
        title: String,
        alignment: UIControl.ContentHorizontalAlignment,
        accessibilityIdentifier: String? = nil,
        accessibilityHint: String? = nil
    ) {
        self.style = style
        self.visible = visible
        self.title = title
        self.alignment = alignment
        self.accessibilityIdentifier = accessibilityIdentifier
        self.accessibilityHint = accessibilityHint
    }
}

// MARK: - HMRCStylable Extension

extension UIButton: Stylable {
    public static func styled(style: ButtonStyle, string: String? = nil) -> UIButton {
        let button: HMRCButton = .buildButton(style: style, string: string) {
            $0.style = style
        }
        return button
    }

    public static func styled(style: ButtonStyle, attributedString: NSAttributedString) -> UIButton {
        let button: HMRCButton = .buildButton(style: style) {
            $0.style = style
            $0.setAttributedTitle(attributedString, for: .normal)
        }
        return button
    }

    public func setAppearance(for style: ButtonStyle) {
        titleLabel?.font = style.font
        setTitleColor(style.textColor, for: .normal)
        setBackgroundImage(
            UIImage.imageWithColor(color: style.backgroundColor),
            for: .normal
        )
        setBackgroundImage(
            UIImage.imageWithColor(color: style.disabledBackgroundColor),
            for: .disabled
        )
        setBackgroundImage(
            UIImage.imageWithColor(color: style.highlightedBackgroundColor),
            for: .highlighted
        )

        switch style {
        case let .primary(enabled, _):
            isEnabled = enabled
        case .secondary:
            isEnabled = true
        }

        contentEdgeInsets = style.padding

        let button = self as? HMRCButton
        button?.setBaselineColor(style.baselineColor, for: .normal)
        button?.setBaselineColor(style.disabledBaselineColor, for: .disabled)
        button?.setBaselineColor(style.highlightedBaselineColor, for: .highlighted)
    }

    public func update(with descriptor: ButtonDescriptor) {
        setAppearance(for: descriptor.style)
        setTitle(descriptor.title, for: .normal)
        accessibilityIdentifier = descriptor.accessibilityIdentifier
        accessibilityHint = descriptor.accessibilityHint
        isHidden = !descriptor.visible
        contentHorizontalAlignment = descriptor.alignment
        if let block = descriptor.actionBlock {
            componentAction(block: block)
        }
    }

    public static func buildButton<T: FlexibleButton>(style: ButtonStyle, string: String? = nil, handler: ViewBuilderHandler<T>? = nil) -> T {
        let button: T = .build {
            $0.setAppearance(for: style)
            if let string = string {
                $0.setTitle(string, for: .normal)
            }
        }
        handler?(button)
        return button
    }

    public static func buildPrimaryButton<T: FlexibleButton>(
        string: String? = nil,
        enabled: Bool = true,
        baseline: Bool = true,
        handler: ViewBuilderHandler<T>? = nil
    ) -> T {
        buildButton(
            style: .primary(
                enabled, baseline:
                baseline
            ),
            string: string,
            handler: handler
        )
    }

    public static func buildSecondaryButton<T: FlexibleButton>(
        string: String? = nil,
        handler: ViewBuilderHandler<T>? = nil
    ) -> T {
        buildButton(
            style: .secondary,
            string: string,
            handler: handler
        )
    }
}

// MARK: - Subclass

internal class HMRCButton: FlexibleButton {
    private var baselineView = UIView()
    private var baselineColors: [UInt: UIColor] = [:]

    var style: ButtonStyle?

    override var isEnabled: Bool {
        didSet {
            updateBaselineColor()
        }
    }

    override var isHighlighted: Bool {
        didSet {
            updateBaselineColor()
        }
    }

    override open func commonInit() {
        super.commonInit()
        layer.cornerRadius = 4.0
        contentEdgeInsets = padding
        addSubview(baselineView)
    }

    func setBaselineColor(_ color: UIColor, for state: UIControl.State) {
        baselineColors[state.rawValue] = color
        updateBaselineColor()
    }

    private func updateBaselineColor() {
        baselineView.backgroundColor = baselineColors[state.rawValue] ?? baselineColors[UIControl.State.normal.rawValue]
    }

    override func updateConstraints() {
           super.updateConstraints()

           DispatchQueue.main.async { [weak self] in
               guard let self = self else { return }

               self.baselineView.snp.remakeConstraints { make in
                   make.left.equalTo(self.snp.left)
                   make.right.equalTo(self.snp.right)
                   make.bottom.equalTo(self.snp.bottom)
                   make.height.equalTo(3)
               }
           }
       }
}
