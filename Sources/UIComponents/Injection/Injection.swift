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
    typealias Create = (() -> Any)
    var identifier: String { get }
    @discardableResult func enableLogging() -> Self
    @discardableResult func disableLogging() -> Self
    func reset()
    func injectedObject() -> Any
    init(_ identifier: String, _ create: @escaping Create)
}

extension Components.Injection {
    public class Injector: ResettableInjector, CustomStringConvertible {
        public var description: String {
            return "Injector<\(identifier)>"
        }

        public private(set)var identifier: String

        private var createStandard: Create!
        let loggingEnabled = true
        public private (set)var logsInjection = true
        public private (set)var isSingleton = true

        private var _obj: Any!

        public func injectedObject<T>() -> T {
            guard isSingleton else {
                return standard() as! T // swiftlint:disable:this force_cast
            }
            if _obj == nil {
                _obj = standard()
            }
            return _obj as! T // swiftlint:disable:this force_cast
        }

        func notSingleton() -> Self {
            isSingleton = false
            return self
        }

        @discardableResult public func enableLogging() -> Self {
            logsInjection = true
            return self
        }
        @discardableResult public func disableLogging() -> Self {
            logsInjection = false
            return self
        }

        required public init(_ identifier: String, _ createStandard: @escaping Create) {
            self.createStandard = createStandard
            self.identifier = identifier
            Components.Injection.injectors[identifier] = self
        }

        func standard() -> Any {
            return createStandard()
        }

        func addressOf(_ obj: UnsafeRawPointer) -> String {
            let addr = Int(bitPattern: obj)
            return String(format: "%p", addr)
        }

        func addressOf<T: AnyObject>(_ obj: T) -> String {
            let addr = unsafeBitCast(obj, to: Int.self)
            return String(format: "%p", addr)
        }

        @discardableResult public func inject(_ object: Any?=nil) -> Self {
            let shouldLog = loggingEnabled && logsInjection
            if let existing = _obj {
                if shouldLog { print("Replacing Existing Injection object: \(existing)") }
                if let disposable = existing as? DisposableResourceOwner {
                    if shouldLog { print("Disposable Object \(disposable)") }
                    disposable.disposeOfResources()
                }
            }

            _obj = object ?? standard()

            if loggingEnabled, logsInjection {
                let address = addressOf(object as AnyObject)
                print("Injecting <\(type(of: _obj!))>: <\(address)>\(_obj!)")
            }

            return self
        }

        public func reset() {
            //call inject with nil object so we create a new instance of the injected object
            inject()
        }
    }

    public static func reset() {
        Components.Injection.injectors.forEach { (injectorName, injector) in
            print("Resetting Injector \(injectorName)")
            injector.reset()
        }
        Components.Injection.initialise()
    }
}
