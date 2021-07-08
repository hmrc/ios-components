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
        // Override point for customization after application launch.
//        Components.Helpers.ColorConfig.shared.semanticLightColors = MySemanticColors()
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
    
    private static let defaultColors = UIColor.SemanticLightColors()
    
    public var darkText = defaultColors.darkText
    public var lightText = defaultColors.lightText
    public var linkText = defaultColors.linkText
    public var errorText = defaultColors.errorText
    public var infoText = defaultColors.infoText
    public var expandableButtonText = defaultColors.expandableButtonText
    public var cardBackground = defaultColors.cardBackground
    public var cardShadow = defaultColors.cardShadow
    public var pageBackground = defaultColors.pageBackground
    public var menuCardBackground = defaultColors.menuCardBackground
    public var menuPageBackground = defaultColors.menuPageBackground
    public var divider = defaultColors.divider
    public var insetBar = defaultColors.insetBar
    public var primaryButtonBackground = defaultColors.primaryButtonBackground
    public var primaryButtonDisabledBackground = defaultColors.primaryButtonDisabledBackground
    public var primaryButtonDisabledText = defaultColors.primaryButtonDisabledText
    public var primaryButtonHighlightedBackground = defaultColors.primaryButtonHighlightedBackground
    public var primaryButtonText = defaultColors.primaryButtonText
    public var primaryButtonHighlightedBaseline = defaultColors.primaryButtonHighlightedBaseline
    public var primaryButtonBaseline = defaultColors.primaryButtonBaseline
    public var statusCardIconDefaultTint = defaultColors.statusCardIconDefaultTint
    public var switchTint = defaultColors.switchTint
    public var switchTintSelected = defaultColors.switchTintSelected
    public var textInputBorder = defaultColors.textInputBorder
    public var textInputLeftViewTint = defaultColors.textInputLeftViewTint
    public var secondaryButtonText = defaultColors.secondaryButtonText
    public var secondaryButtonBackground = defaultColors.secondaryButtonBackground
    public var secondaryButtonHighlightedBackground = defaultColors.secondaryButtonHighlightedBackground
    public var whiteBackground = defaultColors.whiteBackground
    
}
