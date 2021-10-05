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
import SnapKit

public struct LabelColumn {
    let style: LabelStyle
    let canCopy: Bool
    let huggingPriority: UILayoutPriority

    public init(style: LabelStyle, canCopy: Bool = false, huggingPriority: UILayoutPriority = .required) {
        self.style = style
        self.canCopy = canCopy
        self.huggingPriority = huggingPriority
    }
}

extension Components.Molecules {
    open class MultiColumnRowView: DebugOverlayableView {

        private struct Constants {
            static let itemSpacing: CGFloat = 13
        }

        let stackView = UIStackView()
        public var labels = [UILabel]()

        public convenience init(labels: [String]?=nil, style: LabelStyle = .body) {
            self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            updateUI(with: labels, style: style)
        }

        public convenience init(labels: [String]?=nil, attributes: [LabelColumn]) {
            self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            updateUI(with: labels, attributes: attributes)
        }

        public convenience init(labels: [NSAttributedString]?=nil, attributes: [LabelColumn]) {
            self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            updateUI(with: labels, attributes: attributes)
        }

        public override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("Dont call this.")
        }

        open func commonInit() {
            print("]]]] MCRV: commonInit")
            setupStackView()
            setContraints()
            disableTranslatesAutoresizingMaskIntoConstraints()
            // TEST
            setNeedsUpdateConstraints()
            updateConstraintsIfNeeded()
        }

        private func setupStackView() {
            print("]]]] MCRV: setupStackView")
            addSubview(stackView)
            stackView.spacing = Constants.itemSpacing
//            stackView.axis = (FontMetrics.scaler > 1) ? .vertical : .horizontal
//            stackView.alignment = (FontMetrics.scaler > 1) ? .leading : .top
            stackView.axis = .horizontal
            stackView.alignment = .top
            stackView.distribution = .fillProportionally
//            stackView.setContentHuggingPriority(.required, for: .vertical)
        }

        private func setContraints() {
            print("]]]] MCRV: setContraints")
            stackView.snp.makeConstraints { (make) in
                make.edges.equalTo(self)
            }
        }

        private func disableTranslatesAutoresizingMaskIntoConstraints() {
            print("]]]] MCRV: disableTranslatesAutoresizingMaskIntoConstraints")
            translatesAutoresizingMaskIntoConstraints = false
            stackView.translatesAutoresizingMaskIntoConstraints = false
//            setContentHuggingPriority(.required, for: .vertical)
        }

        public func updateUI(with labels: [String]?, style: LabelStyle = .body) {
            print("]]]] MCRV: updateUI 1")
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
            print("]]]] MCRV: updateUI 2")
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
            self.labels.forEach({ stackView.addArrangedSubview($0) })
        }

        public func updateUI(with labels: [NSAttributedString]?, attributes: [LabelColumn]) {
            print("]]]] MCRV: updateUI 3")
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
            self.labels.forEach({ stackView.addArrangedSubview($0) })
        }

        private func update(label: UILabel, column: LabelColumn, index: Int) -> UILabel {
            print("]]]] MCRV: update")
            label.copyable = column.canCopy

            let priority = (stackView.axis == .horizontal) ? column.huggingPriority : .required
//            label.setContentCompressionResistancePriority(.required, for: .horizontal)
//            label.setContentHuggingPriority(priority, for: .horizontal)
//            label.setContentCompressionResistancePriority(.required, for: .vertical)
//            label.setContentHuggingPriority(.required, for: .vertical)

            if stackView.axis == .vertical {
                label.textAlignment = .left
            } else {
                label.textAlignment = index == 0 ? .left : .right
            }
            label.invalidateIntrinsicContentSize()
            return label
        }
    }
}
