//
//  ShoppingCartViewController.swift
//  CoffeeShop
//
//  Created by Göktuğ Gümüş on 25.09.2018.
//  Copyright © 2018 Göktuğ Gümüş. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ShoppingCartViewController: BaseViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var totalPriceLabel: UILabel!
  
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
    
    // Rx - Setup
    ShoppingCart.shared.getCartItems()
      .bind(to: tableView.rx
        .items(cellIdentifier: "cartCoffeeCell", cellType: CartCoffeeCell.self)) { row, element, cell in
          cell.configure(with: element)
      }
      .disposed(by: disposeBag)
    
    ShoppingCart.shared.getTotalCost()
      .subscribe(onNext: { [weak self] totalCost in
        self?.totalPriceLabel.text = CurrencyFormatter.turkishLirasFormatter.string(from: totalCost)
      })
      .disposed(by: disposeBag)
    
    tableView.rx
      .modelDeleted(CartItem.self) // 1
      .subscribe(onNext: { cartItem in // 2
        ShoppingCart.shared.removeCoffee(cartItem.coffee) // 3
      })
      .disposed(by: disposeBag)
  }
  
  private func configureTableView() {
    tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
    tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
    tableView.rowHeight = 104
  }
}
