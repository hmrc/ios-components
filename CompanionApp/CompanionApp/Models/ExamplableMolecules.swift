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

extension Components.Molecules.TextInputView: Examplable {
    typealias TextInputView = Components.Molecules.TextInputView
    typealias Model = TextInputView.Model

    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    @objc class func withPlaceholders() -> UIView {
        let molecule = TextInputView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        molecule.updateUI(for: Model(title: "Title", leftViewText: "@leftText", initialText: "InitialText", maxLength: 20))
        molecule.set(validationError: "Validation Error")
        return molecule
    }

    @objc class func examples() -> [UIView] {
        let withoutCharCount = TextInputView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        withoutCharCount.updateUI(for: Model(title: "Enter text", initialText: "Some text", maxLength: 0))

        let withCharCount = TextInputView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        withCharCount.updateUI(for: Model(title: "Enter text", initialText: "Some text", maxLength: 10))

        let withCharCountNotEnforced = TextInputView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        withCharCountNotEnforced.updateUI(
            for: Model(
                title: "Enter text",
                leftViewText: nil,
                initialText: "Some text with limit not enforced",
                maxLength: 10
            )
        )
        withCharCountNotEnforced.enforceMaxLength = false

        let withValidationError = TextInputView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        withValidationError.updateUI(for: Model(title: "Enter text", initialText: "Some text", maxLength: 100))
        withValidationError.set(validationError: "Validation Error")

        let multiLine = TextInputView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        multiLine.updateUI(
            for: Model(
                title: "Multi Line",
                initialText: "Multi line\nMultiPass",
                maxLength: 100,
                multiLine: true
            )
        )
        return [
            Components.Atoms.CardView(components: [withCharCount, withoutCharCount, withCharCountNotEnforced, withValidationError, multiLine])
        ]
    }

    // swiftlint:enable line_length
}

extension Components.Molecules.SelectRowView: Examplable {
    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    static func withPlaceholders() -> UIView {
        return self.init(
            model: .init(imageTintColor: UIColor.Named.black.colour, rows: [
                .init(body: "Option 1")
            ])
        )
    }

    static func examples() -> [UIView] {
        return [
            self.init(
                model: .init(rows: [
                    .init(isSelected: true, body: "Option 1"),
                    .init(body: "Option 2"),
                    .init(body: "Option 3"),
                    .init(body: "Option 4")
                ])
            )
        ]
    }
}

extension Components.Molecules.SelectRowGroupView: Examplable {
    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    static func withPlaceholders() -> UIView {
        return self.init(
            title: "title",
            subTitle: "subTitle",
            rowContent: [
                .init(label: "label 1", accessibilityIdentifier: "accessibility Identifier 1"),
                .init(label: "label 2", accessibilityIdentifier: "accessibility Identifier 2")
            ],
            selectedIndex: nil
        )
    }

    static func examples() -> [UIView] {
        let withSelectedIndex = self.init(
            title: "Can we collect analytics data when you use this app?",
            subTitle: "",
            rowContent: [
                .init(label: "yes", accessibilityIdentifier: "RadioButtonYes"),
                .init(label: "no", accessibilityIdentifier: "RadioButtonNo")
            ],
            selectedIndex: 0
        )

        let withValidationError = self.init(
            title: "Are you moving goods?",
            subTitle: "",
            rowContent: [
                .init(label: "yes", accessibilityIdentifier: "RadioButtonYes"),
                .init(label: "no", accessibilityIdentifier: "RadioButtonNo")
            ],
            selectedIndex: nil
        )
        withValidationError.set(validationError: "You must select yes or no")

        return [withSelectedIndex, withValidationError]
    }
}

extension Components.Molecules.WarningView: Examplable {
    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    static func withPlaceholders() -> UIView {
        return self.init(model: .init(text: "Body Text"))
    }

