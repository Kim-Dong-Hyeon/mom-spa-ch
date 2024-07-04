//
//  MenuCollectionViewCell.swift
//  MomSpaCh
//
//  Created by 김윤홍 on 7/3/24.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
  let menuData = Data()
  static let identifier = "cell"
  
  private let menuButton: UIButton = {
    var menuButton = UIButton()
    return menuButton
  }()
  
  private let priceLabel: UILabel = {
    var cellLabel = UILabel()
    return cellLabel
  }()
  
  private let nameLabel: UILabel = {
    var nameLabel = UILabel()
    nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
    return nameLabel
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setimageView()
    setMenuLabel()
    addSubview(nameLabel)
    setConstraints()
    if let image = menuData.foodMenu["burger"]?.keys.first {
      menuButton.setImage(image, for: .normal)
    }
    
    if let price = menuData.foodMenu["burger"]?.values.first {
      priceLabel.text = String(price)
    }
    nameLabel.text = "이름"
    menuButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  func setimageView() {
    addSubview(menuButton)
    menuButton.backgroundColor = .systemBackground
  }
  
  func setMenuLabel() {
    addSubview(priceLabel)
    priceLabel.text = "가격"
    priceLabel.font = UIFont.boldSystemFont(ofSize: 15)
  }
  
  func setConstraints() {
    menuButton.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(20)
      make.leading.trailing.equalToSuperview()
    }
    
    nameLabel.snp.makeConstraints { make in
      make.top.equalTo(menuButton.snp.bottom).offset(5)
      make.leading.equalToSuperview().inset(40)
    }
    
    priceLabel.snp.makeConstraints { make in
      make.top.equalTo(nameLabel.snp.bottom).offset(5)
      make.leading.equalToSuperview().inset(40)
    }
  }
  
  @objc func buttonClicked() {
    print("1")
  }
}
