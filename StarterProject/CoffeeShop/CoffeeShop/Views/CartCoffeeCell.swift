//
//  CartCoffeeCell.swift
//  CoffeeShop
//
//  Created by Göktuğ Gümüş on 25.09.2018.
//  Copyright © 2018 Göktuğ Gümüş. All rights reserved.
//

import UIKit

class CartCoffeeCell: UITableViewCell {
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var countLabel: UILabel!
  @IBOutlet weak var totalPriceLabel: UILabel!
  
  func configure(with cartItem: CartItem) {
    iconImageView.image = UIImage(named: cartItem.coffee.icon)
    nameLabel.text = cartItem.coffee.name
    countLabel.text = "\(cartItem.count) cup of coffee"
    totalPriceLabel.text = CurrencyFormatter.turkishLirasFormatter.string(from: cartItem.totalPrice)
  }
}
