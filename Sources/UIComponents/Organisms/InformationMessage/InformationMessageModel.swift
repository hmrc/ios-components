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

public extension Components.Organisms.InformationMessageCard {

    struct MessageModel {
        public let id: String
        public let theme: Theme
        public let icon: UIImage
        public let headline: Headline
        public let bodyContent: BodyContent?

        public struct Headline {
            let title: String
            let body: String?
            public let ctas: [CTA]?

            public init(title: String, body: String? = nil, ctas: [CTA]? = nil) {
                self.title = title
                self.body = body
                self.ctas = ctas
            }
        }

        public enum Theme {
            case info
            case warning
            case urgent
            case notice
            case custom(backgroundColor: UIColor, bodyTextColor: UIColor, iconTintColor: UIColor)

            public func accessibilityLabelPrefix() -> String {
                switch self {
                case .info:
                    return NSLocalizedString("Info; ", comment: "Prefix for information message")
                case .warning:
                    return NSLocalizedString("Warning; ", comment: "Prefix for warning message")
                case .urgent:
                    return NSLocalizedString("Urgent; ", comment: "Prefix for urgent message")
                case .notice:
                    return NSLocalizedString("Notice; ", comment: "Prefix for notice message")
                case .custom:
                    return NSLocalizedString("Custom; ", comment: "Prefix for notice message")
                }
            }
        }

        public init(
            id: String,
            theme: Theme,
            icon: UIImage,
            headline: Headline,
            bodyContent: BodyContent? = nil
        ) {
            self.id = id
            self.theme = theme
            self.icon = icon
            self.headline = headline
            self.bodyContent = bodyContent
        }
    }

    struct BodyContent {
        let title: String?
        let body: String?
        public let ctas: [CTA]?

        public init(title: String? = nil, body: String? = nil, ctas: [CTA]? = nil) {
            self.title = title
            self.body = body
            self.ctas = ctas
        }
    }

    struct CTA {
        public let message: String
        public let link: String
        public let accessibilityHint: String?
        public let linkType: LinkType
        public let displayType: DisplayType

        public enum LinkType {
            case normal
            case sso
            case inApp
            case newScreen
        }

        public enum DisplayType {
            case primary
            case secondary
        }

        public init(
            message: String,
            link: String,
            accessibilityHint: String? = nil,
            linkType: LinkType,
            displayType: DisplayType
        ) {
            self.message = message
            self.link = link
            self.accessibilityHint = accessibilityHint
            self.linkType = linkType
            self.displayType = displayType
        }
    }
}
