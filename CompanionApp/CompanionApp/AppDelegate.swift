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
        Components.Injection.initialised = {
            Components.Injection.Service.colorService.inject(Components.Colors.Service(lightColors: MyLightColors(), semanticLightColors: colors))
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

struct MySemanticColors: SemanticColors {
    
    public var darkText = UIColor.Named.black.raw
    public var lightText = UIColor.Named.white.raw
    public var linkText = UIColor.Named.blue.raw
    public var errorText = UIColor.Named.red.raw
    public var infoText = UIColor.Named.grey1.raw
    public var expandableButtonText = UIColor.Named.blue.raw
    public var cardBackground = UIColor.Named.white.raw
    public var cardShadow = UIColor.Named.grey3.raw.darken(0.08)
    public var pageBackground = UIColor.Named.grey3.raw
    public var menuCardBackground = UIColor.Named.grey3.raw
    public var menuPageBackground = UIColor.Named.white.raw
    public var divider = UIColor.Named.grey2.raw
    public var insetBar = UIColor.Named.grey2.raw
    public var primaryButtonBackground = UIColor.red
    public var primaryButtonDisabledBackground = UIColor.Named.grey1.raw
    public var primaryButtonDisabledText = UIColor.Named.white.raw
    public var primaryButtonHighlightedBackground = UIColor.Named.green1.raw.lighten(0.16)
    public var primaryButtonText = UIColor.Named.white.raw
    public var primaryButtonHighlightedBaseline = UIColor.Named.green1.raw.darken(0.24)
    public var primaryButtonBaseline = UIColor.Named.green1.raw.darken(0.4)
    public var statusCardIconDefaultTint = UIColor.Named.grey1.raw
    public var switchTint = UIColor.Named.blue.raw
    public var switchTintSelected = UIColor.Named.blue.raw.lighten(0.16)
    public var textInputBorder = UIColor.Named.grey1.raw
    public var textInputLeftViewTint = UIColor.Named.grey1.raw
    public var secondaryButtonText = UIColor.Named.blue.raw
    public var secondaryButtonBackground = UIColor.clear
    public var secondaryButtonHighlightedBackground = UIColor.Named.blue.raw.lighten(0.84)
    public var whiteBackground = UIColor.Named.white.raw
    
}

struct MyLightColors: NamedColors {
    
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
