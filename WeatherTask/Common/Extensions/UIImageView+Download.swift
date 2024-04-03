//
//  UIImageView+Download.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url, options: .mappedIfSafe) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
