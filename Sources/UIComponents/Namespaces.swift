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

public class Components {
    public struct Atoms {}
    public struct Molecules {}
    public struct Organisms {}
    public struct Containers {}
    public struct Colors {}
    public struct Helpers {}
}

extension Components {
    public struct Injection {
        public static var injectors = [String: ResettableInjector]()
        ///Fired after injectors are initialised and reset. Useful for configuring injected instances
        public static var initialised: (() -> Void)!
        public static func initialise() {

            //Allow third party code to initialise
            Injection.initialised?()
        }
    }
}