    static func examples() -> [UIView] {
        let warningView0 = self.init(model: .init(
            text: "You must renew your tax credits by 31 July 2019"
        ))
        let warningView = self.init(model: .init(
            text: "We are currently working out your payments as your child is changing their education or training. This should be done by 7 September 2019." //swiftlint:disable:this line_length
        ))
        let warningView2 = self.init(model: .init(
            text: ExampleText.LoremIpsum.longest.rawValue
        ))
        return [
            Components.Atoms.CardView(components: [warningView0]),
            Components.Atoms.CardView(components: [warningView]),
            Components.Atoms.CardView(components: [warningView2])
        ]
    }
}

extension Components.Molecules.CurrencyInputView {
    typealias CurrencyInputView = Components.Molecules.CurrencyInputView
    typealias Model = CurrencyInputViewModel

    @objc override class func withPlaceholders() -> UIView {
        let molecule = CurrencyInputView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        molecule.updateUI(for: Model(title: "Title", initialText: "InitialText", maxLength: 5))
        molecule.set(validationError: "Validation Error")
        return molecule
    }

    @objc override class func examples() -> [UIView] {
        let payment = CurrencyInputView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        payment.updateUI(for: Model(title: "Pay amount", initialText: "49.99", maxLength: 5))

        return [
            Components.Atoms.CardView(components: [payment])
        ]
    }
}

extension Components.Molecules.TabBarView: Examplable {
    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    static func withPlaceholders() -> UIView {
        let segment1 = Model.Segment(title: "Title 1", startSelected: true) { }
        let segment2 = Model.Segment(title: "Title 2") { }
        let segment3 = Model.Segment(title: "Title 3") { }
        let model = Model(segments: [
            segment1,
            segment2,
            segment3
        ], theme: Model.Theme.dark)
        return self.init(model: model)
    }

    static func examples() -> [UIView] {
        let lightShortModel = Model(segments: [
            .init(title: "Short 1", startSelected: true) { },
            .init(title: "Short 2") { },
            .init(title: "Short 3") { }
        ], theme: .light)

        let lightLongModel = Model(segments: [
            .init(title: "First Full Title", startSelected: true) { },
            .init(title: "Second Full Title") { },
            .init(title: "Third Full Title") { }
        ], theme: .light)

        let darkShortModel = Model(segments: [
            .init(title: "Short 1", startSelected: true) { },
            .init(title: "Short 2") { },
            .init(title: "Short 3") { }
        ], theme: .dark)

        let darkLongModel = Model(segments: [
            .init(title: "First Full Title", startSelected: true) { },
            .init(title: "Second Full Title") { },
            .init(title: "Third Full Title") { }
        ], theme: .dark)

        return [
            self.init(model: lightShortModel),
            self.init(model: lightLongModel),
            self.init(model: darkShortModel),
            self.init(model: darkLongModel)
        ]
    }
}

extension Components.Molecules.H4TitleBodyView: Examplable {
    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    static func withPlaceholders() -> UIView {
        return Components.Molecules.H4TitleBodyView(
            title: "Title",
            body: "Body"
        )
    }

    static func examples() -> [UIView] {
        let view = Components.Molecules.H4TitleBodyView(
            title: "Pay As You Earn",
            body: "6 April 2018 to 5 April 2019"
        )

        let longView = Components.Molecules.H4TitleBodyView(
            title: ExampleText.LoremIpsum.long.rawValue,
            body: ExampleText.LoremIpsum.longer.rawValue
        )

        return [
            Components.Atoms.CardView(components: [view]),
            Components.Atoms.CardView(components: [longView])
        ]
    }
}

extension Components.Molecules.H5TitleBodyView: Examplable {
    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    static func withPlaceholders() -> UIView {
        return Components.Molecules.H5TitleBodyView(
            title: "Title",
            body: "Body"
        )
    }

