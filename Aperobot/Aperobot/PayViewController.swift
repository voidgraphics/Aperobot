//
//  CartViewController.swift
//  Aperobot
//
//  Created by Adrien Leloup on 18/03/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

import UIKit
import Alamofire

class PayViewController: UIViewController {
    
    var total : Float = 0

    @IBOutlet weak var totalLabel: UILabel!
    @IBAction func pay(_ sender: Any) {
        if Cart.sharedInstance.items.count == 0 { return }
        let parameters: Parameters = ["items": Cart.sharedInstance.items]
        Alamofire.request(Server.pay, method: .post, parameters: parameters)
        hideModalAndResetCart()
    }

    @IBAction func hideModal(_ sender: Any) {
        hideModal()
    }


    override func viewDidLoad() {
        
        if let parent = self.presentingViewController {
            let cartVC = parent.children[1] as! CartViewController
            totalLabel.text = cartVC.getTotalPrice().description + "€"
        }
        setSwipeEvents()
    }

    func setSwipeEvents() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc func didSwipe(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.down:
                hideModal()
            default:
                break
            }
        }
    }


    func hideModal() {
        if let parent = self.presentingViewController {
            let cartVC = parent.children[1] as! CartViewController
            cartVC.overlay.fadeOut()
//            cartVC.overlay.isHidden = true
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func hideModalAndResetCart() {
        if let parent = self.presentingViewController {
            let cartVC = parent.children[1] as! CartViewController
            cartVC.overlay.fadeOut()
//            cartVC.overlay.isHidden = true
            dismiss(animated: true, completion: nil)
            Cart.sharedInstance.reset()
            cartVC.backAndReset()
            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
