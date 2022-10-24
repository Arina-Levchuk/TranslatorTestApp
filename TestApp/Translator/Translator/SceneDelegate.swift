//
//  SceneDelegate.swift
//  Translator
//
//  Created by admin on 2/22/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationBar = UINavigationController(rootViewController: TTAResultTableVC())
        window?.rootViewController = navigationBar
        window?.makeKeyAndVisible()
        
        let defaults = UserDefaults.standard
        window?.overrideUserInterfaceStyle = defaults.appearanceMode.userInterfaceStyle
    }
        
    func sceneDidDisconnect(_ scene: UIScene) {
        self.window?.endEditing(true)
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        self.window?.endEditing(true)
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
