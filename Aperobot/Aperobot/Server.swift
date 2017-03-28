//
//  Server.swift
//  Aperobot
//
//  Created by Adrien Leloup on 27/03/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

struct Server {

    static let base = "http://192.168.0.4:3000"
    
    static var list: String {
        get { return self.base + "/products" }
    }
    
}