    static func examples() -> [UIView] {
        let view = Components.Molecules.H5TitleBodyView(
            title: "You don't have any money in this account.",
            body: "Your closing balance of £240 was transferred to your UK bank account on 28 February 2020."
        )

        let longView = Components.Molecules.H5TitleBodyView(
            title: ExampleText.LoremIpsum.longer.rawValue,
            body: ExampleText.LoremIpsum.longest.rawValue
        )

        return [
            Components.Atoms.CardView(components: [view]),
            Components.Atoms.CardView(components: [longView])
        ]
    }
}

extension Components.Molecules.BoldTitleBodyView: Examplable {
    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    static func withPlaceholders() -> UIView {
        return Components.Molecules.BoldTitleBodyView(
            title: "Title",
            body: "Body"
        )
    }

    static func examples() -> [UIView] {
        let view = Components.Molecules.BoldTitleBodyView(
            title: "Date and time",
            body: "7 February 2019 at 17:12:45 GMT"
        )

        let longView = Components.Molecules.BoldTitleBodyView(
            title: ExampleText.LoremIpsum.longer.rawValue,
            body: ExampleText.LoremIpsum.longest.rawValue
        )

        return [
            Components.Atoms.CardView(components: [view]),
            Components.Atoms.CardView(components: [longView])
        ]
    }
}

extension Components.Molecules.InsetView: Examplable {
    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    static func withPlaceholders() -> UIView {
        return Components.Molecules.InsetView(
            text: "Inset text"
        )
    }

    static func examples() -> [UIView] {
        let textExample = Components.Molecules.InsetView(
            text: "Your employer or pension provider takes off Income Tax before they pay you. This is called Pay As You Earn (PAYE). The amount of tax you pay depends on your income, how much of it is tax-free, and your tax code."  // swiftlint:disable:this line_length
        )

        let multiColView1 = Components.Molecules.MultiColumnRowView(
            labels: [
                "Child Tax Credit",
                "£124.56"
            ],
            attributes: [
                LabelColumn(style: .bold, canCopy: false),
                LabelColumn(style: .body, canCopy: true)
            ]
        )

        let multiColView2 = Components.Molecules.MultiColumnRowView(
            labels: [
                "Working Tax Credit",
                "£171.84"
            ],
            attributes: [
                LabelColumn(style: .bold, canCopy: false),
                LabelColumn(style: .body, canCopy: true)
            ]
        )

        let multiColView3 = Components.Molecules.MultiColumnRowView(
            labels: [
                "Another Tax Credit",
                "£15.23"
            ],
            attributes: [
                LabelColumn(style: .bold, canCopy: false),
                LabelColumn(style: .body, canCopy: true)
            ]
        )

        let multiColExpample = Components.Molecules.InsetView(views: [multiColView1, multiColView2, multiColView3])

        return [
            Components.Atoms.CardView(components: [textExample]),
            Components.Atoms.CardView(components: [multiColExpample])
        ]
    }
}

extension Components.Molecules.MultiColumnRowView: Examplable {
    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    static func withPlaceholders() -> UIView {
        return Components.Molecules.MultiColumnRowView(
            labels: ["Label 1", "Label 2", "Label 3"]
        )
    }

