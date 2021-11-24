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

public struct LabelColumn {
    let style: LabelStyle
    let canCopy: Bool
    let huggingPriority: UILayoutPriority
    let proportionalWidth: CGFloat?

    public init(style: LabelStyle = .body,
                canCopy: Bool = false,
                huggingPriority: UILayoutPriority = .required,
                proportionalWidth: CGFloat? = nil
    ) {
        self.style = style
        self.canCopy = canCopy
        self.huggingPriority = huggingPriority
        self.proportionalWidth = proportionalWidth
    }
}

extension Components.Molecules {
    open class MultiColumnRowView: DebugOverlayableView {

        public enum Axis {
            case horizontal
            case vertical
        }
        public var axis: Axis = .horizontal

        private struct Constants {
            static let itemSpacing: CGFloat = 12
        }

        public var labels = [UILabel]()
        public var spacers = [UIView]()

        public var horizontalConstraints: [NSLayoutConstraint]!
        public var verticalConstraints: [NSLayoutConstraint]!

        public required init() {
            super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            translatesAutoresizingMaskIntoConstraints = false
            axis = (FontMetrics.scaler > 1.36) ? .vertical : .horizontal
        }

        public convenience init(labels: [String]?=nil, style: LabelStyle = .body) {
            self.init()
            updateUI(with: labels, style: style)
        }

        public convenience init(labels: [String]?=nil, attributes: [LabelColumn]) {
            self.init()
            updateUI(with: labels, attributes: attributes)
        }

        public convenience init(labels: [NSAttributedString]?=nil, attributes: [LabelColumn]) {
            self.init()
            updateUI(with: labels, attributes: attributes)
        }

        @available(*, unavailable)
        required public init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        public func updateUI(with labels: [String]?, style: LabelStyle = .body) {
            self.labels.forEach { $0.removeFromSuperview() }
            guard let labels = labels else { return }

            updateUI(with: labels, attributes: Array(
                repeating: LabelColumn(
                    style: style,
                    canCopy: false
                ),
                count: labels.count
            ))
        }

        public func updateUI(with labels: [String]?, attributes: [LabelColumn]) {
            self.labels.forEach { $0.removeFromSuperview() }
            guard let labels = labels, labels.count == attributes.count else { return }

            self.labels = zip(labels, attributes).enumerated().map({ (index, zipped) in
                let (text, column) = zipped
                let label = UILabel.styled(
                    style: column.style,
                    string: text
                )
                return self.update(label: label, column: column, index: index)
            })
            setupLabelsAndConstraints(attributes: attributes)
        }

        public func updateUI(with labels: [NSAttributedString]?, attributes: [LabelColumn]) {
            self.labels.forEach { $0.removeFromSuperview() }
            guard let labels = labels, labels.count == attributes.count else { return }

            self.labels = zip(labels, attributes).enumerated().map({ (index, zipped) in
                let (text, column) = zipped
                let label = UILabel.styled(
                    style: column.style,
                    string: text
                )
                return self.update(label: label, column: column, index: index)
            })
            setupLabelsAndConstraints(attributes: attributes)
        }

        private func update(label: UILabel, column: LabelColumn, index: Int) -> UILabel {
            label.copyable = column.canCopy

            let priority = (axis == .horizontal) ? column.huggingPriority : .required
            label.setContentCompressionResistancePriority(.required, for: .horizontal)
            label.setContentHuggingPriority(priority, for: .horizontal)
            label.setContentCompressionResistancePriority(.required, for: .vertical)
            label.setContentHuggingPriority(.required, for: .vertical)

            if axis == .vertical {
                label.textAlignment = .left
            } else {
                label.textAlignment = index == 0 ? .left : .right
            }
            label.invalidateIntrinsicContentSize()
            return label
        }

        private func setupLabelsAndConstraints(attributes: [LabelColumn]) {
            guard !labels.isEmpty else { return }

            let equalProportionalWidth: CGFloat = 1.0 / CGFloat(labels.count)
            var previousLabel: UILabel?

            horizontalConstraints = []
            verticalConstraints = []

            zip(labels, attributes).enumerated().forEach { index, zipped in
                let (label, column) = zipped

                let proportionalWidth: CGFloat? =
                    shouldUseProportionalWidths(attributes: attributes) ?
                    (column.proportionalWidth ?? equalProportionalWidth) : nil

                addSubview(label)

                addHorizontalConstraintsFor(
                    label: label,
                    index: index,
                    previousLabel: previousLabel,
                    proportionalWidth: proportionalWidth,
                    numColumns: labels.count
                )

                addVerticalConstraintsFor(
                    label: label,
                    index: index,
                    previousLabel: previousLabel
                )

                previousLabel = label
            }

            if axis == .horizontal {
                NSLayoutConstraint.deactivate(verticalConstraints)
                NSLayoutConstraint.activate(horizontalConstraints)

            } else {
                NSLayoutConstraint.deactivate(horizontalConstraints)
                NSLayoutConstraint.activate((verticalConstraints))
            }

            setNeedsUpdateConstraints()
        }

        func shouldUseProportionalWidths(attributes: [LabelColumn]) -> Bool {
            attributes.reduce(true) { result, column in
                result && column.huggingPriority == .required
            }
        }

        func addHorizontalConstraintsFor(
            label: UILabel,
            index: Int,
            previousLabel: UILabel?,
            proportionalWidth: CGFloat?,
            numColumns: Int
        ) {
            horizontalConstraints.append(
                contentsOf: [
                    label.topAnchor.constraint(equalTo: topAnchor),
                    heightAnchor.constraint(greaterThanOrEqualTo: label.heightAnchor)
                ]
            )

            if let proportionalWidth = proportionalWidth {
                let widthAdjustment = 0 - ((CGFloat(numColumns) - 1) * CGFloat(Constants.itemSpacing)) / CGFloat(numColumns)
                horizontalConstraints.append(
                    label.widthAnchor.constraint(
                        greaterThanOrEqualTo: widthAnchor,
                        multiplier: proportionalWidth,
                        constant: widthAdjustment
                    )
                )
            }

            if let previousLabel = previousLabel {
                let spacingConstraint = label.leftAnchor.constraint(
                    equalTo: previousLabel.rightAnchor, constant: Constants.itemSpacing
                )
                spacingConstraint.priority = .defaultLow
                horizontalConstraints.append(spacingConstraint)
            } else {
                horizontalConstraints.append(label.leftAnchor.constraint(equalTo: leftAnchor))
            }

            if index == (labels.count - 1) {
                horizontalConstraints.append(label.rightAnchor.constraint(equalTo: rightAnchor))
            }
        }

        func addVerticalConstraintsFor(
            label: UILabel,
            index: Int,
            previousLabel: UILabel?
        ) {
            verticalConstraints.append(
                contentsOf: [
                    label.leftAnchor.constraint(equalTo: leftAnchor),
                    label.rightAnchor.constraint(equalTo: rightAnchor),
                ]
            )

            if let previousLabel = previousLabel {
                verticalConstraints.append(
                    label.topAnchor.constraint(
                        equalTo: previousLabel.bottomAnchor, constant: Constants.itemSpacing
                    )
                )
            } else {
                verticalConstraints.append(
                    label.topAnchor.constraint(equalTo: topAnchor)
                )
            }

            if index == (labels.count - 1) {
                verticalConstraints.append(
                    label.bottomAnchor.constraint(equalTo: bottomAnchor)
                )
            }
        }
    }
}

