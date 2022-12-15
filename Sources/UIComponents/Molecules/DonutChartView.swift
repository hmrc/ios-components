/*
 * Copyright 2022 HM Revenue & Customs
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

extension Components.Molecules {
    public class DonutChartView: UIView {

        // MARK: Model

        public struct Model {
            let primaryColor: UIColor
            let secondaryColor: UIColor
            let lineWidth: CGFloat
            let animationDuration: TimeInterval

            public init(
                primaryColor: UIColor,
                secondaryColor: UIColor,
                lineWidth: CGFloat = 20,
                animationDuration: TimeInterval = 0.6
            ) {
                self.primaryColor = primaryColor
                self.secondaryColor = secondaryColor
                self.lineWidth = lineWidth
                self.animationDuration = animationDuration
            }
        }

        // MARK: - Variables

        private let model: Model
        private var ratio: CGFloat = 0.00

        // MARK: - Views & Layers

        private var primaryLayer = CAShapeLayer()
        private var secondaryLayer = CAShapeLayer()

        // MARK: - Initialisation

        public init(model: Model) {
            self.model = model
            super.init(frame: .zero)
            commonInit()
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func commonInit() {
            setupLayers()
            setValues(ratio: 0, animated: false)
        }

        override public func layoutSubviews() {
            super.layoutSubviews()
            let maxDimension = min(bounds.size.width, bounds.size.height) - model.lineWidth
            let radius = maxDimension / 2
            let center = CGPoint(
                x: bounds.midX,
                y: bounds.midY
            )
            let path = UIBezierPath(
                arcCenter: center,
                radius: radius,
                startAngle: -CGFloat.pi / 2,
                endAngle: CGFloat.pi * 1.5,
                clockwise: true
            )
            primaryLayer.path = path.cgPath
            secondaryLayer.path = path.cgPath
        }

        private func setupLayers() {
            layer.addSublayer(secondaryLayer)
            layer.addSublayer(primaryLayer)
            primaryLayer.strokeColor = UIColor.clear.cgColor
            secondaryLayer.strokeColor = UIColor.clear.cgColor
            primaryLayer.lineWidth = model.lineWidth
            secondaryLayer.lineWidth = model.lineWidth
            primaryLayer.fillColor = UIColor.clear.cgColor
            secondaryLayer.fillColor = UIColor.clear.cgColor
        }

        // MARK: - UI Functions

        private func animateStroke(_ duration: TimeInterval) {
            primaryLayer.strokeEnd = ratio
            secondaryLayer.strokeColor = UIColor.clear.cgColor
            guard ratio > 0 else { return }

            CATransaction.begin()
            CATransaction.setCompletionBlock { [weak self] in
                guard let self = self else { return }
                self.secondaryLayer.strokeColor = self.model.secondaryColor.cgColor
                self.primaryLayer.strokeEnd = self.ratio
                let revealAnimation = CABasicAnimation(keyPath: "strokeEnd")
                revealAnimation.fromValue = 1.0
                revealAnimation.toValue = self.ratio
                revealAnimation.duration = duration
                self.primaryLayer.add(revealAnimation, forKey: "strokeEnd")
            }

            primaryLayer.strokeColor = model.primaryColor.cgColor
            primaryLayer.strokeEnd = 1.0
            let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
            strokeAnimation.fromValue = 0
            strokeAnimation.toValue = 1.0
            strokeAnimation.duration = duration
            primaryLayer.add(strokeAnimation, forKey: "strokeEnd")

            CATransaction.commit()
        }

        private func animateStroke(_ duration: TimeInterval, fromRatio: CGFloat) {
            guard fromRatio > 0 else { return animateStroke(duration) }
            primaryLayer.strokeEnd = ratio
            let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
            strokeAnimation.fromValue = fromRatio
            strokeAnimation.toValue = ratio
            strokeAnimation.duration = duration
            primaryLayer.add(strokeAnimation, forKey: "strokeEnd")
        }

        private func drawStroke() {
            guard ratio > 0 else { return }
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            primaryLayer.strokeColor = model.primaryColor.cgColor
            secondaryLayer.strokeColor = model.secondaryColor.cgColor
            primaryLayer.strokeEnd = self.ratio
            CATransaction.commit()
        }

        // MARK: - Public Interface

        public func setValues(ratio: CGFloat, animated: Bool, fromCurrent: Bool = false) {
            let oldRatio = fromCurrent ? self.ratio : 0.0
            self.ratio = ratio
            if animated {
                animateStroke(model.animationDuration, fromRatio: oldRatio)
            } else {
                drawStroke()
            }
        }
    }
}
