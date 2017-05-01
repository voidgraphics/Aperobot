//
//  CartViewController.swift
//  Aperobot
//
//  Created by Adrien Leloup on 18/03/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

import UIKit
import Alamofire

class CartViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {
    var products = [Product]()
    var cartItemsArray = [String]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var overlay: UIButton!

    @IBAction func pay(_ sender: Any) {
        overlay.isHidden = false
//        if Cart.sharedInstance.items.count == 0 { return }
//        if let next = navigationController!.viewControllers.first as? ViewController {
//            let parameters: Parameters = ["items": Cart.sharedInstance.items]
//            Alamofire.request(Server.pay, method: .post, parameters: parameters)
//            next.resetOrder() {
//                self.navigationController?.popToRootViewController(animated: true)
//            }
//        }
    }
    
    @IBAction func circleTapped(sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        setSwipeEvents()
        cartItemsArray = Array(Cart.sharedInstance.items.keys)
    }
    
    func calculate() {
        navigationController!.popToRootViewController(animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController!.popToRootViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.sharedInstance.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath) as! CartTableViewCell
        let productName = cartItemsArray[indexPath.row]
        if let product = self.products.first(where: { $0.name == productName }) {
            if let amount = Cart.sharedInstance.items[product.name] {
                let floatAmount = Float(amount)
                let totalPrice = product.salePrice * floatAmount
                cell.counter?.text = String(amount)
                cell.price?.text = String(totalPrice) + " €"
                cell.label?.text = product.name
            }
            
        } else {
            cell.textLabel?.text = "Error"
        }
        
        return cell
    }
    
    func getTotalPrice() -> Float {
        var price: Float = 0
        for(name, amount) in Cart.sharedInstance.items {
            if let product = self.products.first(where: { $0.name == name } ) {
                price += Float(amount) * product.salePrice
            }
        }
        return price
    }
    
    func setSwipeEvents() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeRight)
    }
    
    func didSwipe(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                navigationController?.popToRootViewController(animated: true)
            default:
                break
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
