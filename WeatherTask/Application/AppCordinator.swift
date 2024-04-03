//
//  AppCordinator.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import Foundation
import UIKit

class AppCordinator: ApplicationCordinator<UINavigationController> {
    
    init(navigationController: UINavigationController) {
        super.init(rootViewController: navigationController)
    }
    
    override func start() {
        let homeCordinator = HomeCordinator(controller: rootViewController)
        homeCordinator.start()
    }
    
}
