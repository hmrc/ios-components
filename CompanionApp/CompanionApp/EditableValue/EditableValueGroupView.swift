
import UIKit
import UIComponents

class EditableValueGroupView: UIView {

    struct Model {
        let title: String
        let editableValueViews: [EditableValueView]
    }

    let titleLabel = UILabel.styled(style: .H4)
    lazy var editButton = UIButton.buildSecondaryButton(string: "Edit")

    let mainStack: UIStackView = .build()
    let editableValueViewsStack: UIStackView = .build()

    var model: Model? {
        didSet {
            guard let model = model else { return }
            let editableValueViews = model.editableValueViews
            titleLabel.text = model.title
            editableValueViewsStack.arrangedSubviews.forEach{editableValueViewsStack.removeArrangedSubview($0)}
            editableValueViewsStack.addArrangedSubviews(editableValueViews)
        }
    }

    var isEditing = false {
        didSet {
            guard let model = model else { return }
            let editableValueViews = model.editableValueViews
            
            let isEditing = isEditing
            UIView.animate(withDuration: 0.3) {[unowned self] in
                editableValueViews.forEach { $0.isEditButtonVisible = isEditing }
                self.editableValueViewsStack.layoutIfNeeded()
            }

            if isEditing {
                //Change the accesiblity label so when we jump to it, it will read out the reason
                //why we moved focus, we do this because we cant stack the UIAccessibilty posts :(
                titleLabel.accessibilityLabel = "Editing \(model.title)"
                UIAccessibility.post(
                    notification: UIAccessibility.Notification.layoutChanged,
                    argument: titleLabel
                )

//                delayedCall(1) {
//                    print("Fired")
//
//                    UIAccessibility.post(
//                        notification: UIAccessibility.Notification.announcement,
//                        argument: "Editing settings"
//                    )
//                    self.delayedCall(1) {
//                        UIAccessibility.post(
//                            notification: UIAccessibility.Notification.screenChanged,
//                            argument: self.editableValueViews.first?.editButton
//                        )
//                        self.editButton.isAccessibilityElement = true
//
//                    }
//                }
               // UIAccessibility.post(notification: .screenChanged, argument: editableValueViews.first?.editButton)

            }
            else {
                //Not editing
                titleLabel.accessibilityLabel = "\(model.title)"
            }

            //Do this after a short amount of time has passed to allow time for screen reader focus to shift
            //focus, otherwise it will read out the change which is confusing
            delayedCall(0.5) {
                self.editButton.isAccessibilityElement = false
                self.updateButtonText()
                self.editButton.isAccessibilityElement = true
            }

        }
    }


    public func delayedCall(_ delayInSeconds: Double = 0.0, closure: @escaping () -> Void) {

        let delayInMilliSeconds = Int(delayInSeconds * 1000)
        let nanoseconds = DispatchTime.now() + DispatchTimeInterval.milliseconds(delayInMilliSeconds)
        DispatchQueue.main.asyncAfter(deadline: nanoseconds, execute: closure)
    }


    private func updateButtonText() {
        let buttonTextBeforeEdit = "Update or remove benefit"
        let buttonTextDuringEdit = "Finish updating benefits"
        if isEditing {
            editButton.setTitle(buttonTextDuringEdit, for: .normal)
        } else {
            editButton.setTitle(buttonTextBeforeEdit, for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        [self, editButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false}
        addSubview(mainStack)

        mainStack.addArrangedSubviews([titleLabel, editableValueViewsStack, editButton])

        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.distribution = .fill

        editableValueViewsStack.axis = .vertical
        editableValueViewsStack.alignment = .fill
        editableValueViewsStack.distribution = .fill

        [editButton, editButton].forEach{$0.setContentHuggingPriority(.required, for: .horizontal)}

        NSLayoutConstraint.activate([
            mainStack.leftAnchor.constraint(equalTo: leftAnchor),
            mainStack.rightAnchor.constraint(equalTo: rightAnchor),
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),

           // mainStack.heightAnchor.constraint(equalTo: editButton.heightAnchor)
        ])

        editButton.componentAction { sender in
            self.isEditing = !self.isEditing
        }

        updateButtonText()

//        accessibilityElements = [titleView, editButton]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