    static func examples() -> [UIView] {
        let oneLabelExample = Components.Molecules.MultiColumnRowView(
            labels: ["Estimated annual income"]
        )
        let oneLabelInfoExample = Components.Molecules.MultiColumnRowView(
            labels: [ExampleText.LoremIpsum.longest.rawValue],
            style: .error
        )
        let twoLabelExample = Components.Molecules.MultiColumnRowView(
            labels: ["Estimated annual income", "£24,000"],
            attributes: [
                LabelColumn(proportionalWidth: 0.6),
                LabelColumn(proportionalWidth: 0.4)
            ]
        )
        let twoLabelBoldExample = Components.Molecules.MultiColumnRowView(
            labels: [ExampleText.LoremIpsum.longer.rawValue,
                     ExampleText.LoremIpsum.long.rawValue],
            style: .bold
        )
        let twoLabelMixedStyleExample = Components.Molecules.MultiColumnRowView(
            labels: [
                "Account number",
                "10084712"
            ],
            attributes: [
                LabelColumn(style: .body, canCopy: false),
                LabelColumn(style: .bold, canCopy: true, accessibilityHint: "Your account number")
            ]
        )
        let twoLabelDifferingPriorityExample = Components.Molecules.MultiColumnRowView(
            labels: [
                "Your final bonus",
                "£0"
            ],
            attributes: [
                LabelColumn(style: .body, huggingPriority: .required),
                LabelColumn(style: .bold, huggingPriority: .defaultHigh)
            ]
        )
        let threeLabelExample = Components.Molecules.MultiColumnRowView(
            labels: ["£31,865", "20%", "£6,373"],
            style: .info
        )
        let threeLabelBoldExample = Components.Molecules.MultiColumnRowView(
            labels: [ExampleText.LoremIpsum.long.rawValue,
                     ExampleText.LoremIpsum.long.rawValue,
                     ExampleText.LoremIpsum.long.rawValue]
        )

        return [
            oneLabelExample,
            oneLabelInfoExample,
            twoLabelExample,
            twoLabelBoldExample,
            twoLabelMixedStyleExample,
            twoLabelDifferingPriorityExample,
            threeLabelExample,
            threeLabelBoldExample
        ].map {
            Components.Atoms.CardView(components: [$0])
        }
    }
}

extension Components.Molecules.IconButtonView: Examplable {
    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    static func withPlaceholders() -> UIView {
        let view = Components.Molecules.IconButtonView(
            title: "Title",
            icon: ExampleImages.info.image
        )
        view.didTapButton = { (button) in
            print(button)
        }
        return view
    }

    static func examples() -> [UIView] {
        let view = Components.Molecules.IconButtonView(
            title: "About the calculator",
            icon: ExampleImages.help.image
        )
        let longView = Components.Molecules.IconButtonView(
            title: ExampleText.LoremIpsum.longer.rawValue,
            icon: ExampleImages.help.image
        )
        return [
            Components.Atoms.CardView(components: [view]).removePadding(),
            Components.Atoms.CardView(components: [longView]).removePadding()
        ]
    }
}

extension Components.Molecules.StatusView: Examplable {
    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    static func withPlaceholders() -> UIView {
        let model = Components.Molecules.StatusView.Model(
            icon: ExampleImages.maintenance.image,
            title: "Title",
            body: "Body"
        )

        return Components.Molecules.StatusView(model: model)
    }

    static func examples() -> [UIView] {
        let model = Components.Molecules.StatusView.Model(
            icon: ExampleImages.maintenance.image,
            title: "Service unavailable",
            body: "You'll need to try again later."
        )

        let modelWithoutBody = Components.Molecules.StatusView.Model(
            icon: ExampleImages.info.image,
            title: "Your Help to Save account closed on 21 May 2018"
        )

        let longModel = Components.StatusCardView.Model(
            icon: ExampleImages.coins.image,
            title: ExampleText.LoremIpsum.longer.rawValue,
            body: NSMutableAttributedString.styled(
                style: .body,
                string: ExampleText.LoremIpsum.longest.rawValue
            ).withAlignment(.left),
            iconTintColor: UIColor.Named.green1.colour
        )

        return [model, modelWithoutBody, longModel].map {
            Components.Atoms.CardView(components: [
                Components.Molecules.StatusView(model: $0)
            ])
        }
    }
}

extension Components.Molecules.SwitchRowView: Examplable {
    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground
    
    static func withPlaceholders() -> UIView {
        let model = Components.Molecules.SwitchRowView.Model(
            title: "Title",
            body: "Body. Switch: off",
            isOn: false
        )
        let view = Components.Molecules.SwitchRowView(model: model)
        view.valueChanged = { isOn in
            let model = Components.Molecules.SwitchRowView.Model(
                title: "Title",
                body: "Body. Switch: " + (isOn ? "on" : "off"),
                isOn: isOn
            )
            view.updateUI(for: model)
        }
        return view
    }

