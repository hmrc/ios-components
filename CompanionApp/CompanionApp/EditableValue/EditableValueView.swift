//
//  EditableValueView.swift
//  ShowEditButtons
//
//  Created by Chris Birch on 23/08/2022.
//

import UIKit
import UIComponents

class EditableValueView: UIView {
    var isEditButtonVisible = false {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.editButton.isHidden = !self.isEditButtonVisible
//                       self.valueLabelAndEditButtonStack.layoutIfNeeded()
                       self.stack.layoutIfNeeded()
                   }
        }
    }
    let stack = UIStackView()
//    let valueLabelAndEditButtonStack = UIStackView()
    let titleView = Components.Molecules.MultiColumnRowView(labels: ["Car benefits", "£300.00"])
//    let valueView = Components.Molecules.MultiColumnRowView(labels: ["£300.00"])
    let editButton = UIButton.buildSecondaryButton(string: "Edit")
    override init(frame: CGRect) {
        super.init(frame: frame)
        [self, stack, titleView, editButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false}
        addSubview(stack)
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
//        editButton.contentEdgeInsets = .zero
//          titleView.backgroundColor = .red
////        editButton.backgroundColor = .blue


//        titleLabel.text = "Car benefit"
//        valueLabel.text = "£300.00"
        [editButton, editButton].forEach{$0.setContentHuggingPriority(.required, for: .horizontal)}
        editButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleView.setContentCompressionResistancePriority(.required, for: .horizontal)
        editButton.setTitle("Edit", for: .normal)

        [titleView, editButton].forEach { stack.addArrangedSubview($0) }
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            stack.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),

            stack.heightAnchor.constraint(equalTo: editButton.heightAnchor)
        ])



        editButton.isHidden = true
        accessibilityElements = [titleView, editButton]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(name: String, value: String) {
        self.init(frame: .zero)
        titleView.updateUI(with: [name, value])
        editButton.accessibilityLabel = "Edit \(name)"
    }

}
