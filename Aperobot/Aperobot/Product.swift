//
//  Product.swift
//  Aperobot
//
//  Created by Adrien Leloup on 14/03/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

import UIKit

class Product: NSObject {
    var name: String
    var image: String
    var salePrice: Float
    var price: Float
    
    init(name: String, image: String, salePrice: Float, price: Float) {
        self.name = name
        self.image = image
        self.salePrice = salePrice
        self.price = price
    }
}
