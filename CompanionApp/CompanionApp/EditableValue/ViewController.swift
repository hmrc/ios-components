//
//  ViewController.swift
//  ShowEditButtons
//
//  Created by Chris Birch on 23/08/2022.
//

import UIKit
import UIComponents

class ViewController: UIViewController {


    let editableValueGroup = EditableValueGroupView()
    lazy var editableValueGroupCardView = Components.Atoms.CardView(components: [editableValueGroup])
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(editableValueGroupCardView)

        editableValueGroup.model = .init(
            title: "Your company benefits",
            editableValueViews: [
            .init(name: "Car benefits", value: "£300.00"),
            .init(name: "Medical", value: "£1500.00")
            ]
        )

        
        NSLayoutConstraint.activate([
            editableValueGroup.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editableValueGroup.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            editableValueGroup.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])


    }
}

