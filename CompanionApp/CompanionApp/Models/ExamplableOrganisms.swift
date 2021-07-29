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
import UIComponents

extension Components.Organisms.HeadlineCardView: Examplable {
    typealias Model = Components.Organisms.HeadlineCardView.Model
    typealias View = Components.Organisms.HeadlineCardView

    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    @objc class func withPlaceholders() -> UIView {
        let headlineModel = Model(
            title: "Title",
            headline: "Headline",
            views: [UILabel.styled(style: .body, string: "Body")])
        return View(model: headlineModel)
    }

    //swiftlint:disable:next function_body_length
    @objc class func examples() -> [UIView] {
        let modelWithBody = Model(
            title: "Your PAYE income tax estimate",
            headline: "£12,345",
            views: [UILabel.styled(style: .body, string: "This is the income tax we think you will have paid by the end of this tax year.")]
        )

        let modelWithLongBody = Model(
            title: ExampleText.LoremIpsum.longer.rawValue,
            headline: ExampleText.LoremIpsum.long.rawValue,
            views: [UILabel.styled(style: .body, string: ExampleText.LoremIpsum.longest.rawValue)])

        let bodyAndPrimaryButton = [
            UILabel.styled(style: .body,
                           string: "This is the income tax we think you will have paid by the end of this tax year."),
            UIButton.styled(style: .primary(true), string: "View tax estimate")
        ]

        let modelWithBodyAndPrimaryButton = Model(
            title: "Your PAYE income tax estimate",
            headline: "£12,345",
            views: bodyAndPrimaryButton)

        let secondaryButton = UIButton.styled(style: .secondary, string: ExampleText.LoremIpsum.long.rawValue)
        secondaryButton.contentHorizontalAlignment = .left

        let bodyAndSecondaryButton = [
            UILabel.styled(style: .body, string: ExampleText.LoremIpsum.longest.rawValue),
            secondaryButton
        ]

        let modelWithBodyAndSecondaryButton = Model(
            title: ExampleText.LoremIpsum.longer.rawValue,
            headline: ExampleText.LoremIpsum.long.rawValue,
            views: bodyAndSecondaryButton)

        let iconButton = Components.Molecules.IconButtonView(
            title: "How is this calculated?",
            icon: ExampleImages.info.image
        )
        let modelWithBodyAndIconButton = Model(
            title: "Your PAYE income tax estimate",
            headline: "£12,345",
            views: [UILabel.styled(style: .body, string: "This is the income tax we think you will have paid by the end of this tax year."), // swiftlint:disable:this line_length
                    iconButton])

        let headlineCardViewWithPaddingRemoved = View(model: modelWithBodyAndIconButton)
        headlineCardViewWithPaddingRemoved.removePadding(onViews: [iconButton])

        let bodyAndInset = [
            UILabel.styled(style: .body, string: "This is the income tax we think you will have paid by the end of this tax year."), // swiftlint:disable:this line_length
            Components.Molecules.InsetView(text: "Your employer or pension provider takes off Income Tax before they pay you. This is called Pay As You Earn (PAYE). The amount of tax you pay depends on your income, how much of it is tax-free, and your tax code.") // swiftlint:disable:this line_length
        ]

        let modelWithBodyAndInset = Model(
            title: "Your PAYE income tax estimate",
            headline: "£12,345",
            views: bodyAndInset)

        let attributedString = NSMutableAttributedString()

        let largeAttributes = [NSAttributedString.Key.font: UIFont.H3()]
        let smallAttributes = [NSAttributedString.Key.font: UIFont.H5()]

        let poundsAttributedString = NSAttributedString(
            string: "£500",
            attributes: largeAttributes
        )
        attributedString.append(poundsAttributedString)

        let penceAttributedString = NSAttributedString(
            string: ".34",
            attributes: smallAttributes
        )
        attributedString.append(penceAttributedString)

