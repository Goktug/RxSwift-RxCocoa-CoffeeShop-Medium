//
//  CurrencyFormatter.swift
//  CoffeeShop
//
//  Created by Göktuğ Gümüş on 24.09.2018.
//  Copyright © 2018 Göktuğ Gümüş. All rights reserved.
//

import Foundation

enum CurrencyFormatter {
  static let turkishLirasFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "tr_TR")
    return formatter
  }()
}

extension NumberFormatter {
  func string(from float: Float) -> String? {
    return self.string(from: NSNumber(value: float))
  }
  
  func string(from int: Int) -> String? {
    return self.string(from: NSNumber(value: int))
  }
}
