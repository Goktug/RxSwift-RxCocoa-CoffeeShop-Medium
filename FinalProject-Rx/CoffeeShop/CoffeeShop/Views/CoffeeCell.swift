//
//  CoffeeCell.swift
//  CoffeeShop
//
//  Created by Göktuğ Gümüş on 23.09.2018.
//  Copyright © 2018 Göktuğ Gümüş. All rights reserved.
//

import UIKit

class CoffeeCell: UITableViewCell {
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  func configure(with coffee: Coffee) {
    iconImageView.image = UIImage(named: coffee.icon)
    nameLabel.text = coffee.name
  }
}