        let modelP800 = Model(
            title: "HMRC owes you a refund",
            headline: attributedString,
            views: [
                UIButton.styled(style: .primary(true), string: "Claim your refund")
            ]
        )
        let viewWithAction = View(model: modelWithBody)
        viewWithAction.disclosureAction = {
            let controller = UIAlertController(title: "Tapped", message: "Button was tapped", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                controller.dismiss(animated: true, completion: nil)
            }))
            UIApplication.shared.delegate?.window??.rootViewController?
                .present(controller, animated: true, completion: nil)
        }
        return [
            View(model: modelP800),
            viewWithAction,
            View(model: modelWithLongBody),
            View(model: modelWithBodyAndPrimaryButton),
            View(model: modelWithBodyAndSecondaryButton),
            headlineCardViewWithPaddingRemoved,
            View(model: modelWithBodyAndInset)
        ]
    }
}

extension Components.Organisms.PrimaryCardView: Examplable {
    typealias Model = Components.Organisms.PrimaryCardView.Model

    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    @objc class func withPlaceholders() -> UIView {
        let model = Model(title: "Title",
                          views: [UILabel.styled(style: .body, string: "Body")])

        return Components.Organisms.PrimaryCardView(model: model)
    }

    @objc class func examples() -> [UIView] {
        let body = UILabel.styled(style: .body, string: "Renew your tax credits or check the progress of your claims") // swiftlint:disable:this line_length

        let modelWithBody = Model(title: "Renew your tax credits", views: [body])

        let bodyAndInset = [
            UILabel.styled(style: .body, string: ExampleText.LoremIpsum.longest.rawValue),
            Components.Molecules.InsetView(text: ExampleText.LoremIpsum.longer.rawValue)
        ]
        let modelWithBodyAndInset = Model(title: ExampleText.LoremIpsum.longer.rawValue,
                                          views: bodyAndInset)

        let bodyAndPrimaryButton = [
            UILabel.styled(style: .body, string: "Renew your tax credits"),
            UIButton.styled(style: .primary(true), string: "Renew or check my claims")
        ]

        let modelWithBodyAndPrimaryButton = Model(title: "Renew your tax credits", views: bodyAndPrimaryButton)

        let secondaryButton = UIButton.styled(style: .secondary, string: ExampleText.LoremIpsum.long.rawValue)
        secondaryButton.contentHorizontalAlignment = .left

        let bodyAndSecondaryButton = [
            UILabel.styled(style: .body, string: ExampleText.LoremIpsum.longest.rawValue),
            secondaryButton
        ]

        let modelWithBodyAndSecondaryButton = Model(title: ExampleText.LoremIpsum.longer.rawValue,
                                                    views: bodyAndSecondaryButton)

        let iconButton = Components.Molecules.IconButtonView(
            title: ExampleText.LoremIpsum.long.rawValue,
            icon: ExampleImages.info.image
        )
        let modelWithIconButton = Model(title: ExampleText.LoremIpsum.longer.rawValue, views: [iconButton])

        let primaryCardViewWithPaddingRemoved = Components.Organisms.PrimaryCardView(model: modelWithIconButton)
        primaryCardViewWithPaddingRemoved.removePadding(onViews: [iconButton])

        return [
            modelWithBody,
            modelWithBodyAndInset,
            modelWithBodyAndPrimaryButton,
            modelWithBodyAndSecondaryButton
            ].map {
                Components.Organisms.PrimaryCardView(model: $0)
            } + [primaryCardViewWithPaddingRemoved]
    }
}

extension Components.Organisms.ExpandingRowView: Examplable {
    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    static func withPlaceholders() -> UIView {
        let model = Model(
            title: "Title",
            subtitle: "Subtitle",
            icon: ExampleImages.help.image,
            expandedView: Components.Molecules.InsetView(text: "Description text")
        )
        return Components.Organisms.ExpandingRowView(model: model)
    }

