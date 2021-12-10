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

private protocol SegmentButtonResponder: class {
    func deselectSegmentButtons()
}

extension Components.Molecules {
    // This terrible naming choice will forever live on
    // (╯°□°）╯︵ ┻━┻
    open class TabBarView: DebugOverlayableView, SegmentButtonResponder {

        public struct Model {
            let segments: [Segment]
            let theme: Theme

            public struct Segment {
                let title: String
                let startSelected: Bool
                let action: (() -> Void)

                public init(title: String, startSelected: Bool = false, action: @escaping (() -> Void)) {
                    self.title = title
                    self.startSelected = startSelected
                    self.action = action
                }
            }

            public enum Theme {
                case dark
                case light
            }

            public init(segments: [Segment], theme: Theme) {
                self.segments = segments
                self.theme = theme
            }
        }

        private lazy var stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.spacing = 0
            stackView.distribution = .fillEqually
            stackView.axis = .horizontal
            stackView.alignment = .leading
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()

        private lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.contentInset = .zero
            scrollView.contentOffset = .zero
            scrollView.scrollIndicatorInsets = .zero
            scrollView.bounces = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.isScrollEnabled = true
            scrollView.contentInsetAdjustmentBehavior = .never
            return scrollView
        }()

        private lazy var matchingWidthConstraint: NSLayoutConstraint = {
            return stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        }()

        private var segmentButtons = [SegmentButton]()

        public var currentlySelectedIndex: Int {
            get {
                return segmentButtons.firstIndex(where: { $0.isSelected }) ?? 0
            }
            set (newValue) {
                deselectSegmentButtons()
                segmentButtons[safe: newValue].update(isSelected: true)
            }
        }

        public required convenience init(model: Model) {
            self.init(frame: .zero)

            addSubviews()
            addConstraints()

            configure(for: model)

            autoresizingMask = .flexibleWidth
        }

        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func addSubviews() {
            addSubview(scrollView)
            scrollView.addSubview(stackView)
        }

        private func addConstraints() {
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: topAnchor),
                scrollView.leftAnchor.constraint(equalTo: leftAnchor),
                scrollView.rightAnchor.constraint(equalTo: rightAnchor),
                scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

                stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),

                stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
                scrollView.heightAnchor.constraint(equalTo: stackView.heightAnchor)
            ])
        }

        open override func layoutSubviews() {
            super.layoutSubviews()

            if stackView.bounds.width > scrollView.bounds.width || stackView.bounds.width == 0 {
                scrollView.contentSize = CGSize(width: stackView.bounds.width, height: scrollView.bounds.height)
                matchingWidthConstraint.isActive = false
            } else {
                matchingWidthConstraint.isActive = true
            }
            setNeedsUpdateConstraints()
            setNeedsLayout()
        }

        private func configure(for model: Model) {
            segmentButtons = model.segments.enumerated().map { index, segment in
                SegmentButton(model: .init(
                    segment: segment,
                    theme: model.theme,
                    accessibilityHelper: .init(
                        index: index + 1,
                        count: model.segments.count
                    )
                ))
            }
            segmentButtons.forEach {
                $0.delegate = self
                self.stackView.addArrangedSubview($0)
            }
            scrollView.backgroundColor = model.theme == .dark ? UIColor.Named.black.raw : UIColor.Named.white.raw
        }

        public override init(frame: CGRect) {
            super.init(frame: frame)
        }

        fileprivate func deselectSegmentButtons() {
            segmentButtons.forEach { $0.update(isSelected: false) }
        }
    }

    fileprivate class SegmentButton: UIButton {

        struct Model {
            let segment: TabBarView.Model.Segment
            let theme: TabBarView.Model.Theme
            let accessibilityHelper: AccessibilityHelper

            struct AccessibilityHelper {
                let index: Int
                let count: Int
            }
        }

        private lazy var highlightView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        private let theme: TabBarView.Model.Theme
        private let action: (() -> Void)

        weak var delegate: SegmentButtonResponder?

        init(model: Model) {
            self.theme = model.theme
            self.action = model.segment.action
            super.init(frame: .zero)

            addSubviews()
            addConstraints()

            update(isSelected: model.segment.startSelected)

            configureTheme(theme: model.theme)
            configureButton(segment: model.segment)
            configureAccessibility(title: model.segment.title, helper: model.accessibilityHelper)
        }

        private func configureAccessibility(title: String, helper: Model.AccessibilityHelper) {
            accessibilityLabel = "\(title), \(helper.index) of \(helper.count)"
        }

        private func configureButton(segment: TabBarView.Model.Segment) {
            contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 10, right: 8)
            setTitle(segment.title, for: .normal)
            addTarget(self, action: #selector(tapTriggered(_:)), for: .touchUpInside)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) not implemented")
        }

        private func addSubviews() {
            addSubview(highlightView)
        }

        private func addConstraints() {
            translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                highlightView.bottomAnchor.constraint(equalTo: bottomAnchor),
                highlightView.leftAnchor.constraint(equalTo: leftAnchor),
                highlightView.rightAnchor.constraint(equalTo: rightAnchor),
                highlightView.heightAnchor.constraint(equalToConstant: 6),

                heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
            ])
        }

        private func configureTheme(theme: TabBarView.Model.Theme) {
            titleLabel?.font = UIFont.bold()

            switch theme {
            case .dark:
                setTitleColor(UIColor.Named.white.raw, for: .selected)
                setTitleColor(UIColor.Named.grey2.raw, for: .normal)
                backgroundColor = UIColor.Named.black.raw
                highlightView.backgroundColor = UIColor.Named.white.raw

            case .light:
                setTitleColor(UIColor.Named.blue.raw, for: .selected)
                setTitleColor(UIColor.Named.grey1.raw, for: .normal)
                backgroundColor = UIColor.Named.white.raw
                highlightView.backgroundColor = UIColor.Named.blue.raw
            }
        }

        func update(isSelected: Bool) {
            highlightView.isHidden = !isSelected
            self.isSelected = isSelected
        }

        @objc private func tapTriggered(_ sender: UIButton) {
            guard !isSelected else { return }

            delegate?.deselectSegmentButtons()
            update(isSelected: true)
            self.action()
        }
    }
}