    static func examples() -> [UIView] {
        let startOfMonthModel = Components.Molecules.SwitchRowView.Model(
            title: "Start of the month",
            body: "Get a reminder on the first day of each month",
            isOn: true
        )
        let startOfMonth = Components.Molecules.SwitchRowView(model: startOfMonthModel)

        let endOfMonthModel = Components.Molecules.SwitchRowView.Model(
            title: "End of the month",
            body: "Get a reminder 5 days before the end of each month",
            isOn: false
        )
        let endOfMonth = Components.Molecules.SwitchRowView(model: endOfMonthModel)

        let fingerPrintModel = Components.Molecules.SwitchRowView.Model(
            title: "Fingerprint ID",
            isOn: false
        )
        let fingerPrint = Components.Molecules.SwitchRowView(model: fingerPrintModel)

        let loremTitleOnlyModel = Components.Molecules.SwitchRowView.Model(
            title: LongIpsum,
            isOn: false
        )
        let loremTitleOnly = Components.Molecules.SwitchRowView(model: loremTitleOnlyModel)

        let loremTitleAndBodyModel = Components.Molecules.SwitchRowView.Model(
            title: LongIpsum,
            body: LongestIpsum,
            isOn: false
        )
        let loremTitleAndBody = Components.Molecules.SwitchRowView(model: loremTitleAndBodyModel)

        let all = [startOfMonth, endOfMonth, fingerPrint, loremTitleOnly, loremTitleAndBody]
        return all.map {
            Components.Atoms.CardView(components: [$0])
        }
    }
}

extension Components.Molecules.DonutChartView: Examplable {
    static var exampleBackgroundColor: UIColor = UIColor.Semantic.pageBackground

    static func withPlaceholders() -> UIView {
        let chart = Components.Molecules.DonutChartView(
            model: .init(
                primaryColor: .Named.teal.colour,
                secondaryColor: .init(hexString: "#003078")
            )
        )
        chart.setValues(ratio: 0.34, animated: false)
        NSLayoutConstraint.activate([
            chart.heightAnchor.constraint(equalToConstant: 200),
            chart.widthAnchor.constraint(equalToConstant: 200)
        ])
        return chart
    }

    static func examples() -> [UIView] {
        let chart1 = Components.Molecules.DonutChartView(
            model: .init(
                primaryColor: .Named.yellow.colour,
                secondaryColor: .Named.pink.colour
            )
        )
        let chart2 = Components.Molecules.DonutChartView(
            model: .init(
                primaryColor: .Named.teal.colour,
                secondaryColor: .init(hexString: "#003078")
            )
        )
        return [
            ExampleDonutChartView(donut: chart1, ratio: 0.25),
            ExampleDonutChartView(donut: chart2, ratio: 0.1),
        ]
    }

    class ExampleDonutChartView: Components.Atoms.CardView {
        let donut: Components.Molecules.DonutChartView
        var ratio: CGFloat

        let button = UIButton.styled(style: .primary(true), string: "Animate")
        let slider = UISlider(frame: .zero)

        init(donut: Components.Molecules.DonutChartView, ratio: CGFloat) {
            NSLayoutConstraint.activate([
                donut.heightAnchor.constraint(equalToConstant: 200),
                donut.widthAnchor.constraint(equalToConstant: 200)
            ])
            self.donut = donut
            self.ratio = ratio
            slider.value = Float(ratio)
            super.init(components: [
                donut,
                slider,
                button
            ])
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            slider.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
            donut.setValues(ratio: 0, animated: false)
        }

        @objc func didTapButton() {
            donut.setValues(ratio: ratio, animated: true, fromCurrent: true)
        }

        @objc func valueChanged() {
            ratio = CGFloat(slider.value)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
