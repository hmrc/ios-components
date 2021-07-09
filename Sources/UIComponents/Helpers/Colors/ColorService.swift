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
    var lightColors: NamedColors { get }
    var darkColors: NamedColors { get }
    var semanticLightColors: SemanticColors { get }
    var semanticDarkColors: SemanticColors { get }
}

extension Components.Colors {
    public class Service: ColorService {
        
        private var _lightColors: NamedColors?
        private var _darkColors: NamedColors?
        private var _semanticLightColors: SemanticColors?
        private var _semanticDarkColors: SemanticColors?
        
        public init(
            lightColors: NamedColors? = nil,
            darkColors: NamedColors? = nil,
            semanticLightColors: SemanticColors? = nil,
            semanticDarkColors: SemanticColors? = nil
        ) {
            self._lightColors = lightColors
            self._darkColors = darkColors
            self._semanticLightColors = semanticLightColors
            self._semanticDarkColors = semanticDarkColors
        }
        
        public var lightColors: NamedColors {
            return _lightColors ?? UIColor.LightColors()
        }
        
        public var darkColors: NamedColors {
            return _darkColors ?? UIColor.DarkColors()
        }
        
        public var semanticLightColors: SemanticColors {
            return _semanticLightColors ?? UIColor.SemanticLightColors()
        }
        
        public var semanticDarkColors: SemanticColors {
            return _semanticDarkColors ?? UIColor.SemanticDarkColors()
        }
    }
}