    static func examples() -> [UIView] {
        let model = Model(
            title: "What is Pay As You Earn?",
            icon: ExampleImages.help.image,
            expandedView: Components.Molecules.InsetView(
                text: "Your employer or pension provider takes off Income Tax before they pay you. This is called Pay As You Earn (PAYE). The amount of tax you pay depends on your income, how much of it is tax-free, and your tax code." // swiftlint:disable:this line_length
            )
        )
        let exampleCard = Components.Atoms.CardView(
            components: [Components.Organisms.ExpandingRowView(model: model)]
        )

        let attributedModel = Model(
            title: "How to set up a regular payment",
            icon: ExampleImages.poundSign.image,
            expandedView: exampleExpandedViewWithAttributedText(),
            accessibilityLabel: "Overrides default accessibility message",
            accessibilityExpandHint: "Show more information on how to set up a regular payment.",
            accessibilityCollapseHint: "Show less information on how to set up a regular payment."
        )
        let attributedExampleCard = Components.Atoms.CardView(
            components: [Components.Organisms.ExpandingRowView(model: attributedModel)]
        )

        return [exampleCard, attributedExampleCard]
    }

    static func exampleExpandedViewWithAttributedText() -> UIView {

        let introLabel = UILabel.styled(style: .body, string: "You’ll never forget to save if you set up a regular payment, called a standing order, with your bank.") // swiftlint:disable:this line_length
        let titleLabel = UILabel.styled(style: .bold, string: "Standing order details for your bank")

        let standingOrderInfoAccountNumber = "10028471"
        let standingOrderInfoSortCode = "60 80 77"
        let referenceNumber = "4321876345290"
        let attributedText = NSMutableAttributedString.styled(
            style: .body,
            string:
            """
            Account number: \(standingOrderInfoAccountNumber)

            Sort code: \(standingOrderInfoSortCode)

            Payment reference: \(referenceNumber)
            """
        )
        [standingOrderInfoAccountNumber, standingOrderInfoSortCode, referenceNumber].forEach {
            attributedText.setAppearance(for: .bold, subString: $0)
        }

        let insetComponent = Components.Molecules.InsetView(text: attributedText)

        return Components.Atoms.CardView(components: [introLabel, titleLabel, insetComponent])
    }
}

extension Components.StatusCardView: Examplable {
    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    @objc class func withPlaceholders() -> UIView {
        let model = Components.StatusCardView.Model(
            icon: ExampleImages.maintenance.image,
            title: "Title",
            body: "Body",
            buttonModel: .init(title: "Button Title", actionBlock: { _ in
                handler()
            }),
            journeyId: "121212-343434-565656-787878"
        )
        let view = Components.StatusCardView(model: model)

        return view
    }

