//
//  Order.swift
//  Aperobot
//
//  Created by Adrien Leloup on 14/03/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

import UIKit

class Cart: NSObject {
    var items = [Product]()
    
    func add(item: Product) {
        items.append(item)
        print(items)
    }
    
    func reset() {
        items = []
    }
}
