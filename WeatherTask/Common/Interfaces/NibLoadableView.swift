//
//  NibLoadableView.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import Foundation
import UIKit

protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

extension UITableViewCell: NibLoadableView {}
