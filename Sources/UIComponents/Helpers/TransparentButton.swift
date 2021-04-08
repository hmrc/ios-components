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

open class TransparentButton: UIButton {

    public struct StateConfig {
        let normalColour: UIColor
        let highlightColour: UIColor
        let disabledColour: UIColor

        public init(normalColour: UIColor, highlightColour: UIColor, disabledColour: UIColor) {
            self.normalColour = normalColour
            self.highlightColour = highlightColour
            self.disabledColour = disabledColour
        }
    }

    public let defaultConfig = StateConfig(
        normalColour: .clear,
        highlightColour: UIColor.Semantic.transparentButtonHighlightedBackground,
        disabledColour: .darkGray
    )

    ///THIS MUST BE USED for button tap handling! NOT addTarget(....)
    ///takes into account and allows hit animations to show before firing the action
    public var action: VoidHandler!

    public var config: StateConfig! {
        didSet {
            setStateColours()
        }
    }

    public init(config: StateConfig) {
        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        commonInit()
        self.config = config
    }

    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        commonInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("Dont call this")
    }

    open func commonInit() {
        config = defaultConfig
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                setStateColours()
            }
        }
    }

    func setStateColours() {
        self.setBackgroundImage(
            UIImage.imageWithColor(color: config.normalColour),
            for: .normal)
        self.setBackgroundImage(
            UIImage.imageWithColor(color: config.disabledColour),
            for: .disabled)
        self.setBackgroundImage(
            UIImage.imageWithColor(color: config.highlightColour),
            for: .highlighted
        )
    }

    // MARK: - Button handler
    @objc private func buttonTapped() {
        let fadeIn = 0.2
        let fadeOut = 0.15

        UIView.animate(withDuration: fadeIn, animations: {
            self.backgroundColor = self.config!.highlightColour
        }, completion: {[weak self] _ in
            guard let self = self else {return}
            self.fireAction()
            UIView.animate(withDuration: fadeOut, animations: {[weak self] in
                guard let self = self else {return}
                self.backgroundColor = self.config!.normalColour
            }, completion: { _ in

            })
        })
    }

    func fireAction() {
        action?()
    }
}
