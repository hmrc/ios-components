import UIKit

extension Components.Helpers {

    ///Modified form of https://blog.chrishannah.me/adding-insets-to-a-uilabel/
    ///Chris says this might be useful one day...
    open class InsetLabel: UILabel {

        public var contentInsets = UIEdgeInsets.zero {
            didSet {
                invalidateIntrinsicContentSize()
            }
        }

        var contentInsetLeft: CGFloat {
            get {
                return contentInsets.left
            } set {
                var insets = contentInsets
                insets.left = newValue
                contentInsets = insets
            }
        }

        var contentInsetRight: CGFloat {
            get {
                return contentInsets.right
            } set {
                var insets = contentInsets
                insets.right = newValue
                contentInsets = insets
            }
        }

        var contentInsetTop: CGFloat {
            get {
                return contentInsets.top
            } set {
                var insets = contentInsets
                insets.top = newValue
                contentInsets = insets
            }
        }

        var contentInsetBottom: CGFloat {
            get {
                return contentInsets.bottom
            } set {
                var insets = contentInsets
                insets.bottom = newValue
                contentInsets = insets
            }
        }

        open override func drawText(in rect: CGRect) {
            let insetRect = rect.inset(by: contentInsets)
            super.drawText(in: insetRect)
        }

        open override var intrinsicContentSize: CGSize {
            return addInsets(to: super.intrinsicContentSize)
        }

        open override func sizeThatFits(_ size: CGSize) -> CGSize {
            return addInsets(to: super.sizeThatFits(size))
        }

        private func addInsets(to size: CGSize) -> CGSize {
            let width = size.width + contentInsets.left + contentInsets.right
            let height = size.height + contentInsets.top + contentInsets.bottom
            return CGSize(width: width, height: height)
        }
    }
}
