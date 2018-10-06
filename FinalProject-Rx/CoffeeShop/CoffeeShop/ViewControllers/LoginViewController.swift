//
//  LoginViewController.swift
//  CoffeeShop
//
//  Created by Göktuğ Gümüş on 23.09.2018.
//  Copyright © 2018 Göktuğ Gümüş. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
  @IBOutlet private weak var emailTextfield: UITextField!
  @IBOutlet private weak var passwordTextfield: UITextField!
  @IBOutlet private weak var logInButton: UIButton!
  
  private let disposeBag = DisposeBag()
  private let throttleInterval = 0.1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let emailValid = emailTextfield
      .rx
      .text // 1
      .orEmpty // 2
      .throttle(throttleInterval, scheduler: MainScheduler.instance)
      .map { self.validateEmail(with: $0) } // 3
      .debug("emailValid", trimOutput: true) // 4
      .share(replay: 1) // 5
    
    let passwordValid = passwordTextfield.rx.text.orEmpty
      .throttle(throttleInterval, scheduler: MainScheduler.instance)
      .map { $0.count >= 6 }
      .debug("passwordValid", trimOutput: true)
      .share(replay: 1)
    
    let everythingValid = Observable
      .combineLatest(emailValid, passwordValid) { $0 && $1 } // 1
      .debug("everythingValid", trimOutput: true)
      .share(replay: 1)
    
    everythingValid
      .bind(to: logInButton.rx.isEnabled) // 1
      .disposed(by: disposeBag) // 2
  }
  
  private func validateEmail(with email: String) -> Bool {
    let emailPattern = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"
    let predicate = NSPredicate(format:"SELF MATCHES %@", emailPattern)
    
    return predicate.evaluate(with: email)
  }
  
  @IBAction private func logInButtonPressed() {
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let initialViewController = mainStoryboard.instantiateInitialViewController()!
    
    UIApplication.changeRoot(with: initialViewController)
  }
}
