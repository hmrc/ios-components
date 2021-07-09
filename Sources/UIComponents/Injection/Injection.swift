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

public protocol DisposableResourceOwner {
    func disposeOfResources()
}

public protocol ResettableInjector {
    func reset()
}

extension Components.Injection {
    public class Injector<T>: ResettableInjector {
        let shouldLog = false

        public typealias Create = (() -> T)
        private var _obj: T!
        private var createStandard: Create

        public var injectedObject: T {
            if _obj == nil {
                _obj = standard()
            }
            return _obj
        }

        public init(_ createStandard: @escaping Create) {
            self.createStandard = createStandard
        }

        public func standard() -> T {
            createStandard()
        }

        public func addressOf(_ obj: UnsafeRawPointer) -> String {
            let addr = Int(bitPattern: obj)
            return String(format: "%p", addr)
        }

        public func addressOf<T: AnyObject>(_ obj: T) -> String {
            let addr = unsafeBitCast(obj, to: Int.self)
            return String(format: "%p", addr)
        }

        public func inject(_ object: T? = nil) {
            _obj = object ?? standard()

            if shouldLog {
                let address = addressOf(object as AnyObject)
                print("Injecting <\(type(of: _obj!))>: \(_obj!)<\(address)>")
            }
        }

        public func reset() {
            inject()
        }
    }
}
