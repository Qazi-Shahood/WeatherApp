//
//  HomeCordinator.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import Foundation
import UIKit

class HomeCordinator: ApplicationCordinator<UINavigationController> {
    
    init(controller: UINavigationController) {
        super.init(rootViewController: controller)
    }
    
    override func start() {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel, navigator: self)
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    func moveToSearch() {
        let cordinator = SearchCordinator(rootViewController: rootViewController)
        cordinator.start()
    }
    
}

extension HomeCordinator: HomeCordinatorNavigator {
    
    func searchTapped() {
        moveToSearch()
    }
    
}

protocol HomeCordinatorNavigator: AnyObject {
    func searchTapped()
}
