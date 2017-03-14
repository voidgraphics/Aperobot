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
        cart.add(item: products[sender.tag])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        populateProducts()
    }
    
    func setNavBar() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetOrder))
        refreshButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = refreshButton
    }
    
    func populateProducts() {
        let product1 = Product(name: "Orval", image: "beer")
        let product2 = Product(name: "Vin blanc", image: "whitewine")
        let product3 = Product(name: "Vin rosé", image: "rosewine")
        let product4 = Product(name: "Vin rouge", image: "redwine")
        let product5 = Product(name: "Burger", image: "hamburger")
        let product6 = Product(name: "Assiette fromage", image: "snack")
        products.append(product1)
        products.append(product2)
        products.append(product3)
        products.append(product4)
        products.append(product5)
        products.append(product6)
        collectionView?.reloadData()
    }
    
    func resetOrder() {
        cart.reset()
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

