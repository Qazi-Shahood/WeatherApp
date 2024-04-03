//
//  ApplicationCordinator.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import Foundation
import UIKit

class ApplicationCordinator<T: UIViewController>: Cordinator {
    let rootViewController: T

    init(rootViewController: T) {
        self.rootViewController = rootViewController
    }
    
    // MARK: - Public Methods
    
    func start() { }
    
}
