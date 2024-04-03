//
//  UITableView+Reusable.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
}
