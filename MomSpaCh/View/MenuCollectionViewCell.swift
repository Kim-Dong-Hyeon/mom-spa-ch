//
//  MenuCollectionViewCell.swift
//  MomSpaCh
//
//  Created by 김윤홍 on 7/3/24.
//

import UIKit

import SnapKit
protocol MenuCollectionViewCellDelegate: AnyObject {
  func addOrderList(_: String, _: String)
}
class MenuCollectionViewCell: UICollectionViewCell {
  weak var delegate: MenuCollectionViewCellDelegate?
  lazy var menuData = Data()
  static let identifier = "cell"
  
  private lazy var menuButton: UIButton = {
    var menuButton = UIButton()
    menuButton.backgroundColor = .systemBackground
    return menuButton
  }()
  
  private let priceLabel: UILabel = {
    var priceLabel = UILabel()
    priceLabel.font = UIFont.boldSystemFont(ofSize: 15)
    priceLabel.textColor = .systemPink
    return priceLabel
  }()
  
  private let nameLabel: UILabel = {
    var nameLabel = UILabel()
    nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
    nameLabel.textColor = .systemRed
    return nameLabel
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    [menuButton, priceLabel, nameLabel].forEach { contentView.addSubview($0) }
    setConstraints()
    menuButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(withImageName imageName: String, price: Int, name: String) {
    if let image = UIImage(named: imageName) {
      menuButton.setTitle(imageName, for: .normal)
      menuButton.setImage(image, for: .normal)
    }
    priceLabel.text = "\(price) 원"
    nameLabel.text = name
  }
  
  func setConstraints() {
    menuButton.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(10)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(100)
    }
    
    nameLabel.snp.makeConstraints { make in
      make.top.equalTo(menuButton.snp.bottom).offset(5)
      make.leading.trailing.equalToSuperview().inset(10)
      make.height.equalTo(15)
      
    }
    
    priceLabel.snp.makeConstraints { make in
      make.top.equalTo(nameLabel.snp.bottom).offset(5)
      make.leading.trailing.equalToSuperview().inset(10)
      make.height.equalTo(15)
    }
  }
  

  @objc func buttonClicked(sender: UIButton) {
    var price = priceLabel.text!.filter { $0 != "원" && $0 != " "}
    var name = nameLabel.text!
    print(name)
    delegate?.addOrderList(price, name)
    print("1")
    print(menuData.koreanName[sender.currentTitle!]!)
  }
}
