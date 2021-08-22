//
//  SceneDelegate.swift
//  MVVM-EventApp
//
//  Created by Gabriel on 18/08/21.
//

import UIKit

@available(iOS 13, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
     
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let safeWindow = UIWindow(windowScene: windowScene)
        safeWindow.frame = UIScreen.main.bounds
        safeWindow.rootViewController = EventListViewController()
        safeWindow.makeKeyAndVisible()
        window = safeWindow
    }
}
