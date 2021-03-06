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
    var totalIncome: Float = 0
    var netIncome: Float = 0
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
        totalLabel.text = "Caisse: " + String(totalIncome) + " €  -  Profits: " + String(netIncome) + " €"
        cartItemsArray = Array(Cart.sharedInstance.items.keys)
    }
    
    func calculate() {
        navigationController!.popToRootViewController(animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
//        navigationController!.popToRootViewController(animated: true)
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath) as! SaleTableViewCell
        let sale = sales[indexPath.row]
        if self.products.first(where: { $0.name == sale.name }) != nil {
            if let amount = sale.sold {
                let floatAmount = Float(amount)
                cell.counter?.text = String(amount)
                cell.price?.text = String(sale.availability! - sale.sold!) + "/" + String(sale.availability!)
                cell.label?.text = sale.name
                let percent: Float = floatAmount / Float(sale.availability!)
                cell.progress?.setProgress(1.0 - percent, animated: true)
                cell.progress?.transform = CGAffineTransform(scaleX: 1, y: 2)
            }
            
        } else {
            cell.textLabel?.text = "Error"
        }
        
        return cell
    }
    
    func setSwipeEvents() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(swipeRight)
    }
    
    @objc func didSwipe(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
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
