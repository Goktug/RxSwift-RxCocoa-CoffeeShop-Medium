//
//  OrderCoffeeViewController.swift
//  CoffeeShop
//
//  Created by Göktuğ Gümüş on 24.09.2018.
//  Copyright © 2018 Göktuğ Gümüş. All rights reserved.
//

import UIKit

class OrderCoffeeViewController: BaseViewController {
  @IBOutlet private weak var coffeeIconImageView: UIImageView!
  @IBOutlet private weak var coffeeNameLabel: UILabel!
  @IBOutlet private weak var coffeePriceLabel: UILabel!
  @IBOutlet private weak var orderCountLabel: UILabel!
  @IBOutlet private weak var removeButton: UIButton!
  @IBOutlet private weak var addButton: UIButton!
  @IBOutlet private weak var totalPrice: UILabel!
  @IBOutlet private weak var addToCartButton: UIButton!
  
  var coffee: Coffee!
  var totalOrder: Int = 0 {
    didSet {
      if viewIfLoaded != nil {
        orderCountLabel.text = "\(totalOrder)"
        totalPrice.text = CurrencyFormatter.turkishLirasFormatter.string(from: Float(totalOrder) * coffee.price)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    populateUI()
  }
  
  private func populateUI() {
    guard let coffee = coffee else { return }
    
    coffeeNameLabel.text = coffee.name
    coffeeIconImageView.image = UIImage(named: coffee.icon)
    coffeePriceLabel.text = CurrencyFormatter.turkishLirasFormatter.string(from: coffee.price)
    totalOrder = 0
  }
  
  @IBAction private func addButtonPressed() {
    totalOrder += 1
  }
  
  @IBAction private func removeButtonPressed() {
    guard totalOrder > 0 else { return }
    
    totalOrder -= 1
  }
  
  @IBAction private func addToCartButtonPressed() {
    guard let coffee = coffee else { return }
    
    ShoppingCart.shared.addCoffee(coffee, withCount: totalOrder)
    
    navigationController?.popViewController(animated: true)
  }
}
