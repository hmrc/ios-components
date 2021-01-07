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

extension Components {
    public struct Debug {
        public static var showOverlay = false
    }
}

open class DebugOverlayableView: UIView {

    var overlayLayer: CAShapeLayer?

    open override func layoutSubviews() {
        super.layoutSubviews()
        if backgroundColor == nil { backgroundColor = UIColor.clear }
        if Components.Debug.showOverlay {
            setNeedsDisplay()
        }
    }

    open override func draw(_ rect: CGRect) {
        if Components.Debug.showOverlay {
            drawDebugOverlay(layer: self.layer, rect: rect)
        }
    }

    private func drawDebugOverlay(layer: CALayer, rect: CGRect) {

        let borderWidth: CGFloat = 2
        let inset = borderWidth / 2
        let insetRect = rect.inset(
            by: UIEdgeInsets(
                top: inset,
                left: inset,
                bottom: inset,
                right: inset)
        )
        let textRect = insetRect.inset(
            by: UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: 0,
                right: isMolecule ? 0 : 8)
        )

        let overlay = CAShapeLayer()
        overlay.frame = rect
        overlay.fillColor = UIColor.clear.cgColor
        overlay.path = UIBezierPath(rect: insetRect).cgPath
        overlay.lineDashPattern = overlayBorderDashPattern
        overlay.strokeColor = overlayBorderColor.cgColor
        overlay.lineWidth = 2

        overlayLayer?.removeFromSuperlayer()
        overlayLayer = overlay
        layer.insertSublayer(overlay, above: layer)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = (isMolecule ? .center : .right)

        let attributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 8.0),
            NSAttributedString.Key.foregroundColor: overlayTextColor
        ]
        let attributedString = NSAttributedString(
            string: shortTypeDescription,
            attributes: attributes
        )
        attributedString.draw(in: textRect)
    }

    lazy private var namespacedTypeDescription: String = {
        let selfType = (type(of: self))
        return String(reflecting: selfType.self)
    }()

    lazy private var overlayBorderColor: UIColor = {
        if isComponent {
            if isMolecule {
                return UIColor.Components.Debug.componentMoleculeBorderColor
            } else {
                return UIColor.Components.Debug.componentOrganismBorderColor
            }
        } else {
            return UIColor.Components.Debug.nonComponentBorderColor
        }
    }()

    lazy private var overlayBorderDashPattern: [NSNumber] = {
        if isMolecule {
            return [4, 2]
        } else {
            return [8, 2]
        }
    }()

    lazy private var overlayTextColor: UIColor = {
        if isComponent {
            if isMolecule {
                return UIColor.Components.Debug.componentMoleculeTextColor
            } else {
                return UIColor.Components.Debug.componentOrganismTextColor
            }
        } else {
            return UIColor.Components.Debug.nonComponentTextColor
        }
    }()

    lazy private var shortTypeDescription: String = {
        return namespacedTypeDescription
            .replacingOccurrences(of: "HMRCNextGenConsumer.", with: "")
            .replacingOccurrences(of: "UIComponents.Components.", with: "")
    }()

    lazy private var isComponent: Bool = {
        return namespacedTypeDescription.hasPrefix("UIComponents.Components.")
    }()

    lazy private var isMolecule: Bool = {
        return namespacedTypeDescription.contains("Molecule")
    }()
}
