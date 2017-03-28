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

class ViewController: UICollectionViewController {
    
    var products = [Product]()

    @IBAction func addItem(_ sender: UIButton) {
        let product = products[sender.tag]
        Cart.sharedInstance.add(product)
        updateItemCount(tag: sender.tag, product: product)
        updateOrderCount()
    }
    
    @IBAction func rmvItem(_ sender: UIButton) {
        let product = products[sender.tag]
        Cart.sharedInstance.remove(product)
        updateItemCount(tag: sender.tag, product: product)
        updateOrderCount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        populateProducts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(Cart.sharedInstance.items)
    }
    
    func setNavBar() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetOrder))
        navigationItem.leftBarButtonItem = refreshButton
        let cartButton = UIBarButtonItem(title: "Cart: " + String(Cart.sharedInstance.getFullCount()), style: .plain, target: self, action: #selector(showCart))
        navigationItem.rightBarButtonItem = cartButton
    }
    
    func setToolbar() {
        navigationController?.setToolbarHidden(false, animated: true)
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetOrder))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cartButton = UIBarButtonItem(title: String(Cart.sharedInstance.getFullCount()), style: .plain, target: self, action: #selector(showCart))
        setToolbarItems([refreshButton, flexibleSpace, cartButton], animated: true)
    }
    
    func showCart() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Cart") as? CartViewController {
            vc.products = self.products
            navigationController?.pushViewController(vc, animated: true)
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
    
    func updateItemCount(tag: Int, product: Product) {
        let indexPath = IndexPath(item: tag, section: 0)
        if let cell = collectionView!.cellForItem(at: indexPath) as? ProductCell {
            cell.updateCounter(Cart.sharedInstance.getCount(for: product))
        }
    }
    
    func updateOrderCount() {
        if var items = toolbarItems {
            items[2].title = "Cart: " + String(Cart.sharedInstance.getFullCount())
            setToolbarItems(items, animated: true)
        }
         navigationItem.rightBarButtonItem?.title = "Cart: " + String(Cart.sharedInstance.getFullCount())
    }
    
    func resetOrder() {
        Cart.sharedInstance.reset()
        for cell in collectionView!.visibleCells as! [ProductCell] {
            cell.updateCounter(0)
        }
        updateOrderCount()
        collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

