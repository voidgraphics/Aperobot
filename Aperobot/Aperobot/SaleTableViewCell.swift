//
//  CartTableViewCell.swift
//  Aperobot
//
//  Created by Adrien Leloup on 20/03/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

import UIKit

class SaleTableViewCell: UITableViewCell {
    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
