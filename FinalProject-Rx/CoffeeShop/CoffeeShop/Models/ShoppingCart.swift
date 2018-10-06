//
//  ShoppingCart.swift
//  CoffeeShop
//
//  Created by Göktuğ Gümüş on 25.09.2018.
//  Copyright © 2018 Göktuğ Gümüş. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ShoppingCart {
  
  static let shared = ShoppingCart()
  
  var coffees: BehaviorRelay<[Coffee: Int]> = .init(value: [:]) // 1
  
  private init() {}
  
  func addCoffee(_ coffee: Coffee, withCount count: Int) {
    var tempCoffees = coffees.value // 2
    
    if let currentCount = tempCoffees[coffee] {
      tempCoffees[coffee] = currentCount + count
    } else {
      tempCoffees[coffee] = count
    }
    
    coffees.accept(tempCoffees) // 3
  }
  
  func removeCoffee(_ coffee: Coffee) {
    var tempCoffees = coffees.value // 4
    tempCoffees[coffee] = nil
    
    coffees.accept(tempCoffees) // 5
  }
  
  func getTotalCost() -> Observable<Float> { // 6
    return coffees.map { $0.reduce(Float(0)) { $0 + ($1.key.price * Float($1.value)) }} // 7
  }
  
  func getTotalCount() -> Observable<Int> { // 8
    return coffees.map { $0.reduce(0) { $0 + $1.value }} // 9
  }
  
  func getCartItems() -> Observable<[CartItem]> { // 10
    return coffees.map { $0.map { CartItem(coffee: $0.key, count: $0.value) }} // 11
  }
}
