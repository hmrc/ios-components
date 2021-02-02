/*
 * Copyright 2016 HM Revenue & Customs
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

open class SeparatorView: UIView {
    open override class var requiresConstraintBasedLayout: Bool { return true }

    let separatorView = UIView.build()
    let separatorColor: UIColor
    let shouldCenterY: Bool
    let heightConstraintValue: CGFloat
    let lineThickness: CGFloat

    public init(config: SeparatorConfiguration) {

        self.separatorColor = config.separatorColor
        self.shouldCenterY = true
        self.heightConstraintValue = config.totalThickness
        self.lineThickness = config.dividerLineThickness

        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.layoutMargins = config.layoutMargins

        self.backgroundColor = config.backgroundColor
        commonInit()
    }

    open func commonInit() {
        addViews()
        setupStyle()
        setupConstraints()
        setNeedsUpdateConstraints()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addViews() {
        addSubview(separatorView)
    }

    func setupStyle() {
        separatorView.backgroundColor = separatorColor
    }

    func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: lineThickness),

            heightAnchor.constraint(equalToConstant: heightConstraintValue),
        ])

        if shouldCenterY {
            separatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        } else {
            separatorView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        }
    }
}

extension Sequence {
    func flatZip(_ sequence: Self) -> [Self.Element] {
        return zip(self, sequence).flatMap {[$0.0, $0.1]}
    }
}

public class SeparatorConfiguration {
    public typealias CreateSeparator = (() -> SeparatorView)
    public var separatorFirst: Bool
    public var includeMiddle: Bool
    public var includeLast: Bool
    public var backgroundColor: UIColor
    public var separatorColor: UIColor
    public var dividerLineThickness: CGFloat
    public var totalThickness: CGFloat
    public var layoutMargins: UIEdgeInsets
    public var createSeparator: CreateSeparator?

    // Define public initialiser to allow usage outside the framework
    public init(
        separatorFirst: Bool,
        includeMiddle: Bool,
        includeLast: Bool,
        backgroundColor: UIColor,
        separatorColor: UIColor,
        dividerLineThickness: CGFloat,
        totalThickness: CGFloat,
        layoutMargins: UIEdgeInsets,
        createSeparator: CreateSeparator?
    ) {
        self.separatorFirst = separatorFirst
        self.includeMiddle = includeMiddle
        self.includeLast = includeLast
        self.backgroundColor = backgroundColor
        self.separatorColor = separatorColor
        self.dividerLineThickness = dividerLineThickness
        self.totalThickness = totalThickness
        self.layoutMargins = layoutMargins
        self.createSeparator = createSeparator
    }

    public func set(separatorFirst: Bool) -> Self {
        self.separatorFirst = separatorFirst
        return self
    }

    public func set(includeMiddle: Bool) -> Self {
        self.includeMiddle = includeMiddle
        return self
    }

    public func set(backgroundColor: UIColor) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }

    public func set(separatorColor: UIColor) -> Self {
        self.separatorColor = separatorColor
        return self
    }

    public func set(dividerLineThickness: CGFloat) -> Self {
        self.dividerLineThickness = dividerLineThickness
        return self
    }

    public func set(totalThickness: CGFloat) -> Self {
        self.totalThickness = totalThickness
        return self
    }

    public func set(layoutMargins: UIEdgeInsets) -> Self {
        self.layoutMargins = layoutMargins
        return self
    }

    public func set(createSeparator: CreateSeparator?) -> Self {
        self.createSeparator = createSeparator
        return self
    }

    ///Draws separator lines using the default colour and thickness
    ///Between views but not at top or bottom
    public static let middleLinesOnly = SeparatorConfiguration(
        separatorFirst: false,
        includeMiddle: true,
        includeLast: false,
        backgroundColor: .clear,
        separatorColor: UIColor.Semantic.divider.raw,
        dividerLineThickness: 1,
        totalThickness: 1,
        layoutMargins: .standardCardHorizontal,
        createSeparator: nil)

    public static let middleLinesOnlyFullWidth = SeparatorConfiguration(
        separatorFirst: false,
        includeMiddle: true,
        includeLast: false,
        backgroundColor: .clear,
        separatorColor: UIColor.Semantic.divider.raw,
        dividerLineThickness: 1,
        totalThickness: 1,
        layoutMargins: .zero,
        createSeparator: nil)

    public static let allLinesFullWidth = SeparatorConfiguration(
        separatorFirst: true,
        includeMiddle: true,
        includeLast: true,
        backgroundColor: .clear,
        separatorColor: UIColor.Semantic.divider.raw,
        dividerLineThickness: 1,
        totalThickness: 1,
        layoutMargins: .zero,
        createSeparator: nil)

    ///Draws no lines between views at all
    public static let noLines = SeparatorConfiguration(
        separatorFirst: false,
        includeMiddle: false,
        includeLast: false,
        backgroundColor: .clear,
        separatorColor: .clear,
        dividerLineThickness: 1,
        totalThickness: 1,
        layoutMargins: .zero,
        createSeparator: nil)
}

extension Array where Element == UIView {

    func separate(_ configuration: SeparatorConfiguration) -> [Element] {
        let create = configuration.createSeparator ?? {
            return SeparatorView(config: configuration)
        }

        if !configuration.includeMiddle {
            var out = [UIView]()

            if configuration.separatorFirst {
                out.append(create())
            }
            out.append(contentsOf: self)

            if configuration.includeLast {
                out.append(create())
            }
            return out

        } else {
            let separators = self.map {_ in create()} as [UIView]
            if configuration.separatorFirst {
                var all = separators.flatZip(self)
                if configuration.includeLast {
                    all.append(create())
                }
                return all
            } else {
                let all = self.flatZip(separators)
                return configuration.includeLast ? all : Array(all.dropLast())
            }
        }
    }
}