    static let handler = {
        let controller = UIAlertController(title: "Tapped", message: "Button was tapped", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            controller.dismiss(animated: true, completion: nil)
        }))
        UIApplication.shared.delegate?.window??.rootViewController?
            .present(controller, animated: true, completion: nil)
    }

    //swiftlint:disable:next function_body_length
    @objc class func examples() -> [UIView] {
        let model = Components.StatusCardView.Model(
            icon: ExampleImages.maintenance.image,
            title: "Service unavailable",
            body: "You'll need to try again later.",
            journeyId: "121212-343434-565656-787878"
        )

        let modelWithButton = Components.StatusCardView.Model(
            icon: ExampleImages.info.image,
            title: "Your Help to Save account closed on 21 May 2018",
            buttonModel: .init(title: "Tell me more", actionBlock: { _ in
                handler()
            })
        )

        let modelWithButtonAndBody = Components.StatusCardView.Model(
            icon: ExampleImages.info.image,
            title: "Your Help to Save account closed on 21 May 2018",
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            buttonModel: .init(title: "Tell me more", actionBlock: { _ in
                handler()
            }),
            journeyId: "121212-343434-565656-787878"
        )

        let modelWithoutBody = Components.StatusCardView.Model(
            icon: ExampleImages.info.image,
            title: "Your Help to Save account closed on 21 May 2018"
        )

        let deceasedIconButtonView = Components.Molecules.IconButtonView(
            title: "Learn about call charges",
            accessibilityHint: nil,
            accessibilityIdentifier: nil,
            icon: ExampleImages.info.image
        )
        deceasedIconButtonView.layoutMargins = UIEdgeInsets(top: .spacer16, left: 0, bottom: .spacer16, right: 0)
        let deceasedModel = Components.StatusCardView.Model(
            icon: ExampleImages.info.image,
            title: "You can't access John Smith's information right now",
            body: NSMutableAttributedString.styled(
                style: .body,
                string: "We have been told that John Smith is deceased so we can't show the information you are expecting.\n\n" +
                "If you need to discuss this account, please contact the PAYE helpline."
                ).withAlignment(.left),
            views: [
                UIButton.styled(style: .primary(true), string: "Call 0300 200 3300"),
                deceasedIconButtonView
            ]
        )

        let ipsumWithButtonModel = Components.StatusCardView.Model(
            icon: ExampleImages.info.image,
            title: LongerIpsum,
            views: [
                UIButton.styled(style: .primary(true), string: LongIpsum)
            ]
        )
        let button = UIButton.styled(style: .secondary, string: LongIpsum)
        button.titleEdgeInsets = .zero
        button.contentEdgeInsets = .zero
        button.titleLabel?.textAlignment = .left
        button.contentHorizontalAlignment = .left
        let longModel = Components.StatusCardView.Model(
            icon: ExampleImages.coins.image,
            title: ExampleText.LoremIpsum.longer.rawValue,
            body: NSMutableAttributedString.styled(
                style: .body,
                string: ExampleText.LoremIpsum.longest.rawValue
                ).withAlignment(.center),
            iconTintColor: UIColor.Named.green1.raw,
            views: [
                button
            ]
        )
        let deceasedCard = Components.StatusCardView(model: deceasedModel)
        var margins = deceasedCard.layoutMargins
        margins.bottom = 0
        deceasedCard.layoutMargins = margins
        return [
            Components.StatusCardView(model: model),
            Components.StatusCardView(model: modelWithButton),
            Components.StatusCardView(model: modelWithoutBody),
            Components.StatusCardView(model: modelWithButtonAndBody),
            deceasedCard,
            Components.StatusCardView(model: ipsumWithButtonModel),
            Components.StatusCardView(model: longModel)
        ]
    }
}

extension Components.Organisms.IconButtonCardView: Examplable {
    typealias Model = Components.Organisms.IconButtonCardView.Model

    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    static func withPlaceholders() -> UIView {
        let iconButtonModel = Model(
            title: "Title",
            icon: ExampleImages.info.image
        )
        let view = Components.Organisms.IconButtonCardView(model: iconButtonModel)
        view.didTapButton = { (button) in
            print(button)
        }
        return view
    }

    static func examples() -> [UIView] {
        let model = Model(
            title: "About the calculator",
            icon: ExampleImages.help.image
        )

        let longModel = Model(
            title: ExampleText.LoremIpsum.longer.rawValue,
            icon: ExampleImages.help.image
        )

        return [
            Components.Organisms.IconButtonCardView(model: model).removePadding(),
            Components.Organisms.IconButtonCardView(model: longModel).removePadding()
        ]
    }
}

extension Components.Organisms.InformationMessageCard: Examplable {
    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    static func withPlaceholders() -> UIView {
        return Components.Organisms.InformationMessageCard(
            model: .init(
                    id: "",
                    theme: .info,
                    icon: UIImage(named: "warning")!,
                    headline: .init(
                        title: "Placeholder",
                        ctas: [ .init(
                            message: "CTA Message",
                            link: "",
                            accessibilityHint: "",
                            linkType: .normal,
                            displayType: .primary
                        )]
                    ),
                    bodyContent: nil
                )
            )
    }

