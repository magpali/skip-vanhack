//
//  StoreTableViewCell.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import UIKit

class StoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    func populate(with store: Store) {
        nameLabel.text = store.name
        addressLabel.text = store.address
    }
    
    private func applyLayout() {
        nameLabel.font = .boldSystemFont(ofSize: 18)
        addressLabel.font = .systemFont(ofSize: 14)
        addressLabel.numberOfLines = 0
    }
    
}
