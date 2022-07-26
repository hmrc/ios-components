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

extension Components.Organisms {
    open class InformationMessageCard: Components.Atoms.CardView {

        public var action: ((MessageModel, CTA) -> Void)?
        private var model: MessageModel

        public func updateUI(for model: MessageModel) {

        }

        public required init(model: MessageModel) {
            self.model = model
            super.init(components: [])

            let warningCard = makeWarningCard(viewModel: model)

            var views: [UIView] = [warningCard]

            if model.headline.ctas == nil, let content = model.bodyContent {
                views.append(
                    makeBodyContent(viewModel: content, id: model.id)
                )
            }
            setComponents(views)
            removePadding()
            stackView.spacing = 0
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func makeWarningCard(viewModel: Components.Organisms.InformationMessageCard.MessageModel) -> UIView {

            let warningCard = Components.Molecules.WarningView(
                model: .init(
                    text: viewModel.headline.title
                )
            )

            warningCard.iconImageView.image = viewModel.icon
            warningCard.bodyLabel.accessibilityLabel = viewModel.theme.accessibilityLabelPrefix() + viewModel.headline.title

            let warningParentCard = Components.Atoms.CardView(components: [warningCard])

            switch viewModel.theme {
            case .urgent:
                warningParentCard.backgroundColor = UIColor.Semantic.errorText
                warningCard.bodyLabel.textColor = UIColor.Semantic.lightText
                warningCard.iconImageView.tintColor = UIColor.Semantic.lightText
            case .info:
                warningParentCard.backgroundColor = UIColor.Semantic.linkText
                warningCard.bodyLabel.textColor = UIColor.Semantic.lightText
                warningCard.iconImageView.tintColor = UIColor.Semantic.lightText
            case .warning:
                warningParentCard.backgroundColor = UIColor.Named.yellow.colour
                warningCard.bodyLabel.textColor = UIColor.black
                warningCard.iconImageView.tintColor = UIColor.black
            case .notice:
                warningParentCard.backgroundColor = UIColor.Semantic.darkText
                warningCard.bodyLabel.textColor = UIColor.Semantic.lightText
                warningCard.iconImageView.tintColor = UIColor.Semantic.lightText
            case let .custom(backgroundColor, bodyTextColor, iconTintColor):
                warningParentCard.backgroundColor = backgroundColor
                warningCard.bodyLabel.textColor = bodyTextColor
                warningCard.iconImageView.tintColor = iconTintColor
            }

            if let bodyText = viewModel.headline.body {
                let bodyLabel = UILabel.buildLabel(style: .body) {
                    $0.text = bodyText
                    $0.textColor = UIColor.Semantic.lightText
                }
                warningParentCard.addComponents([bodyLabel])
            }

            let buttons = viewModel.headline.ctas?.map { ctaModel -> UIButton in
                switch ctaModel.displayType {
                case .action:
                    return actionCTA(model: ctaModel)
                case .outline:
                    return outlineCTA(model: ctaModel, theme: viewModel.theme)
                }
            } ?? []

            warningParentCard.addComponents(buttons)

            return warningParentCard
        }

        private func actionCTA(
            model: Components.Organisms.InformationMessageCard.CTA
        ) -> UIButton {
            let button = UIButton.styled(
                style: .primary(true, baseline: false),
                string: model.message
            )

            if let button = button as? HMRCButton {
                button.setBackgroundColor(UIColor.Semantic.whiteBackground, for: .normal)
                button.setBackgroundColor(UIColor.Semantic.secondaryButtonHighlightedBackground, for: .highlighted)
            } else {
                fatalError("Something has gone wrong. Button should be HMRCButton type")
            }
            button.setTitleColor(UIColor.Semantic.secondaryButtonText, for: .normal)

            if let accessibilityIdentifier = model.accessibilityHint,
               model.linkType != .inApp && model.linkType != .newScreen {
                button.accessibilityHint = accessibilityIdentifier
            }

            button.componentAction { [unowned self] (_) in
                self.action?(self.model, model)
            }

            return button
        }

        private func outlineCTA(
            model: Components.Organisms.InformationMessageCard.CTA,
            theme: Components.Organisms.InformationMessageCard.MessageModel.Theme
        ) -> UIButton {
            let button = UIButton.styled(
                style: .primary(true, baseline: false),
                string: model.message
            )

            let backgroundColor: UIColor = {
                switch theme {
                case .urgent:
                    return UIColor.Semantic.errorText
                case .info:
                    return UIColor.Semantic.linkText
                case .warning:
                    return UIColor.Named.yellow.colour
                case .notice:
                    return UIColor.Semantic.darkText
                case let .custom(backgroundColor, _, _):
                    return backgroundColor
                }
            }()
            let highlightedBackgroundColor: UIColor = {
                switch theme {
                case .urgent:
                    return UIColor.Semantic.errorText.lighten(0.08)
                case .info:
                    return UIColor.Semantic.linkText.lighten(0.08)
                case .warning:
                    return UIColor.Named.yellow.colour.lighten(0.08)
                case .notice:
                    return UIColor.Semantic.darkText.lighten(0.08)
                case let .custom(backgroundColor, _, _):
                    return backgroundColor.lighten(0.08)
                }
            }()
            let titleColor: UIColor = {
                switch theme {
                case .urgent:
                    return UIColor.Semantic.lightText
                case .info:
                    return UIColor.Semantic.lightText
                case .warning:
                    return UIColor.black
                case .notice:
                    return UIColor.Semantic.lightText
                case let .custom(_, bodyTextColor, _):
                    return bodyTextColor
                }
            }()

            if let button = button as? HMRCButton {
                button.setBackgroundColor(backgroundColor, for: .normal)
                button.setBackgroundColor(highlightedBackgroundColor, for: .highlighted)
            } else {
                fatalError("Something has gone wrong. Button should be HMRCButton type")
            }
            button.setTitleColor(titleColor, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.Semantic.whiteBackground.cgColor
            button.layer.cornerRadius = 0

            if let accessibilityIdentifier = model.accessibilityHint,
               model.linkType != .inApp && model.linkType != .newScreen {
                button.accessibilityHint = accessibilityIdentifier
            }

            button.componentAction { [unowned self] (_) in
                self.action?(self.model, model)
            }
            return button
        }

        func makeBodyContent(viewModel: Components.Organisms.InformationMessageCard.BodyContent, id: String) -> UIView {

            var views = [UIView]()

            if let bodyTitle = viewModel.title {
                views.append(UILabel.styled(style: .bold, string: bodyTitle))
            }
            views.append(UILabel.styled(style: .body, string: viewModel.body))

            viewModel.ctas?.forEach { ctaModel in
                let style: ButtonStyle
                switch ctaModel.displayType {
                case .action:
                    style = .primary(true)
                case .outline:
                    style = .secondary
                }

                let button = UIButton.styled(style: style, string: ctaModel.message)
                if let accessibilityIdentifier = ctaModel.accessibilityHint,
                    ctaModel.linkType != .inApp && ctaModel.linkType != .newScreen {
                    button.accessibilityHint = accessibilityIdentifier
                }
                if case .secondary = style {
                    button.contentHorizontalAlignment = .left
                }

                button.componentAction { [unowned self] (_) in
                    self.action?(self.model, ctaModel)
                }

                views.append(button)
            }

            let card = Components.Atoms.CardView(components: views)
            if views.isEmpty {
                card.removePadding()
            }
            return card
        }
    }
}