    static func examples() -> [UIView] {
        let example1 = Components.Organisms.InformationMessageCard(
            model: .init(
                    id: "",
                    theme: .info,
                    icon: UIImage(named: "warning")!,
                    headline: .init(
                        title: "Info message",
                        body: "This is where we can have a short bit of copy about this thing.",
                        ctas: [ .init(
                            message: "Do something",
                            link: "",
                            linkType: .normal,
                            displayType: .primary
                        )]
                    ),
                    bodyContent: nil
            )
        )

        let example2 = Components.Organisms.InformationMessageCard(
            model: .init(
                    id: "",
                    theme: .warning,
                    icon: UIImage(named: "warning")!,
                    headline: .init(
                        title: "Warning Message",
                        ctas: [ .init(
                            message: "Do something with a long long message",
                            link: "",
                            linkType: .normal,
                            displayType: .primary
                        )]
                    ),
                    bodyContent: nil
            )
        )

        let example3 = Components.Organisms.InformationMessageCard(
            model: .init(
                    id: "",
                    theme: .notice,
                    icon: UIImage(named: "warning")!,
                    headline: .init(
                        title: "Notice Message",
                        ctas: nil
                    ),
                    bodyContent: nil
            )
        )
        return [
            example1,
            example2,
            example3
        ]
    }
}

extension Components.Organisms.SummaryRowView: Examplable {
    typealias View = Components.Organisms.SummaryRowView
    typealias Model = Components.Organisms.SummaryRowView.Model
    typealias Row = Components.Molecules.MultiColumnRowView

    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    static let handler = {
        let controller = UIAlertController(title: "Tapped", message: "Row was tapped", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            controller.dismiss(animated: true, completion: nil)
        }))
        UIApplication.shared.delegate?.window??.rootViewController?
            .present(controller, animated: true, completion: nil)
    }

    static func withPlaceholders() -> UIView {
        let rowModel = Model(
            title: "Title",
            rowViews: [Row(labels: ["Text 1", "Text 2", "Text 3"], style: .info)],
                icon: UIImage(named: "warning")
        )
        let view = View(model: rowModel)
        view.action = handler
        return view
    }
    // swiftlint:disable:next function_body_length
    static func examples() -> [UIView] {
        let employmentsModelSainburys = Model(
            title: "Sainsbury's PLC",
            rowViews: [
                Row(labels: ["Payroll", "96245SLJK88"], style: .info),
                Row(labels: ["Taxcode", "1185L"], style: .info),
                Row(labels: ["Estimated taxable income", "£5,690"], style: .info)
            ],
            accessibilityLabel: "Read about your income from Sainsbury's PLC",
            accessibilityHint: "opens in a web browser"
        )

        let employmentsModelEastwoodCharterSchool = Model(
            title: "Eastwood Charter School (7601)",
            rowViews: [
                Row(labels: ["Taxcode", "BR"], style: .info),
                Row(labels: ["Estimated taxable income", "£4,143"], style: .info)
            ],
            accessibilityLabel: "Read about your income from Eastwood Charter School (7601)",
            accessibilityHint: "opens in a web browser"
        )

        let fingerPrintModel = Model(
            title: "Fingerprint ID",
            rowViews: [
                Row(labels: ["On"], style: .info)
            ],
            icon: UIImage(named: "warning")
        )

        let bonusModel = Model(
            title: "",
            rowViews: [
                Row(labels: ["Final bonus", "£200"], style: .bold),
                Row(labels: ["Paid into your UK bank account from 28 February 2020"], style: .body)
            ]
        )

        let long1ColumnModel = Model(
            title: LongerIpsum,
            rowViews: [
                Row(labels: [LongestIpsum], style: .info)
            ]
        )
        let long2ColumnModel = Model(
            title: ExampleText.LoremIpsum.longer.rawValue,
            rowViews: [
                Row(labels: [LongIpsum, LongIpsum], style: .info)
            ]
        )

        let long3ColumnModelPlus1ColumnRow = Model(
            title: LongerIpsum,
            rowViews: [
                Row(labels: [LongIpsum, LongIpsum, LongIpsum], style: .info),
                Row(labels: [LongIpsum], style: .info)
            ]
        )

        var views = [UIView]()
        let employmentModels = [employmentsModelSainburys, employmentsModelEastwoodCharterSchool]
        let employmentViews = employmentModels.map { View(model: $0) }
        employmentViews.forEach { $0.action = handler }
        let container = Components.ContainerView(config: .middleLinesOnly, subviews: employmentViews)
        views.append(container)

        let otherModels = [
            fingerPrintModel
        ]

        let otherViews = otherModels.map { View(model: $0).setReader(trait: .simple) }
        otherViews.forEach { $0.action = handler }
        views.append(contentsOf: otherViews)

        let bonusView = View(model: bonusModel)
        bonusView.suppressDisclosureView = true
        views.append(bonusView)

        let ipsumModels = [
            long1ColumnModel,
            long2ColumnModel,
            long3ColumnModelPlus1ColumnRow
        ]

        let ipsumViews = ipsumModels.map { View(model: $0) }

        // set action on first and third views
        ipsumViews[0].action = handler
        ipsumViews[2].action = handler

        // change reader trait on second view
        ipsumViews[1].readerTrait = .info

        let ipsumContainer = Components.ContainerView(config: .middleLinesOnly, subviews: ipsumViews)
        views.append(ipsumContainer)

        let cardViews = views.map { Components.Atoms.CardView(components: [$0]) }

        //contents of this card manages its own padding vertically
        cardViews.forEach { $0.margins = [] }

        return cardViews
    }
}

