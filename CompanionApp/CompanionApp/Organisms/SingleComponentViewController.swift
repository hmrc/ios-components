/*
 * Copyright 2020 HM Revenue & Customs
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

import UIComponents
import UIKit

class SingleComponentViewController<T: ExamplableView>: UIViewController {
    lazy var scrollView: UIScrollView = .build()
    lazy var stackView: UIStackView = .build {
        $0.axis = .vertical
        $0.spacing = 20
        $0.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        $0.isLayoutMarginsRelativeArrangement = true
    }
    lazy var previewBackgroundView: UIView = .build {
        $0.backgroundColor = UIColor(patternImage: ExampleImages.previewBackground.image)
    }

    let placeHolder = T.withPlaceholders()
    let examples = T.examples()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = T.exampleBackgroundColor
        setupViews()
    }

    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(previewBackgroundView)
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),

            scrollView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: stackView.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        let placeholderLabel = UILabel.styled(style: .bold, string: "Placeholders:")
        stackView.addArrangedSubview(placeholderLabel)
        stackView.addArrangedSubview(placeHolder)
        let exampleLabel = UILabel.styled(style: .bold, string: "Examples:")
        stackView.addArrangedSubview(exampleLabel)
        _ = examples.map { self.stackView.addArrangedSubview($0) }
        NSLayoutConstraint.activate([
            previewBackgroundView.topAnchor.constraint(equalTo: placeHolder.topAnchor),
            previewBackgroundView.bottomAnchor.constraint(equalTo: placeHolder.bottomAnchor),
            previewBackgroundView.leadingAnchor.constraint(equalTo: placeHolder.leadingAnchor),
            previewBackgroundView.trailingAnchor.constraint(equalTo: placeHolder.trailingAnchor)
        ])
    }
}
