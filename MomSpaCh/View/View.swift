//
//  ViewController.swift
//  MomSpaCh
//
//  Created by 김동현 on 7/2/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupButtonsStackView()
  }

  private func setupButtonsStackView() {
    let cancelButton = createCancelButton()
    let orderButton = createOrderButton()
    
    let stackView = UIStackView(arrangedSubviews: [cancelButton, orderButton])
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    stackView.spacing = 10
    
    view.addSubview(stackView)
      
      stackView.snp.makeConstraints {
        $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
        $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        $0.height.equalTo(50)
      }
  }
  
  private func createOrderButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle("주문하기", for: .normal)
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    button.backgroundColor = UIColor(red: 235/255, green: 51/255, blue: 77/255, alpha: 1.0)
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 5
    return button
  }
  
  private func createCancelButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle("취소", for: .normal)
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    button.backgroundColor = .white
    button.setTitleColor(UIColor(red: 235/255, green: 51/255, blue: 77/255, alpha: 1.0), for: .normal)
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor(red: 235/255, green: 51/255, blue: 77/255, alpha: 1.0).cgColor
    button.layer.cornerRadius = 5
    return button
  }
}
