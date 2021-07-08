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

extension Components.Helpers {
    public struct ColorConfig {
        public static var shared = ColorConfig()
        private var _lightColors: NamedColors?
        private var _darkColors: NamedColors?
        private var _semanticLightColors: SemanticColors?
        private var _semanticDarkColors: SemanticColors?
  
        private init() {}
        
        public var lightColors: NamedColors {
            get { return _lightColors ?? UIColor.LightColors() }
            set { _lightColors = newValue }
        }
        
        public var darkColors: NamedColors {
            get { return _darkColors ?? UIColor.DarkColors() }
            set { _darkColors = newValue }
        }
        
        public var semanticLightColors: SemanticColors {
            get { return _semanticLightColors ?? UIColor.SemanticLightColors() }
            set { _semanticLightColors = newValue }
        }
        
        public var semanticDarkColors: SemanticColors {
            get { return _semanticDarkColors ?? UIColor.SemanticDarkColors() }
            set { _semanticDarkColors = newValue }
        }
    }
}
