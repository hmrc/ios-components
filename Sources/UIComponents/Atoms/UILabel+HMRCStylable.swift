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
// swiftlint:disable identifier_name
public enum LabelStyle: Style {
    case H3
    case H4
    case H5
    case bold
    case body
    case info
    case debug
    case link
    case error

    public var font: UIFont {
        switch self {
        case .H3: return UIFont.H3()
        case .H4: return UIFont.H4()
        case .H5: return UIFont.H5()
        case .bold: return UIFont.bold()
        case .body, .info, .link, .error: return UIFont.body()
        case .debug: return UIFont.debug()
        }
    }

    public var textColor: UIColor {
        switch self {
        case .info, .debug:
            return UIColor.Semantic.infoText
        case .link:
            return UIColor.Semantic.linkText
        case .error:
            return UIColor.Semantic.errorText
        default:
            return UIColor.Semantic.darkText
        }
    }

    public var backgroundColor: UIColor {
        if Components.Debug.showOverlay {
            return UIColor.Components.Debug.labelBackground
        } else {
            return .clear
        }
    }
}

extension UILabel: Stylable {
    public static func styled(style: LabelStyle, string: NSAttributedString) -> UILabel {
        UILabel.buildLabel(style: style) {
            $0.attributedText = string
        }
    }

    public static func styled(style: LabelStyle, string: String? = nil) -> UILabel {
        UILabel.buildLabel(style: style) {
            $0.text = string
        }
    }

    public func setAppearance(for style: LabelStyle) {
        self.font = style.font
        self.textColor = style.textColor
        self.backgroundColor = style.backgroundColor
    }

    public static func buildLabel<T: UILabel>(handler: ViewBuilderHandler<T>? = nil) -> T {
        let label: T = .build {
            $0.adjustsFontForContentSizeCategory = true
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
        }
        handler?(label)
        return label
    }

    public static func buildLabel<T: UILabel>(style: LabelStyle, handler: ViewBuilderHandler<T>? = nil) -> T {
        let label: T = .build {
            $0.adjustsFontForContentSizeCategory = true
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.setAppearance(for: style)
            switch style {
            case .H3, .H4, .H5:
                $0.accessibilityTraits = .header
            default:
                break
            }
        }
        handler?(label)
        return label
    }

    public static func buildH3Label<T: UILabel>(handler: ViewBuilderHandler<T>? = nil) -> T {
        buildLabel(style: .H3, handler: handler)
    }

    public static func buildH4Label<T: UILabel>(handler: ViewBuilderHandler<T>? = nil) -> T {
        buildLabel(style: .H4, handler: handler)
    }

    public static func buildH5Label<T: UILabel>(handler: ViewBuilderHandler<T>? = nil) -> T {
        buildLabel(style: .H5, handler: handler)
    }

    public static func buildBoldLabel<T: UILabel>(handler: ViewBuilderHandler<T>? = nil) -> T {
        buildLabel(style: .bold, handler: handler)
    }

    public static func buildBodyLabel<T: UILabel>(handler: ViewBuilderHandler<T>? = nil) -> T {
        buildLabel(style: .body, handler: handler)
    }

    public static func buildInfoLabel<T: UILabel>(handler: ViewBuilderHandler<T>? = nil) -> T {
        buildLabel(style: .info, handler: handler)
    }

    public static func buildDebugLabel<T: UILabel>(handler: ViewBuilderHandler<T>? = nil) -> T {
        buildLabel(style: .debug, handler: handler)
    }

    public static func buildLinkLabel<T: UILabel>(handler: ViewBuilderHandler<T>? = nil) -> T {
        buildLabel(style: .link, handler: handler)
    }

    public static func buildErrorLabel<T: UILabel>(handler: ViewBuilderHandler<T>? = nil) -> T {
        buildLabel(style: .error, handler: handler)
    }
}
// swiftlint:enable identifier_name
