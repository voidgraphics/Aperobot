//
//  Order.swift
//  Aperobot
//
//  Created by Adrien Leloup on 14/03/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

import UIKit

class Cart: NSObject {
    var items = [String: Int]()
    
    func add(_ item: Product) {
        if (items[item.name] != nil) {
            items[item.name]! += 1
        } else {
            items[item.name] = 1
        }
    }
    
    func remove(_ item: Product) {
        if (items[item.name] != nil) {
            items[item.name]! -= 1
            if(items[item.name]! <= 0) {
                items.removeValue(forKey: item.name)
            }
        }
    }
    
    func reset() {
        items = [:]
    }
    
    func getCount(for product: Product) -> Int {
        if let count = self.items[product.name] {
            return count
        } else {
            return 0
        }
    }
    
    func getFullCount() -> Int {
        var count = 0
        for(_, amount) in items {
            count += amount
        }
        return count
    }
}
