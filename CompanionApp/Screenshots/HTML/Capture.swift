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

import Foundation

public struct Capture {}

public extension Capture {

    enum Section: String {
        case organisms
        case molecules
        case atoms
        case colours
    }

    enum Screen: String {
        // Organisms
        case headlineCardView
        case primaryCardView
        case expandingRowView
        case statusCardView
        case iconButtonCardView
        case summaryRowView
        case informationMessageCard
        case menuPanelRowView

        // Molecules
        case textInputView
        case currencyInputView
        case h4TitleBodyView
        case h5TitleBodyView
        case boldTitleBodyView
        case insetView
        case multiColumnRowView
        case switchRowView
        case iconButtonView
        case statusView
        case warningView
        case tabBarView
        case selectRowView
        case selectRowGroupView

        // Atoms
        case text
        case buttons

        // Colours
        case colours
    }
}
