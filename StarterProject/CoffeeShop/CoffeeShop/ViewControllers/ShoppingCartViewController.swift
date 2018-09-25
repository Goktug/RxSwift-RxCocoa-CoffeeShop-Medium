//
//  ShoppingCartViewController.swift
//  CoffeeShop
//
//  Created by Göktuğ Gümüş on 25.09.2018.
//  Copyright © 2018 Göktuğ Gümüş. All rights reserved.
//

import UIKit

class ShoppingCartViewController: BaseViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var totalPriceLabel: UILabel!
  
  var cartItems: [CartItem] = []
  var totalPrice: Float = 0 {
    didSet {
      if viewIfLoaded != nil {
        totalPriceLabel.text = CurrencyFormatter.turkishLirasFormatter.string(from: totalPrice)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
    loadData()
  }
  
  private func loadData() {
    cartItems = ShoppingCart.shared.getCartItems()
    totalPrice = ShoppingCart.shared.getTotalCost()
  }
  
  private func removeCartItem(at row: Int) {
    guard row < cartItems.count else { return }
    
    ShoppingCart.shared.removeCoffee(cartItems[row].coffee)
    
    loadData()
  }
  
  private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
    tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
  }
}

extension ShoppingCartViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 104
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    return .delete
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      removeCartItem(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
}

extension ShoppingCartViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cartItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "cartCoffeeCell", for: indexPath) as? CartCoffeeCell {
      cell.configure(with: cartItems[indexPath.row])
      
      return cell
    }
    
    return UITableViewCell()
  }
}

