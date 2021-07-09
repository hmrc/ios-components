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

import UIKit
import UIComponents

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let colors = MySemanticColors()
        let service = Components.Colors.Service(lightColors: MyLightColors(), semanticLightColors: colors)
        Components.Injection.initialised = {
            Components.Injection.Service.colorService.inject(service)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

class MySemanticColors: SemanticColors {
    
    public var darkText = UIColor.systemPink
    public var lightText = UIColor.systemPink
    public var linkText = UIColor.systemPink
    public var errorText = UIColor.systemPink
    public var infoText = UIColor.systemPink
    public var expandableButtonText = UIColor.systemPink
    public var cardBackground = UIColor.systemPink
    public var cardShadow = UIColor.systemPink
    public var pageBackground = UIColor.systemPink
    public var menuCardBackground = UIColor.systemPink
    public var menuPageBackground = UIColor.systemPink
    public var divider = UIColor.systemPink
    public var insetBar = UIColor.systemPink
    public var primaryButtonBackground = UIColor.systemPink
    public var primaryButtonDisabledBackground = UIColor.systemPink
    public var primaryButtonDisabledText = UIColor.systemPink
    public var primaryButtonHighlightedBackground = UIColor.systemPink
    public var primaryButtonText = UIColor.systemPink
    public var primaryButtonHighlightedBaseline = UIColor.systemPink
    public var primaryButtonBaseline = UIColor.systemPink
    public var statusCardIconDefaultTint = UIColor.systemPink
    public var switchTint = UIColor.systemPink
    public var switchTintSelected = UIColor.systemPink
    public var textInputBorder = UIColor.systemPink
    public var textInputLeftViewTint = UIColor.systemPink
    public var secondaryButtonText = UIColor.systemPink
    public var secondaryButtonBackground = UIColor.systemPink
    public var secondaryButtonHighlightedBackground = UIColor.systemPink
    public var whiteBackground = UIColor.systemPink
    
}

class MyLightColors: NamedColors {
    
    public init() {}
    
    public var black = UIColor.systemPink
    public var white = UIColor.systemPink
    public var green1 = UIColor.systemPink
    public var green2 = UIColor.systemPink
    public var blue = UIColor.systemPink
    public var teal = UIColor.systemPink
    public var red = UIColor.systemPink
    public var grey1 = UIColor.systemPink
    public var grey2 = UIColor.systemPink
    public var grey3 = UIColor.systemPink
    public var pink = UIColor.systemPink
    public var yellow = UIColor.systemPink
}
