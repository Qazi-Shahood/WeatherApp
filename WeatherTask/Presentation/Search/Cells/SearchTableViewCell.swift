//
//  SearchTableViewCell.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with name: String) {
        nameLabel.text = name
    }
    
}
