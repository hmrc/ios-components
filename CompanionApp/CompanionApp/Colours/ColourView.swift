/*
 * Copyright 2018 HM Revenue & Customs
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
import UIComponents

class ColourView: UIView {
    let colourView = UIView.build {
        $0 .layer.borderColor = UIColor.Semantic.darkText.raw.cgColor
        $0 .layer.borderWidth = 1.0
    }
    let label = UILabel.buildH5Label()

    init(title: String, colour: UIColor) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        addViews()
        setupConstraints()
        colourView.backgroundColor = colour
        label.text = "\(title) (#\(colour.hexRGB()))"
    }

    private func addViews() {
        addSubview(colourView)
        addSubview(label)
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            colourView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
            colourView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            colourView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            colourView.heightAnchor.constraint(equalToConstant: 40),
            colourView.widthAnchor.constraint(equalToConstant: 40),

            label.leftAnchor.constraint(equalTo: colourView.rightAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
            label.centerYAnchor.constraint(equalTo: colourView.centerYAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Needed")
    }
}