extension Components.Organisms.MenuPanelRowView: Examplable {
    typealias View = Components.Organisms.MenuPanelRowView
    typealias Model = Components.Organisms.MenuPanelRowView.Model

    static var exampleBackgroundColor: UIColor = UIColor.Semantic.menuPageBackground

    static let handler = {
        let controller = UIAlertController(title: "Tapped", message: "Row was tapped", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            controller.dismiss(animated: true, completion: nil)
        }))
        UIApplication.shared.keyWindow?.rootViewController?
            .present(controller, animated: true, completion: nil)
    }

    static func withPlaceholders() -> UIView {
        let rowModel = Model(
            title: "Title",
            body: "Body",
            notificationMode: .number(count: 82)
        )
        let view = View(model: rowModel)
        view.action = handler
        return view
    }

    static func examples() -> [UIView] {
        let paye = Model(
            title: "Pay As You Earn (PAYE)",
            body: "Check your tax codes and Income Tax from PAYE sources",
            notificationMode: .hidden
        )
        let annualTaxSummary = Model(
            title: "Annual Tax Summary",
            body: "View your tax and National Insurance contributions and find out how the government spends your taxes.",
            notificationMode: .hidden,
            accessibilityHint: "Opens in a web browser."
        )
        let messages = Model(
            title: "Messages",
            body: "Messages and letters from HMRC",
            notificationMode: .number(count: 2)
        )
        let manyMessages = Model(
            title: "An example with a very very long title that spans multiple lines",
            body: "An example with a very very log body that spans multiple lines. This card has 1000 new notifications, but has a max display of 99.",
            notificationMode: .number(count: 1000, max: 99)
        )
        let noMessages = Model(
            title: "Messages",
            body: "Messages and letters from HMRC",
            notificationMode: .number(count: 0, hideWhenZero: false)
        )
        let noMessagesHidden = Model(
            title: "Messages",
            body: "Messages and letters from HMRC",
            notificationMode: .number(count: 0)
        )
        let hts = Model(
            title: "Help to Save account",
            body: "A savings account with bonuses designed to help you start saving",
            notificationMode: .circle
        )

        let models = [paye, annualTaxSummary, messages, manyMessages, noMessages, noMessagesHidden, hts]
        return models.map { (model) -> UIView in
            let view = Self.init(model: model)
            view.action = handler
            return view
        }
    }
}
