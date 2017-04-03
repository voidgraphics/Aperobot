//
//  BottomBarView.swift
//  Aperobot
//
//  Created by Adrien Leloup on 3/04/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

import UIKit

class BottomBarView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawShadow()
    }
    
    func drawShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
}
