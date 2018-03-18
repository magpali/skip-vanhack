//
//  ProductsTableViewCell.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailedInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    func applyLayout() {
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.numberOfLines = 0
        priceLabel.textColor = .money
        detailedInfoLabel.font = .systemFont(ofSize: 14)
        detailedInfoLabel.numberOfLines = 0
    }
    
    func populate(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = "$\(product.price?.moneyFormat() ?? "no value")"
        detailedInfoLabel.text = product.detailedInfo
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        priceLabel.text = nil
        detailedInfoLabel.text = nil
    }

}
