//
//  ViewController.swift
//  Aperobot
//
//  Created by Adrien Leloup on 14/03/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let cart = Cart()

class ViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cartCountLabel: UILabel!
    
    @IBAction func circleTapped(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedSalesButton(_ sender: Any) {
        showSales()
    }
    var products = [Product]()
    
    @IBAction func reset(_ sender: Any) {
        resetOrder()
    }

    @IBAction func addItem(_ sender: UIButton) {
        let product = products[sender.tag]
        Cart.sharedInstance.add(product)
        updateItemCount(amount: 1, product: product)
        updateOrderCount()
    }
    
    @IBAction func rmvItem(_ sender: UIButton) {
        let product = products[sender.tag]
        Cart.sharedInstance.remove(product)
        updateItemCount(amount: -1, product: product)
        updateOrderCount()
    }
    
    override func viewDidLoad() {
        collectionView!.delegate = self
        collectionView!.dataSource = self
        super.viewDidLoad()
        populateProducts()
        setSwipeEvents()
    }
    
    func setSwipeEvents() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeLeft)
    }
    
    func didSwipe(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                showSales()
            case UISwipeGestureRecognizerDirection.left:
                showCart()
            default:
                break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PushSegue" {
            if let nextVC = segue.destination as? CartViewController {
                nextVC.products = self.products
            }
        }
    }
    
    func showCart() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Cart2") as? CartViewController {
            vc.products = self.products
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showSales() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Sales") as? SalesViewController {
            vc.products = self.products
            var sales = [Product]()
            Alamofire.request(Server.sales).responseJSON { response in
                if (response.result.value as! NSDictionary?) != nil {
                    let jsonResponse = JSON(response.result.value as Any)
                    if let responseProducts = jsonResponse["products"] as JSON? {
                        for (_,product):(String, JSON) in responseProducts {
                            let prod = Product(name: product["name"].stringValue, image: product["icon"].stringValue, salePrice: product["salePrice"].floatValue, price: product["price"].floatValue)
                            prod.sold = product["sold"].intValue
                            prod.availability = product["availability"].intValue
                            sales.append(prod)
                        }
                        vc.sales = sales
                        
                        if let totalincome = jsonResponse["totalIncome"] as JSON? {
                            vc.totalIncome = totalincome.floatValue
                        }
                        
                        if let netincome = jsonResponse["netIncome"] as JSON? {
                            vc.netIncome = netincome.floatValue
                        }
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }
    
    func populateProducts() {
        Alamofire.request(Server.list).responseJSON { response in
            if (response.result.value as! NSDictionary?) != nil {
                let jsonResponse = JSON(response.result.value as Any)
                if let responseProducts = jsonResponse["products"] as JSON? {
                    for (_,product):(String, JSON) in responseProducts {
                        let prod = Product(name: product["name"].stringValue, image: product["icon"].stringValue, salePrice: product["salePrice"].floatValue, price: product["price"].floatValue)
                        self.products.append(prod)
                    }
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    func updateItemCount(amount: Int, product: Product) {
        print(product.inCart)
        product.inCart += amount
        if(product.inCart < 0) { product.inCart = 0 }
        collectionView?.reloadData()
    }
    
    func updateOrderCount() {
        let count = Cart.sharedInstance.getFullCount()
        cartCountLabel?.text = String(count)
        cartCountLabel?.isHidden = count == 0
    }
    
    func resetOrder(callback: (() -> ())? = nil) {
        Cart.sharedInstance.reset()
        for product in products {
            product.inCart = 0
        }
        collectionView?.reloadData()
        updateOrderCount()
        callback?()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Product", for: indexPath) as! ProductCell
        let product = products[indexPath.item]
        cell.populate(product, indexPath.row)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

