//
//  SceneDelegate.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCordinator: AppCordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        appCordinator = AppCordinator(navigationController: navigationController)
        appCordinator?.start()
        window?.makeKeyAndVisible()
    }
    

}

