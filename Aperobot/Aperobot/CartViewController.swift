//
//  CartViewController.swift
//  Aperobot
//
//  Created by Adrien Leloup on 18/03/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

import UIKit

class CartViewController: UITableViewController, UIViewControllerTransitioningDelegate {
    var products = [Product]()
    var cartItemsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Avenir Next", size: 12)!]
        
        setToolbar()
        
        cartItemsArray = Array(Cart.sharedInstance.items.keys)
        let total = UIBarButtonItem(title: "Total " + String(getTotalPrice()) + " €", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = total
    }
    
    func pay() {
        Cart.sharedInstance.reset()
        navigationController!.popToRootViewController(animated: true)
    }
    
    func calculate() {
        navigationController!.popToRootViewController(animated: true)
    }
    
    func setToolbar() {
        navigationController?.setToolbarHidden(false, animated: true)
        let calculateButton = UIBarButtonItem(title: "Calculate", style: .plain, target: self, action: #selector(calculate))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let payButton = UIBarButtonItem(title: "Pay " + String(getTotalPrice()) + " €", style: .plain, target: self, action: #selector(pay))
        setToolbarItems([calculateButton, flexibleSpace, payButton], animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.sharedInstance.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.setToolbarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.navigationController?.setToolbarHidden(true, animated: animated)
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
