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

class ColoursViewController: UIViewController {
    var semanticColors: [(String, UIColor)] = UIColor.Semantic.allCases.map { ($0.rawValue, $0.raw) }
    var namedColors: [(String, UIColor)] = UIColor.Named.allCases.map { ($0.rawValue, $0.raw) }

    private lazy var scrollView: UIScrollView = .build()
    private lazy var stackView: UIStackView = .build {
        $0.axis = .vertical
        $0.spacing = 20
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupColourViews()

        view.backgroundColor = UIColor.Semantic.pageBackground.raw
    }

    private func setupStackView() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupColourViews() {
        let namedColourViews = namedColors.map { title, colour -> ColourView in
            ColourView(title: title, colour: colour)
        }
        stackView.addArrangedSubview(UILabel.styled(style: .H4, string: "Named Colours"))
        namedColourViews.forEach { stackView.addArrangedSubview($0) }

        let semanticColourViews = semanticColors.map { title, colour -> ColourView in
            ColourView(title: title, colour: colour)
        }
        stackView.addArrangedSubview(UILabel.styled(style: .H4, string: "Semantic Colours"))
        semanticColourViews.forEach { stackView.addArrangedSubview($0) }
    }
}
