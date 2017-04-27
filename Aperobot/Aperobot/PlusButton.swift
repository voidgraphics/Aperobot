//
//  PlusButton.swift
//  Aperobot
//
//  Created by WhiteCube on 20/04/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

import UIKit

class PlusButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners([.bottomRight, .bottomLeft], radius: 4)
    }

}
