
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawShadow()
    }
    
    func populate(_ product: Product, _ row: Int) {
        setText(product.name)
        addBtn.tag = row
        rmvBtn.tag = row
        drawImage(product.image)
    }
    
    func setText(_ text: String) {
        name.text = text.uppercased()
    }
    
    func drawImage(_ name: String) {
        if let image = UIImage(named: name){
            self.imageView.image = image
        }
    }
    
    func updateCounter(_ count: Int) {
        print(name.text! + " " + counter.text!)
        counter.text = String(count)
        counter.isHidden = count == 0
        print(name.text! + " " + counter.text!)
    }
    
    func drawShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
}
