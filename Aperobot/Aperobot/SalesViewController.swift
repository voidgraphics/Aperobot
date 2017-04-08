//
//  CartViewController.swift
//  Aperobot
//
//  Created by Adrien Leloup on 18/03/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

import UIKit
import Alamofire

class SalesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {
    var products = [Product]()
    var cartItemsArray = [String]()
    var sales = [Product]()
    var totalIncome: Float?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    @IBAction func circleTapped(sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        setSwipeEvents()
        totalLabel.text = "Caisse: " + String(totalIncome ?? 0) + " €"
        cartItemsArray = Array(Cart.sharedInstance.items.keys)
    }
    
    func calculate() {
        navigationController!.popToRootViewController(animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController!.popToRootViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath) as! CartTableViewCell
        let sale = sales[indexPath.row]
        
        if let product = self.products.first(where: { $0.name == sale.name }) {
            if let amount = sale.sold {
                let floatAmount = Float(amount)
                let totalPrice = product.salePrice * floatAmount
                cell.counter?.text = String(amount)
                cell.price?.text = String(totalPrice) + " €"
                cell.label?.text = sale.name
            }
            
        } else {
            cell.textLabel?.text = "Error"
        }
        
        return cell
    }
    
    func setSwipeEvents() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipeLeft)
    }
    
    func didSwipe(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
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
