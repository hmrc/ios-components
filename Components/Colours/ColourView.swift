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
import SnapKit
import UIComponents

class ColourView: UIView {
    let colourView = UIView()
    let label = UILabel.styled(style: .H5)

    init(title: String, colour: UIColor) {
        super.init(frame: .zero)
        addViews()
        disableTranslatesAutoresizingMaskIntoConstraints()
        setupConstraints()
        setupStyle()
        colourView.backgroundColor = colour
        label.text = "\(title) (#\(colour.hexRGB()))"
    }

    private func addViews() {
        addSubview(colourView)
        addSubview(label)
    }

    private func setupStyle() {
        colourView.layer.borderColor = UIColor.Semantic.darkText.raw.cgColor
        colourView.layer.borderWidth = 1.0
    }

    private func setupConstraints() {
        colourView.snp.makeConstraints { (make) in
            make.left.equalTo(snp.leftMargin)
            make.top.equalTo(snp.topMargin)
            make.bottom.equalTo(snp.bottomMargin)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        label.snp.makeConstraints { (make) in
            make.left.equalTo(colourView.snp.right).offset(20)
            make.right.equalTo(snp.rightMargin)
            make.centerY.equalTo(colourView.snp.centerY)
        }
    }

    private func disableTranslatesAutoresizingMaskIntoConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        colourView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Needed")
    }
}
