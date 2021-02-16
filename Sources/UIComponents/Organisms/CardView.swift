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

extension UIEdgeInsets {
    mutating func adjust(_ edges: Components.Edges, margin: CGFloat) {
        if edges.contains(.left) { left = margin }
        if edges.contains(.top) { top = margin }
        if edges.contains(.right) { right = margin }
        if edges.contains(.bottom) { bottom = margin }
    }
}

extension Components {
    public enum Edge: String, Option {
        case left, top, right, bottom
    }

    public typealias Edges = Set<Components.Edge>
}

extension Set where Element == Components.Edge {
    public static var all: Set<Components.Edge> {
        return Set(Element.allCases)
    }

    public static var horizontal: Set<Components.Edge> {
        return [Components.Edge.left, Components.Edge.right]
    }

    public static var vertical: Set<Components.Edge> {
        return [Components.Edge.left, Components.Edge.right]
    }
}

extension Components.Atoms {
    open class CardView: DebugOverlayableView {
        public struct Constants {
            public static let itemSpacing: CGFloat = .spacer12
            public static let margins = UIEdgeInsets(padding: .spacer16)
        }

        // MARK: - Views & Outlets

        public var components = [UIView]()
        public let stackView = UIStackView()
        private let itemSpacing: CGFloat
        private var stackViewBottomAnchor: NSLayoutConstraint?

        // MARK: - Initialisation

        public init(
            components: [UIView],
            accessibilityIdentifier: String = "CardView",
            layoutMargins: UIEdgeInsets = Constants.margins,
            itemSpacing: CGFloat = Constants.itemSpacing
        ) {
            self.itemSpacing = itemSpacing
            super.init(
                frame: .init(
                    x: 0,
                    y: 0,
                    width: 10,
                    height: 10
                )
            )
            commonInit()
            addComponents(components)
            self.accessibilityIdentifier = accessibilityIdentifier
            self.layoutMargins = layoutMargins
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("Dont call this.")
        }

        open func commonInit() {
            backgroundColor = UIColor.Semantic.cardBackground.raw
            addViews()
            setupStackView()
            setContraints()
            disableTranslatesAutoresizingMaskIntoConstraints()
        }

        // MARK: - Margins

        public var margins: Components.Edges = .all {
            didSet {
                var insets = Constants.margins
                let notIncluded = margins.symmetricDifference(Components.Edges.all)
                insets.adjust(notIncluded, margin: 0)
                if insets != Constants.margins {
                    adjust(insets: insets)
                }
            }
        }

        @discardableResult public func removePadding() -> Self {
            layoutMargins = .zero
            return self
        }

        public func adjust(insets: UIEdgeInsets) {
            layoutMargins = insets
        }

        public func adjust(_ edges: Components.Edges, margin: CGFloat) {
            var margins = layoutMargins
            margins.adjust(edges, margin: margin)
            adjust(insets: margins)
        }

        // MARK: - Add and setup views

        private func addViews() {
            addSubview(stackView)
        }

        private func setupStackView() {
            stackView.spacing = itemSpacing
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.alignment = .center
        }

        open func setContraints() {
            stackViewBottomAnchor = stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                stackView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
                stackView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
                stackViewBottomAnchor!
            ])
        }

        private func disableTranslatesAutoresizingMaskIntoConstraints() {
            translatesAutoresizingMaskIntoConstraints = false
            stackView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        open func addComponents(_ components: [UIView]) {
            stackViewBottomAnchor?.isActive = false
            stackView.removeConstraints(stackView.constraints)
            
            components.enumerated().forEach { index, component in

                self.components.append(component)
                stackView.addArrangedSubview(component)

                NSLayoutConstraint.activate([
                    component.leftAnchor.constraint(equalTo: stackView.leftAnchor),
                    component.rightAnchor.constraint(equalTo: stackView.rightAnchor)
                ])

                if let button = component as? HMRCButton,
                    let style = button.style,
                    case .secondary = style {
                    stackView.setCustomSpacing(0, after: component)
                }

                if index + 1 < components.count {
                    if let button = components[index + 1] as? HMRCButton,
                        let style = button.style,
                        case .secondary = style {
                        stackView.setCustomSpacing(0, after: component)
                    }
                }
            }
            
            if let button = components.last as? HMRCButton,
                case .secondary = button.style {
                    
                stackViewBottomAnchor = stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            } else {
                stackViewBottomAnchor = stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            }
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                stackView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
                stackView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
                stackViewBottomAnchor!
            ])
        }

        open func setComponents(_ components: [UIView]) {
            self.components.forEach { $0.removeFromSuperview() }
            self.components = []
            addComponents(components)
        }
    }
}
