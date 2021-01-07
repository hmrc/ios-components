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

enum ExampleText {
    // swiftlint:disable line_length
    enum LoremIpsum: String {
        case long = "Lorem ipsum dolor sit amet, id cum ullum deseruisse solet."
        case longer = "Lorem ipsum dolor sit amet, ne nec regione nostrum. Quo altera nusquam apeirian et, melius discere pro ne, sint unum."
        case longest = """
        Lorem ipsum dolor sit amet, his ne quis phaedrum. Illum eloquentiam in pro, aperiam conceptam complectitur cum in, eum paulo ceteros at. Vel erroribus adversarium at, integre omnesque eu est. Appareat expetenda cum no. Erant omnes interesset pro at, id mei munere moderatius, ius ne ignota perpetua.
        """
    }
    // swiftlint:enable line_length
}

// swiftlint:disable identifier_name
let LongIpsum = ExampleText.LoremIpsum.long.rawValue
let LongerIpsum = ExampleText.LoremIpsum.longer.rawValue
let LongestIpsum = ExampleText.LoremIpsum.longest.rawValue
// swiftlint:enable identifier_name
