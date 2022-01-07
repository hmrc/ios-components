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

import UIKit

public protocol ColorService {
    var colors: NamedColors { get }
    var semanticColors: SemanticColors { get }
}

extension Components.Colors {
    public class Service: ColorService {
        
        private var _colors: NamedColors?
        private var _semanticColors: SemanticColors?
        
        public init(
            colors: NamedColors? = nil,
            semanticColors: SemanticColors? = nil
        ) {
            self._colors = colors
            self._semanticColors = semanticColors
        }
        
        public var colors: NamedColors {
            return _colors ?? UIColor.Colors()
        }
        
        public var semanticColors: SemanticColors {
            return _semanticColors ?? UIColor.SemanticColors()
        }
    }
}
