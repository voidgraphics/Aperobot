//
//  Server.swift
//  Aperobot
//
//  Created by Adrien Leloup on 27/03/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

struct Server {

    static let base = "http://192.168.0.18:3000"
    
    static var list: String {
        get { return self.base + "/products" }
    }
    
    static var pay: String {
        get { return self.base + "/pay" }
    }
    
    static var sales: String {
        get { return self.base + "/sales" }
    }
    
}
