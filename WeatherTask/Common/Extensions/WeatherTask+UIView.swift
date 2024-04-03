//
//  WeatherTask+UIView.swift
//  WeatherTask
//
//  Created by qms on 23/03/2024.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var roundRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}
