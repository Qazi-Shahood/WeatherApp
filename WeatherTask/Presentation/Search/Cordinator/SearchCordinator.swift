//
//  SearchCordinator.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import Foundation
import UIKit

class SearchCordinator: ApplicationCordinator<UINavigationController> {
    
    override func start() {
        let viewModel = SearchViewModel()
        let viewController = SearchViewController(navigator: self, viewModel: viewModel)
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    func moveToHome(lat: String, long: String) {
        let vc = rootViewController.viewControllers.first as? HomeViewController
        vc?.getWeatherDetails(for: lat, long: long)
        rootViewController.popViewController(animated: true)
    }
    
}

extension SearchCordinator: SearchCordinatorNavigator {
    
    func locationSelected(with lat: String, long: String) {
        moveToHome(lat: lat, long: long)
    }
    
}

protocol SearchCordinatorNavigator: AnyObject {
    func locationSelected(with lat: String, long: String)
}
