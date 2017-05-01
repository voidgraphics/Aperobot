//
//  CartViewController.swift
//  Aperobot
//
//  Created by Adrien Leloup on 18/03/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

import UIKit

class PayViewController: UIViewController {

    @IBAction func hideModal(_ sender: Any) {
        print("dismissing")
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        print("hello")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
