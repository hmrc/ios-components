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

import Foundation

private class ComponentsBundleFinder {}

extension Foundation.Bundle {
    static var resource: Bundle = {
        let appModuleName = "UIComponents-App"
        let appBundleName = "\(appModuleName)"
        let uiModuleName = "UIComponents"
        let uiBundleName = "\(uiModuleName)_\(uiModuleName)"
        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,
            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: ComponentsBundleFinder.self).resourceURL,
            // For command-line tools.
            Bundle.main.bundleURL,
        ]
        for candidate in candidates {
            let appBundlePath = candidate?.appendingPathComponent(appBundleName + ".bundle")
            if let bundle = appBundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
            let uiBundlePath = candidate?.appendingPathComponent(uiBundleName + ".bundle")
            if let bundle = uiBundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("Unable to find bundle named \(appBundleName)")
    }()
}
