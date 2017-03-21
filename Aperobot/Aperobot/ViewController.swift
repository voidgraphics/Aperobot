//
//  ViewController.swift
//  Aperobot
//
//  Created by Adrien Leloup on 14/03/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var products = [Product]()
    let cart: Cart = Cart()

    @IBAction func addItem(_ sender: UIButton) {
        let product = products[sender.tag]
        cart.add(product)
        
        let indexPath = IndexPath(item: sender.tag, section: 0)
        if let cell = collectionView!.cellForItem(at: indexPath) as? ProductCell {
            print(cell.name.text)
            cell.updateCounter(cart.getCount(for: product))
            collectionView!.reloadData()
        }
        
        updateOrderCount()
    }
    
    @IBAction func rmvItem(_ sender: UIButton) {
        let product = products[sender.tag]
        cart.remove(product)
        updateOrderCount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        populateProducts()
    }
    
    func setNavBar() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetOrder))
        navigationItem.leftBarButtonItem = refreshButton
        let cartButton = UIBarButtonItem(title: "Cart: " + String(cart.getFullCount()), style: .plain, target: self, action: #selector(showCart))
        navigationItem.rightBarButtonItem = cartButton
    }
    
    func setToolbar() {
        navigationController?.setToolbarHidden(false, animated: true)
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetOrder))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cartButton = UIBarButtonItem(title: String(cart.getFullCount()), style: .plain, target: self, action: #selector(showCart))
        setToolbarItems([refreshButton, flexibleSpace, cartButton], animated: true)
    }
    
    func showCart() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Cart") as? CartViewController {
            vc.cart = self.cart
            vc.products = self.products
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func populateProducts() {
        let product1 = Product(name: "Orval", image: "beer", sellingPrice: 4.5, price: 3.03)
        let product2 = Product(name: "Vin blanc", image: "whitewine", sellingPrice: 2.5, price: 1.5)
        let product3 = Product(name: "Vin rosé", image: "rosewine", sellingPrice: 2.5, price: 1.5)
        let product4 = Product(name: "Vin rouge", image: "redwine", sellingPrice: 2.5, price: 1.5)
        let product5 = Product(name: "Burger", image: "hamburger", sellingPrice: 3.5, price: 2.0)
        let product6 = Product(name: "Assiette fromage", image: "snack", sellingPrice: 4.5, price: 3.0)
        products.append(product1)
        products.append(product2)
        products.append(product3)
        products.append(product4)
        products.append(product5)
        products.append(product6)
        collectionView?.reloadData()
    }
    
    func updateOrderCount() {
        if var items = toolbarItems {
            items[2].title = "Cart: " + String(cart.getFullCount())
            setToolbarItems(items, animated: true)
        }
         navigationItem.rightBarButtonItem?.title = "Cart: " + String(cart.getFullCount())
    }
    
    func resetOrder() {
        cart.reset()
        for cell in collectionView!.visibleCells as! [ProductCell] {
            cell.updateCounter(0)
        }
        updateOrderCount()
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

