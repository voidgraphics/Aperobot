
//  ProductCell.swift
//  Aperobot
//
//  Created by Adrien Leloup on 14/03/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var rmvBtn: UIButton!
    @IBOutlet weak var counter: UILabel!
    var shadowLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func populate(_ product: Product, _ row: Int) {
        setText(product.name)
        addBtn.tag = row
        rmvBtn.tag = row
        updateCounter(product.inCart)
        drawImage(product.image)
    }
    
    func setText(_ text: String) {
        name.text = text
    }
    
    func drawImage(_ name: String) {
        if let image = UIImage(named: name){
            self.imageView.image = image
        }
    }
    
    func updateCounter(_ count: Int) {
        self.counter.text = String(count)
        self.counter.isHidden = count == 0
    }
}
