//
//  LeftPaddedUITextfield.swift
//  Aperobot
//
//  Created by WhiteCube on 21/06/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

import UIKit

class LeftPaddedUITextfield: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by:padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
