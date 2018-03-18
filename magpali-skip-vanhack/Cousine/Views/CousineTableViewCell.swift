//
//  CousineTableViewCell.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import UIKit

class CousineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = .boldSystemFont(ofSize: 20)
    }

    func populate(with cousine: Cousine) {
        nameLabel.text = cousine.name
    }
    
}
