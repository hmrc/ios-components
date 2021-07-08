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
        Components.Helpers.ColorConfig.shared.semanticLightColors = MySemanticColors()
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
    public var darkText = UIColor.SemanticLightColors().darkText
    public var lightText = UIColor.SemanticLightColors().lightText
    public var linkText = UIColor.SemanticLightColors().linkText
    public var errorText = UIColor.SemanticLightColors().errorText
    public var infoText = UIColor.SemanticLightColors().infoText
    public var expandableButtonText = UIColor.SemanticLightColors().expandableButtonText
    public var cardBackground = UIColor.SemanticLightColors().cardBackground
    public var cardShadow = UIColor.SemanticLightColors().cardShadow
    public var pageBackground = UIColor.SemanticLightColors().pageBackground
    public var menuCardBackground = UIColor.SemanticLightColors().menuCardBackground
    public var menuPageBackground = UIColor.SemanticLightColors().menuPageBackground
    public var divider = UIColor.SemanticLightColors().divider
    public var insetBar = UIColor.SemanticLightColors().insetBar
    public var primaryButtonBackground = UIColor.SemanticLightColors().primaryButtonBackground
    public var primaryButtonDisabledBackground = UIColor.SemanticLightColors().primaryButtonDisabledBackground
    public var primaryButtonDisabledText = UIColor.SemanticLightColors().primaryButtonDisabledText
    public var primaryButtonHighlightedBackground = UIColor.SemanticLightColors().primaryButtonHighlightedBackground
    public var primaryButtonText = UIColor.SemanticLightColors().primaryButtonText
    public var primaryButtonHighlightedBaseline = UIColor.SemanticLightColors().primaryButtonHighlightedBaseline
    public var primaryButtonBaseline = UIColor.SemanticLightColors().primaryButtonBaseline
    public var statusCardIconDefaultTint = UIColor.SemanticLightColors().statusCardIconDefaultTint
    public var switchTint = UIColor.SemanticLightColors().switchTint
    public var switchTintSelected = UIColor.SemanticLightColors().switchTintSelected
    public var textInputBorder = UIColor.SemanticLightColors().textInputBorder
    public var textInputLeftViewTint = UIColor.SemanticLightColors().textInputLeftViewTint
    public var secondaryButtonText = UIColor.SemanticLightColors().secondaryButtonText
    public var secondaryButtonBackground = UIColor.SemanticLightColors().secondaryButtonBackground
    public var secondaryButtonHighlightedBackground = UIColor.SemanticLightColors().secondaryButtonHighlightedBackground
    public var whiteBackground = UIColor.SemanticLightColors().whiteBackground
    
}
